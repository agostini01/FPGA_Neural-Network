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
--	ENTITY				: SIGMOID_SELECT
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
-- Entity declaration for SIGMOID_SELECT
--=============================================================================
entity SIGMOID_SELECT is 
	port (
		CLK				:	in std_logic;
		X_VALUE 			: 	in CONSTRAINED_SFIXED;
		Y_VALUE			: 	out CONSTRAINED_SFIXED
	);
end SIGMOID_SELECT;

--=============================================================================
-- architecture declaration
--=============================================================================
architecture STRUCTURE of SIGMOID_SELECT is

	-- Signals
	signal SAMPLE_NUMBER	: std_logic_vector;
	-- Components
	component SIGMOID_ROM
		port	(
				clk				:	in std_logic;
				X_VALUE 			: 	in std_logic_vector (13 downto 0);
				Y_VALUE			: 	out CONSTRAINED_SFIXED
				);
					
	end component;
	
	
--=============================================================================
-- architecture begin
--=============================================================================	
	begin
	
	GEN_PROPER_SAMPLE_NUMBER: -- TODO!
		for I in 0 to (13) generate
			SAMPLE_NUMBER(I)<=
				X_VALUE(I);
								
		end generate GEN_PROPER_SAMPLE_NUMBER;
	
	ROM: SIGMOID_ROM 
		port map		(
						CLK				=>	CLK,
						X_VALUE 			=>	SAMPLE_NUMBER,
						Y_VALUE			=> Y_VALUE
						);


end STRUCTURE;
--=============================================================================
-- architecture end
--=============================================================================