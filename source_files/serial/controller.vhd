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
		leds		: 	out std_logic_vector (17 downto 0);
		
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
	constant MSG_RESULT1_STR: string :=		" - neural net result: ";
	constant MSG_RESULT2_STR: string :=		" / correct result: ";
	constant MSG_ERROR1_STR : string := 	LF & LF & CR & "Number of errors: ";
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
		s_error,				-- print number of errors
		s_end,
		
		-- serial i/o states
		s_read,
		s_write1,
		s_write2
	);
	
	shared variable len			: integer := 1;
	shared variable message 	: T_MESSAGE := MSG_BEGIN;
	shared variable ioCount 	: integer := 0;
	shared variable data 		: string(1 to 256);
	shared variable result		: string(1 to 2);
	shared variable expected	: string(1 to 2);
	shared variable error_str	: string(1 to 3);
	shared variable sample_str	: string(1 to 3);
	
	signal error_count	:	integer range 0 to 178;
	signal sample_count	: 	integer range 0 to 178;
	signal state			:	T_STATE := s_begin;
	signal next_state		:	T_STATE := s_begin;
	
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
					message := MSG_BEGIN;	-- welcome message
					state <= s_write1;		-- write it
					next_state	<= s_read;	-- after writing waits for user input
					leds(9 downto 0) <= "0000000001"; --0
					error_count <= 0;
					
				when s_load_sample =>	-- loads one sample
					leds(9 downto 0) <= "0000000010"; --1
					if sample_count >= 178 then
						state <= s_error;
					else
						sample_count <= sample_count + 1;
						state <= s_wait_load;
					end if;
					
				when s_wait_load =>	-- waits for NN to finish calculating		
					leds(9 downto 0) <= "0000000100"; --2
					if NN_ready = '1' then
						state <= s_print;	-- prints the result
						if NN_result /= NN_expected then
							error_count <= error_count + 1;
						end if;
					else
						state <= s_wait_load;
					end if;
				
				when s_print =>
					leds(9 downto 0) <= "0000001000"; --3
					message := MSG_RESULT;
					state <= s_write1;				-- prints result for one sample
					next_state <= s_load_sample;	-- after printing load next sample
					
				when s_error =>
					leds(9 downto 0) <= "0000010000"; --4
					message := MSG_ERROR;
					state <= s_write1;		-- prints number of erros
					next_state <= s_end;		-- after printing go to final state
					
				when s_end =>
					leds(9 downto 0) <= "0000100000"; --5
					state <= s_end;
				
				when s_read => -- read user command (rxData)
					leds(9 downto 0) <= "0001000000"; --6
				
					-- wait for character (rxReady)
					if(rxReady = '1') then
						
						-- generate a start pulse if user selects r/R
						if(rxData = "01110010" or rxData = "01010010") then -- r/R (72/52 in hex)
							state <= s_load_sample;	-- run neural net	
						end if;
											
					end if;
					
				-- output string
				when s_write1 =>
					leds(9 downto 0) <= "0010000000"; --7
					if (txBusy = '0') then
						if (len > 1 and data(1) /= '0') then
							txData <=  std_logic_vector(to_unsigned(character'pos(data(ioCount)),8));
							txStart <= '1';
							state <= s_write2;
						else
							state <= next_state;
						end if;
					end if;
					
				-- output string
				when s_write2 =>
					leds(9 downto 0) <= "0100000000"; --8
					txStart <= '0';
					if (ioCount < len) then
						ioCount := ioCount + 1;
						state <= s_write1;
					else
						ioCount := 0;
						state <= next_state; -- go to next_state in the FSM list
					end if;				
					
				when others =>
					leds(9 downto 0) <= "1000000000"; --9
					null;
					
			end case;
					
			case NN_result is
				when "00" => result := "00";
				when "01" => result := "01";
				when "10" => result := "10";
				when "11" => result := "11";
			end case;
		
			case NN_expected is
				when "00" => expected := "00";
				when "01" => expected := "01";
				when "10" => expected := "10";
				when "11" => expected := "11";
			end case;
			
			case sample_count is
				when 0 => sample_str := "000";
				when 1 => sample_str := "001";
				when 2 => sample_str := "002";
				when 3 => sample_str := "003";
				when 4 => sample_str := "004";
				when 5 => sample_str := "005";
				when 6 => sample_str := "006";
				when 7 => sample_str := "007";
				when 8 => sample_str := "008";
				when 9 => sample_str := "009";
				when 10 => sample_str := "010";
				when 11 => sample_str := "011";
				when 12 => sample_str := "012";
				when 13 => sample_str := "013";
				when 14 => sample_str := "014";
				when 15 => sample_str := "015";
				when 16 => sample_str := "016";
				when 17 => sample_str := "017";
				when 18 => sample_str := "018";
				when 19 => sample_str := "019";
				when 20 => sample_str := "020";
				when 21 => sample_str := "021";
				when 22 => sample_str := "022";
				when 23 => sample_str := "023";
				when 24 => sample_str := "024";
				when 25 => sample_str := "025";
				when 26 => sample_str := "026";
				when 27 => sample_str := "027";
				when 28 => sample_str := "028";
				when 29 => sample_str := "029";
				when 30 => sample_str := "030";
				when 31 => sample_str := "031";
				when 32 => sample_str := "032";
				when 33 => sample_str := "033";
				when 34 => sample_str := "034";
				when 35 => sample_str := "035";
				when 36 => sample_str := "036";
				when 37 => sample_str := "037";
				when 38 => sample_str := "038";
				when 39 => sample_str := "039";
				when 40 => sample_str := "040";
				when 41 => sample_str := "041";
				when 42 => sample_str := "042";
				when 43 => sample_str := "043";
				when 44 => sample_str := "044";
				when 45 => sample_str := "045";
				when 46 => sample_str := "046";
				when 47 => sample_str := "047";
				when 48 => sample_str := "048";
				when 49 => sample_str := "049";
				when 50 => sample_str := "050";
				when 51 => sample_str := "051";
				when 52 => sample_str := "052";
				when 53 => sample_str := "053";
				when 54 => sample_str := "054";
				when 55 => sample_str := "055";
				when 56 => sample_str := "056";
				when 57 => sample_str := "057";
				when 58 => sample_str := "058";
				when 59 => sample_str := "059";
				when 60 => sample_str := "060";
				when 61 => sample_str := "061";
				when 62 => sample_str := "062";
				when 63 => sample_str := "063";
				when 64 => sample_str := "064";
				when 65 => sample_str := "065";
				when 66 => sample_str := "066";
				when 67 => sample_str := "067";
				when 68 => sample_str := "068";
				when 69 => sample_str := "069";
				when 70 => sample_str := "070";
				when 71 => sample_str := "071";
				when 72 => sample_str := "072";
				when 73 => sample_str := "073";
				when 74 => sample_str := "074";
				when 75 => sample_str := "075";
				when 76 => sample_str := "076";
				when 77 => sample_str := "077";
				when 78 => sample_str := "078";
				when 79 => sample_str := "079";
				when 80 => sample_str := "080";
				when 81 => sample_str := "081";
				when 82 => sample_str := "082";
				when 83 => sample_str := "083";
				when 84 => sample_str := "084";
				when 85 => sample_str := "085";
				when 86 => sample_str := "086";
				when 87 => sample_str := "087";
				when 88 => sample_str := "088";
				when 89 => sample_str := "089";
				when 90 => sample_str := "090";
				when 91 => sample_str := "091";
				when 92 => sample_str := "092";
				when 93 => sample_str := "093";
				when 94 => sample_str := "094";
				when 95 => sample_str := "095";
				when 96 => sample_str := "096";
				when 97 => sample_str := "097";
				when 98 => sample_str := "098";
				when 99 => sample_str := "099";
				when 100 => sample_str := "100";
				when 101 => sample_str := "101";
				when 102 => sample_str := "102";
				when 103 => sample_str := "103";
				when 104 => sample_str := "104";
				when 105 => sample_str := "105";
				when 106 => sample_str := "106";
				when 107 => sample_str := "107";
				when 108 => sample_str := "108";
				when 109 => sample_str := "109";
				when 110 => sample_str := "110";
				when 111 => sample_str := "111";
				when 112 => sample_str := "112";
				when 113 => sample_str := "113";
				when 114 => sample_str := "114";
				when 115 => sample_str := "115";
				when 116 => sample_str := "116";
				when 117 => sample_str := "117";
				when 118 => sample_str := "118";
				when 119 => sample_str := "119";
				when 120 => sample_str := "120";
				when 121 => sample_str := "121";
				when 122 => sample_str := "122";
				when 123 => sample_str := "123";
				when 124 => sample_str := "124";
				when 125 => sample_str := "125";
				when 126 => sample_str := "126";
				when 127 => sample_str := "127";
				when 128 => sample_str := "128";
				when 129 => sample_str := "129";
				when 130 => sample_str := "130";
				when 131 => sample_str := "131";
				when 132 => sample_str := "132";
				when 133 => sample_str := "133";
				when 134 => sample_str := "134";
				when 135 => sample_str := "135";
				when 136 => sample_str := "136";
				when 137 => sample_str := "137";
				when 138 => sample_str := "138";
				when 139 => sample_str := "139";
				when 140 => sample_str := "140";
				when 141 => sample_str := "141";
				when 142 => sample_str := "142";
				when 143 => sample_str := "143";
				when 144 => sample_str := "144";
				when 145 => sample_str := "145";
				when 146 => sample_str := "146";
				when 147 => sample_str := "147";
				when 148 => sample_str := "148";
				when 149 => sample_str := "149";
				when 150 => sample_str := "150";
				when 151 => sample_str := "151";
				when 152 => sample_str := "152";
				when 153 => sample_str := "153";
				when 154 => sample_str := "154";
				when 155 => sample_str := "155";
				when 156 => sample_str := "156";
				when 157 => sample_str := "157";
				when 158 => sample_str := "158";
				when 159 => sample_str := "159";
				when 160 => sample_str := "160";
				when 161 => sample_str := "161";
				when 162 => sample_str := "162";
				when 163 => sample_str := "163";
				when 164 => sample_str := "164";
				when 165 => sample_str := "165";
				when 166 => sample_str := "166";
				when 167 => sample_str := "167";
				when 168 => sample_str := "168";
				when 169 => sample_str := "169";
				when 170 => sample_str := "170";
				when 171 => sample_str := "171";
				when 172 => sample_str := "172";
				when 173 => sample_str := "173";
				when 174 => sample_str := "174";
				when 175 => sample_str := "175";
				when 176 => sample_str := "176";
				when 177 => sample_str := "177";
				when 178 => sample_str := "178";
			end case;

			case error_count is
				when 0 => error_str := "000";
				when 1 => error_str := "001";
				when 2 => error_str := "002";
				when 3 => error_str := "003";
				when 4 => error_str := "004";
				when 5 => error_str := "005";
				when 6 => error_str := "006";
				when 7 => error_str := "007";
				when 8 => error_str := "008";
				when 9 => error_str := "009";
				when 10 => error_str := "010";
				when 11 => error_str := "011";
				when 12 => error_str := "012";
				when 13 => error_str := "013";
				when 14 => error_str := "014";
				when 15 => error_str := "015";
				when 16 => error_str := "016";
				when 17 => error_str := "017";
				when 18 => error_str := "018";
				when 19 => error_str := "019";
				when 20 => error_str := "020";
				when 21 => error_str := "021";
				when 22 => error_str := "022";
				when 23 => error_str := "023";
				when 24 => error_str := "024";
				when 25 => error_str := "025";
				when 26 => error_str := "026";
				when 27 => error_str := "027";
				when 28 => error_str := "028";
				when 29 => error_str := "029";
				when 30 => error_str := "030";
				when 31 => error_str := "031";
				when 32 => error_str := "032";
				when 33 => error_str := "033";
				when 34 => error_str := "034";
				when 35 => error_str := "035";
				when 36 => error_str := "036";
				when 37 => error_str := "037";
				when 38 => error_str := "038";
				when 39 => error_str := "039";
				when 40 => error_str := "040";
				when 41 => error_str := "041";
				when 42 => error_str := "042";
				when 43 => error_str := "043";
				when 44 => error_str := "044";
				when 45 => error_str := "045";
				when 46 => error_str := "046";
				when 47 => error_str := "047";
				when 48 => error_str := "048";
				when 49 => error_str := "049";
				when 50 => error_str := "050";
				when 51 => error_str := "051";
				when 52 => error_str := "052";
				when 53 => error_str := "053";
				when 54 => error_str := "054";
				when 55 => error_str := "055";
				when 56 => error_str := "056";
				when 57 => error_str := "057";
				when 58 => error_str := "058";
				when 59 => error_str := "059";
				when 60 => error_str := "060";
				when 61 => error_str := "061";
				when 62 => error_str := "062";
				when 63 => error_str := "063";
				when 64 => error_str := "064";
				when 65 => error_str := "065";
				when 66 => error_str := "066";
				when 67 => error_str := "067";
				when 68 => error_str := "068";
				when 69 => error_str := "069";
				when 70 => error_str := "070";
				when 71 => error_str := "071";
				when 72 => error_str := "072";
				when 73 => error_str := "073";
				when 74 => error_str := "074";
				when 75 => error_str := "075";
				when 76 => error_str := "076";
				when 77 => error_str := "077";
				when 78 => error_str := "078";
				when 79 => error_str := "079";
				when 80 => error_str := "080";
				when 81 => error_str := "081";
				when 82 => error_str := "082";
				when 83 => error_str := "083";
				when 84 => error_str := "084";
				when 85 => error_str := "085";
				when 86 => error_str := "086";
				when 87 => error_str := "087";
				when 88 => error_str := "088";
				when 89 => error_str := "089";
				when 90 => error_str := "090";
				when 91 => error_str := "091";
				when 92 => error_str := "092";
				when 93 => error_str := "093";
				when 94 => error_str := "094";
				when 95 => error_str := "095";
				when 96 => error_str := "096";
				when 97 => error_str := "097";
				when 98 => error_str := "098";
				when 99 => error_str := "099";
				when 100 => error_str := "100";
				when 101 => error_str := "101";
				when 102 => error_str := "102";
				when 103 => error_str := "103";
				when 104 => error_str := "104";
				when 105 => error_str := "105";
				when 106 => error_str := "106";
				when 107 => error_str := "107";
				when 108 => error_str := "108";
				when 109 => error_str := "109";
				when 110 => error_str := "110";
				when 111 => error_str := "111";
				when 112 => error_str := "112";
				when 113 => error_str := "113";
				when 114 => error_str := "114";
				when 115 => error_str := "115";
				when 116 => error_str := "116";
				when 117 => error_str := "117";
				when 118 => error_str := "118";
				when 119 => error_str := "119";
				when 120 => error_str := "120";
				when 121 => error_str := "121";
				when 122 => error_str := "122";
				when 123 => error_str := "123";
				when 124 => error_str := "124";
				when 125 => error_str := "125";
				when 126 => error_str := "126";
				when 127 => error_str := "127";
				when 128 => error_str := "128";
				when 129 => error_str := "129";
				when 130 => error_str := "130";
				when 131 => error_str := "131";
				when 132 => error_str := "132";
				when 133 => error_str := "133";
				when 134 => error_str := "134";
				when 135 => error_str := "135";
				when 136 => error_str := "136";
				when 137 => error_str := "137";
				when 138 => error_str := "138";
				when 139 => error_str := "139";
				when 140 => error_str := "140";
				when 141 => error_str := "141";
				when 142 => error_str := "142";
				when 143 => error_str := "143";
				when 144 => error_str := "144";
				when 145 => error_str := "145";
				when 146 => error_str := "146";
				when 147 => error_str := "147";
				when 148 => error_str := "148";
				when 149 => error_str := "149";
				when 150 => error_str := "150";
				when 151 => error_str := "151";
				when 152 => error_str := "152";
				when 153 => error_str := "153";
				when 154 => error_str := "154";
				when 155 => error_str := "155";
				when 156 => error_str := "156";
				when 157 => error_str := "157";
				when 158 => error_str := "158";
				when 159 => error_str := "159";
				when 160 => error_str := "160";
				when 161 => error_str := "161";
				when 162 => error_str := "162";
				when 163 => error_str := "163";
				when 164 => error_str := "164";
				when 165 => error_str := "165";
				when 166 => error_str := "166";
				when 167 => error_str := "167";
				when 168 => error_str := "168";
				when 169 => error_str := "169";
				when 170 => error_str := "170";
				when 171 => error_str := "171";
				when 172 => error_str := "172";
				when 173 => error_str := "173";
				when 174 => error_str := "174";
				when 175 => error_str := "175";
				when 176 => error_str := "176";
				when 177 => error_str := "177";
				when 178 => error_str := "178";
			end case;

			-- select message to write on screen
			len := 0;
			data := (others => '0');
			case message is
				when MSG_BEGIN => 
					len := MSG_BEGIN_STR'length; 
					data(1 to len) := MSG_BEGIN_STR;
				when MSG_RESULT => 
					len := MSG_RESULT1_STR'length + MSG_RESULT2_STR'length + sample_str'length + 9; 
					data(1 to len) := LF & CR & sample_str & MSG_RESULT1_STR & result & MSG_RESULT2_STR & expected & " : ";
				when MSG_ERROR => 
					len := MSG_ERROR1_STR'length + MSG_ERROR2_STR'length + error_str'length; 
					data(1 to len) := MSG_ERROR1_STR & error_str & MSG_ERROR2_STR;
				when others => null;
			end case;
			
		end if;
   end process;	
end behaviour;
--=============================================================================
-- architecture end
--=============================================================================