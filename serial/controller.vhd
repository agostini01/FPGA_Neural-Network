library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

use work.fixed_float_types.all; -- ieee_proposed for VHDL-93 version
use work.fixed_pkg.all; -- ieee_proposed for compatibility version

entity controller is 
	port (
		-- async receiver/transmitter com ports
		clk		:	in	std_logic;
		rxReady	:	in	std_logic;
		rxData	:	in	std_logic_vector(7 downto 0); -- command string (character)
		txBusy	:	in	std_logic; 
		txStart	:	out std_logic; 
		txData	:	out std_logic_vector(7 downto 0);		
		
		-- LEDs (for debugging)
		LEDR		: 	out std_logic_vector (17 downto 0);
		
		-- control ports
		NN_start		: 	out std_logic;		-- 0 - stop / 1 - start neural net
		NN_sample	:	out std_logic_vector (8 downto 0);
		NN_result	:	in std_logic_vector (1 downto 0);
		NN_expected	:	in std_logic_vector (1 downto 0);
		NN_ready		:	in std_logic
	);
		
end controller;

architecture behaviour of controller is
					
	constant MSG_BEGIN_STR 	: string := 	LF & CR & "Welcome to FPGA_Neural-Network! Press r/R to run: ";
	constant MSG_RESULT1_STR: string :=		LF & CR & "Neural Net result: ";
	constant MSG_RESULT2_STR: string :=		" Correct result: ";
	constant MSG_ERROR1_STR : string := 	LF & CR & "Number of errors: ";
	constant MSG_ERROR2_STR : string :=		"/178";
	
	type T_MESSAGE is (
		MSG_BEGIN,
		MSG_RESULT,
		MSG_ERROR
	);

	-- define the states of controller
	type T_STATE is (
		s_begin,
		s_load_sample,
		s_wait_load,		-- wait until loading is done
		s_print,				-- print last result
		s_wait_print,		-- wait until loading is done
		s_error_print,		-- print number of errors
		s_error_wait,		-- wait until number of errors printing is done
		s_end
	);
	
	-- define the states of controller
	type T_MSG_STATE is (
		s_idle,		-- does nothing
		s_read, 		-- wait for user input, printing it to the screen
		s_write1,	-- first write state
		s_write2		-- second write state
	);
	
	shared variable len		: integer := 1;
	shared variable message : T_MESSAGE := MSG_BEGIN;
	shared variable ioCount : integer := 0;
	shared variable data 	: string(1 to 256);
	shared variable result	: string(1 to 2);
	shared variable expected: string(1 to 2);
	
	signal error_count	:	integer range 0 to 178;
	signal sample_count	: 	integer range 0 to 178;
	signal start			:	std_logic;
	signal state			:	T_STATE := s_begin;
	signal msg_state		: 	T_MSG_STATE := s_read;
		
	begin
	
	-- combinational logic
	with state select
		NN_start 	<= '1' when s_load_sample,
							'0' when others;

	NN_sample <= conv_std_logic_vector(sample_count, 9);
	
	-- handles control and serial logic
	state_reg : process(clk)
	begin
		if (clk'event and clk='1') then
			case state is
			
				when s_begin =>
					error_count <= 0;
					if start = '0' then
						state <= s_begin;
					else
						state <= s_load_sample;
					end if;
					
				when s_load_sample =>
					if sample_count >= 178 then
						state <= s_error_print;
					else
						sample_count <= sample_count + 1;
						state <= s_wait_load;
					end if;
					
				when s_wait_load =>
					if NN_ready = '1' then
						state <= s_print;
						if NN_result /= NN_expected then
							error_count <= error_count + 1;
						end if;
					else
						state <= s_wait_load;
					end if;
				
				when s_print =>
					message := MSG_RESULT;
					msg_state <= s_write1;
					state <= s_wait_print;

				when s_wait_print =>
					if msg_state = s_idle then
						state <= s_load_sample;
					else
						state <= s_wait_print;
					end if;
					
				when s_error_print =>
					message := MSG_ERROR;
					msg_state <= s_write1;
					state <= s_error_wait;
				
				when s_error_wait =>
					if msg_state = s_idle then
						state <= s_end;
					else
						state <= s_error_wait;
					end if;
				
				when s_end =>
					state <= s_end;
					
				when others =>
					null;
					
			end case;

			-- select message to write on screen
			data := (others => '0');
			case message is
				when MSG_BEGIN => len := MSG_BEGIN_STR'length; data(1 to len) := MSG_BEGIN_STR;
				when MSG_RESULT => len := MSG_RESULT1_STR'length + MSG_RESULT2_STR'length; data(1 to len + 4) := MSG_RESULT1_STR & result & MSG_RESULT2_STR & expected;
				when MSG_ERROR => len := MSG_ERROR1_STR'length + MSG_ERROR2_STR'length; data(1 to len + integer'image(error_count)'length) := MSG_ERROR1_STR & integer'image(error_count) & MSG_RESULT2_STR;
				when others => null;
			end case;
			
			case msg_state is
				-- read user command (rxData)

				when s_idle =>
					null;
					
				when s_read =>
				
					-- wait for character (rxReady)
					if(rxReady = '1') then
						
						-- generate a start pulse if user selects r/R
						if(rxData = "01110010" or rxData = "01010010") then -- number r/R
							start <= '1';		
						end if;
						
						msg_state <= s_write1;
						
					end if;
					
				-- output string
				when s_write1 =>
					if (txBusy = '0') then
						txData <=  std_logic_vector(to_unsigned(character'pos(data(ioCount)),8));
						txStart <= '1';
						msg_state <= s_write2;
					end if;
					
				-- output string
				when s_write2 =>
					txStart <= '0';
					if (ioCount < len) then
						ioCount := ioCount + 1;
						msg_state <= s_write1;
					else
						ioCount := 0;
						msg_state <= s_idle;
					end if;
					
				when others =>
					null;
					
			end case;
		end if;
   end process;	
end behaviour;