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
use ieee.numeric_std.all; -- is the to unsigned really required????
use work.fixed_pkg.all; -- ieee_proposed for compatibility version
use work.SIGMOID_ROM_pkg.all;
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
	signal SAMPLE_NUMBER	: std_logic_vector ((NUMBER_OF_BITS-1) downto 0);
	signal IN_UNSIGNED 	: unsigned((NUMBER_OF_BITS-1) downto 0);
	-- Components
	component SIGMOID_ROM
		port	(
				clk				:	in std_logic;
				X_VALUE 			: 	in std_logic_vector ((NUMBER_OF_BITS-1) downto 0);
				Y_VALUE			: 	out CONSTRAINED_SFIXED
				);
					
	end component;
	
	
--=============================================================================
-- architecture begin
--=============================================================================	
	begin
	
	
	ROM: SIGMOID_ROM 
		port map		(
						CLK				=>	CLK,
						X_VALUE 			=>	SAMPLE_NUMBER,
						Y_VALUE			=> Y_VALUE
						);

	IN_UNSIGNED <= unsigned(to_slv(resize(X_VALUE,3,-(NUMBER_OF_BITS-4))));
	
	SAMPLE_NUMBER <= 
			std_logic_vector(to_unsigned(0, NUMBER_OF_BITS)) when X_VALUE <= -3 -- limits from the tansig function where it almost saturates
		else
			std_logic_vector(to_unsigned(VECTOR_SIZE, NUMBER_OF_BITS)) when X_VALUE >= 3 
		else
			std_logic_vector(IN_UNSIGNED);

end STRUCTURE;
--=============================================================================
-- architecture end
--=============================================================================