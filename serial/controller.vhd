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
		LEDR		: 	out std_logic_vector (17 downto 0)
		);
		
end controller;

architecture behaviour of controller is

	constant MSG_NONE_STR 	: string := 	"";
														
	constant MSG_BEGIN_STR 	: string := 	LF & CR & "Welcome to FPGA_Neural-Network! Please select an option:" & 
														LF & CR & "[1] Load pre-calculated weights" &
														LF & CR & "[2] Train neural net" &
														LF & CR & "[3] Quit" &
														LF & LF & CR & "Selection: ";
	constant MSG_ERROR_STR 	: string := 	LF & CR & "Error!";
  
	type T_MESSAGE is (
		MSG_NONE,
		MSG_BEGIN,
		MSG_ERROR
		);

	-- define the states of controller
	type T_STATE is (
		begin_state,
		r_state, 
		w1_state,
		w2_state
		);
	
	shared variable len		: integer := 1;
	shared variable message : T_MESSAGE := MSG_BEGIN;
	shared variable ioCount : integer := 0;
	shared variable verbose : std_logic_vector(7 downto 0);
	shared variable data : string(1 to 256);
	
	signal state	: 	T_STATE := begin_state;
		
	begin
	
  	state_reg: process(clk)
   begin
		if (clk'event and clk='1') then
			
			-- select message to write on screen
			data := (others => '0');
			case message is
				when MSG_NONE => len := MSG_NONE_STR'length; data(1 to len) := MSG_NONE_STR;
				when MSG_BEGIN => len := MSG_BEGIN_STR'length; data(1 to len) := MSG_BEGIN_STR;
				when MSG_ERROR => len := MSG_ERROR_STR'length; data(1 to len) := MSG_ERROR_STR;
				when others => len := MSG_ERROR_STR'length; data(1 to len) := MSG_ERROR_STR;
			end case;
			
			case state is
				-- read user command (rxData)
				when begin_state =>
					message := MSG_BEGIN;
					state <= w1_state;
					
				when r_state =>
				
					-- wait for character (rxReady)
					if(rxReady = '1') then
						
						verbose := rxData; -- save last command	
					
						if(rxData = "00110001") then
							message := MSG_BEGIN;		
						elsif(rxData = "00110010") then
							message := MSG_ERROR;
						else
							message := MSG_NONE;
						end if;
						
						state <= w1_state;
						
					end if;
					
				-- output string
				when w1_state =>
					if (txBusy = '0') then
						if (ioCount = 0) then
							txData <= verbose;
							txStart <= '1';
							state <= w2_state;
						else
							txData <=  std_logic_vector(to_unsigned(character'pos(data(ioCount)),8));
							txStart <= '1';
							state <= w2_state;
						end if;
					end if;
					
				-- output string
				when w2_state =>
					txStart <= '0';
					if (ioCount < len) then
						ioCount := ioCount + 1;
						state <= w1_state;
					else
						ioCount := 0;
						state <= r_state;
					end if;
					
				when others =>
					null;
					
			end case;
		end if;
   end process;	
end behaviour;