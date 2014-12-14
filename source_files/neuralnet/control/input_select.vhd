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
--	FILE NAME			: input_select.vhd
--	PROJECT				: FPGA_NEURAL-Network
--	ENTITY				: INPUT_SELECT
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

--=============================================================================
-- Entity declaration for INPUT_SELECT
--=============================================================================
entity INPUT_SELECT is 
	port (
		CLK				:	in std_logic;
		SAMPLE_NUMBER 	: 	in std_logic_vector (7 downto 0);
		NN_INPUT			: 	out ARRAY_OF_SFIXED;
		TARGET_VALUE	: 	out ARRAY_OF_SFIXED
	);
end INPUT_SELECT;

--=============================================================================
-- architecture declaration
--=============================================================================
architecture STRUCTURE of INPUT_SELECT is

	-- Signals
	signal   SELECTED_INPUT 									: ARRAY_OF_SFIXED (0 to (PERCEPTRONS_INPUT-1+PERCEPTRONS_OUTPUT));
	
	-- Components
	component INPUT_ROM
		port	(
				CLK				:	in std_logic;
				SAMPLE_NUMBER 	: 	in std_logic_vector (7 downto 0);
				SELECTED_INPUT	: 	out ARRAY_OF_SFIXED
				);
					
	end component;
	
	
--=============================================================================
-- architecture begin
--=============================================================================	
	begin
	
		GEN_PROPER_INPUT: 
		for I in 0 to (PERCEPTRONS_INPUT-1) generate
			NN_INPUT(I)<=
				SELECTED_INPUT(I);
								
		end generate GEN_PROPER_INPUT;
		
		GEN_PROPER_TARGET: 
		for I in 0 to (PERCEPTRONS_OUTPUT-1) generate
			TARGET_VALUE(I)<=
				SELECTED_INPUT(I+PERCEPTRONS_INPUT);
								
		end generate GEN_PROPER_TARGET;
	
	ROM: INPUT_ROM 
		port map		(
						CLK					=>	CLK,
						SAMPLE_NUMBER 		=>	SAMPLE_NUMBER,
						SELECTED_INPUT		=> SELECTED_INPUT
						);


end STRUCTURE;
--=============================================================================
-- architecture end
--=============================================================================