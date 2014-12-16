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
--	FILE NAME			: output_control.vhd
--	PROJECT				: FPGA_NEURAL-Network
--	ENTITY				: OUTPUT_CONTROL
--	ARCHITECTURE		: structure
--=============================================================================
--	AUTORS(s)			: Agostini, N;
--	DEPARTMENT      	: Electrical Engineering (UFRGS)
--	DATE					: Dec 14, 2014
--=============================================================================
--	Description:
--	
--=============================================================================

library ieee;
use ieee.std_logic_1164.all;
use work.NN_TYPES_pkg.all;
use work.fixed_pkg.all; -- ieee_proposed for compatibility version
use ieee.numeric_std.all;

--=============================================================================
-- Entity declaration for OUTPUT_CONTROL
--=============================================================================
entity OUTPUT_CONTROL is 
	port (
		CLK				:	in std_logic;
		DATA_READY			:	in std_logic;
		OUTPUT_READY	:	out std_logic;
		NN_OUTPUT		: 	in ARRAY_OF_SFIXED;
		TARGET_VALUE	: 	in ARRAY_OF_SFIXED;
		NN_result 	: 	out std_logic_vector (1 downto 0);
		NN_expected	: 	out std_logic_vector (1 downto 0)
	);
end OUTPUT_CONTROL;

--=============================================================================
-- architecture declaration
--=============================================================================
architecture STRUCTURE of OUTPUT_CONTROL is

	-- Signals
	signal RESULT_TMP : std_logic_vector(1 downto 0);
	signal TARGET_TMP : std_logic_vector(1 downto 0);
	signal READY_1 : std_logic;
	signal READY_2 : std_logic;
	
	
--=============================================================================
-- architecture begin
--=============================================================================	
	begin

			
			
		OUTPUT_CONVERSION: process	(CLK,NN_OUTPUT,DATA_READY)
			begin
				if CLK'event and CLK ='1' then
					if DATA_READY='1' then
						READY_1<='0';
						if NN_OUTPUT(0)<=to_sfixed(0.5,U_SIZE,L_SIZE) 
							and NN_OUTPUT(1)<=to_sfixed(0.5,U_SIZE,L_SIZE)
							and NN_OUTPUT(2)<=to_sfixed(0.5,U_SIZE,L_SIZE) then	
							RESULT_TMP<=std_logic_vector(to_unsigned(0,2));
						elsif NN_OUTPUT(0)>to_sfixed(0.5,U_SIZE,L_SIZE) 
							and NN_OUTPUT(1)<=to_sfixed(0.5,U_SIZE,L_SIZE)
							and NN_OUTPUT(2)<=to_sfixed(0.5,U_SIZE,L_SIZE) then	
							RESULT_TMP<=std_logic_vector(to_unsigned(1,2));
						elsif NN_OUTPUT(0)<=to_sfixed(0.5,U_SIZE,L_SIZE) 
							and NN_OUTPUT(1)>to_sfixed(0.5,U_SIZE,L_SIZE)
							and NN_OUTPUT(2)<=to_sfixed(0.5,U_SIZE,L_SIZE) then	
							RESULT_TMP<=std_logic_vector(to_unsigned(2,2));
						elsif NN_OUTPUT(0)<=to_sfixed(0.5,U_SIZE,L_SIZE) 
							and NN_OUTPUT(1)<=to_sfixed(0.5,U_SIZE,L_SIZE)
							and NN_OUTPUT(2)>to_sfixed(0.5,U_SIZE,L_SIZE) then	
							RESULT_TMP<=std_logic_vector(to_unsigned(3,2));
						end if;
					
						READY_1<='1';
					else
						READY_1<='0';
					end if;
				end if;
		end process;
		
		TARGET_CONVERSION: process	(CLK,TARGET_VALUE,DATA_READY)
			begin
				if CLK'event and CLK ='1' then
					if DATA_READY='1' then
						READY_2<='0';
						if NN_OUTPUT(0)<=to_sfixed(0.5,U_SIZE,L_SIZE) 
							and TARGET_VALUE(1)<=to_sfixed(0.5,U_SIZE,L_SIZE)
							and TARGET_VALUE(2)<=to_sfixed(0.5,U_SIZE,L_SIZE) then	
							TARGET_TMP<=std_logic_vector(to_unsigned(0,2));
						elsif TARGET_VALUE(0)>to_sfixed(0.5,U_SIZE,L_SIZE) 
							and TARGET_VALUE(1)<=to_sfixed(0.5,U_SIZE,L_SIZE)
							and TARGET_VALUE(2)<=to_sfixed(0.5,U_SIZE,L_SIZE) then	
							TARGET_TMP<=std_logic_vector(to_unsigned(1,2));
						elsif TARGET_VALUE(0)<=to_sfixed(0.5,U_SIZE,L_SIZE) 
							and TARGET_VALUE(1)>to_sfixed(0.5,U_SIZE,L_SIZE)
							and TARGET_VALUE(2)<=to_sfixed(0.5,U_SIZE,L_SIZE) then	
							TARGET_TMP<=std_logic_vector(to_unsigned(2,2));
						elsif TARGET_VALUE(0)<=to_sfixed(0.5,U_SIZE,L_SIZE) 
							and TARGET_VALUE(1)<=to_sfixed(0.5,U_SIZE,L_SIZE)
							and TARGET_VALUE(2)>to_sfixed(0.5,U_SIZE,L_SIZE) then	
							TARGET_TMP<=std_logic_vector(to_unsigned(3,2));
						end if;
						
						READY_2<='1';
					else
						READY_2<='0';
					end if;
				end if;
		end process;
		
		-- TODO!! correct readyness
		NN_result<=RESULT_TMP;
		NN_expected<=TARGET_TMP;
		OUTPUT_READY<=READY_1 and READY_2;


end STRUCTURE;
--=============================================================================
-- architecture end
--=============================================================================