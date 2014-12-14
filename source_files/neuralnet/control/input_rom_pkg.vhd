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
--	FILE NAME			: input_rom_pkg.vhd
--	PROJECT				: FPGA_NEURAL-Network
--	PACKAGE				: INPUT_ROM_pkg
--=============================================================================
--	AUTORS(s)			: Agostini, N
--	DEPARTMENT      	: Electrical Engineering (UFRGS)
--	DATE					: Dec 14, 2014
--=============================================================================
--	Description:
--	
--=============================================================================

library ieee;
	use work.fixed_pkg.all; -- ieee_proposed for compatibility version
	use work.NN_TYPES_pkg.all;
	
--=============================================================================
-- Package declaration for INPUT_ROM_pkg
--=============================================================================
package INPUT_ROM_pkg is

		constant SAMPLE_SIZE	: natural := 178;
		
		subtype	INPUT_SFIXED 			is sfixed(1 downto L_SIZE);
		
		type 		INPUT_ARRAY 			is array (natural range <>) of INPUT_SFIXED;
		subtype	INPUT_LOOKUP_ARRAY	is INPUT_ARRAY(0 to (PERCEPTRONS_INPUT-1+PERCEPTRONS_OUTPUT));
		type		INPUT_TABLE 			is array (natural range <>) of INPUT_ARRAY;
		
		subtype INPUT_CONSTRAINED_SFIXED_ARRAY is ARRAY_OF_SFIXED(0 to (PERCEPTRONS_INPUT-1+PERCEPTRONS_OUTPUT));
		
end;

--=============================================================================
-- package body declaration
--=============================================================================
package body INPUT_ROM_pkg is


end package body;