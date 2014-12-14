--=============================================================================
--    This file is part of FPGA_NEURAL-Network.
--
--    FPGA_NEURAL-Network is free software: you can redistribute it and/or 
--    modify it under the terms of the GNU General Public License as published 
--    by the Free Software Foundation, either version 3 of the License, or
--    (at your option) any later version.
--
--    FPGA_NEURAL-Network is distributed in the hope that it will be useful,
--    but WITHOUT ANY WARRANTY; without even the implied warranty of
--    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
--    GNU General Public License for more details.
--
--    You should have received a copy of the GNU General Public License
--    along with FPGA_NEURAL-Network.  
--		If not, see <http://www.gnu.org/licenses/>.

--=============================================================================
--	FILE NAME			: controller.vhd
--	PROJECT				: FPGA_NEURAL-Network
--	ENTITY				: controller
--	ARCHITECTURE		: behaviour
--=============================================================================
--	AUTORS(s)			: Barbosa, F
--	DEPARTMENT      	: Electrical Engineering (UFRGS)
--	DATE					: DEC 10, 2014
--=============================================================================
--	Description:
--	
--=============================================================================

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

--=============================================================================
-- Entity declaration for NN_INSTANCE
--=============================================================================
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
		NN_sample	:	out std_logic_vector (7 downto 0);
		NN_result	:	in std_logic_vector (1 downto 0);
		NN_expected	:	in std_logic_vector (1 downto 0);
		NN_ready		:	in std_logic
	);
		
end controller;

--=============================================================================
-- architecture declaration
--=============================================================================
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
	
--=============================================================================
-- architecture begin
--=============================================================================		
	begin
	
	-- combinational logic
	with state select
		NN_start 	<= '1' when s_load_sample,
							'0' when others;

	NN_sample <= conv_std_logic_vector(sample_count, 8);
	
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
--=============================================================================
-- architecture end
--=============================================================================