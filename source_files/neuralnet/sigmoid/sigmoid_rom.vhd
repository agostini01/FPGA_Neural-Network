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
--		if not, see <http://www.gnu.org/licenses/>.

--=============================================================================
--	FILE NAME			: SIGMOID_ROM.vhd
--	PROJECT				: FPGA_NEURAL-Network
--	ENTITY				: SIGMOID_ROM
--	ARCHITECTURE		: rtl
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
	use work.NN_TYPES_pkg.all;
	use work.SIGMOID_ROM_pkg.all;

--=============================================================================
-- Entity declaration for SIGMOID_ROM
--=============================================================================
entity SIGMOID_ROM is 
	port (
		clk				:	in std_logic;
		X_VALUE 			: 	in std_logic_vector (13 downto 0);
		Y_VALUE			: 	out CONSTRAINED_SFIXED
	);
end SIGMOID_ROM;

--=============================================================================
-- architecture declaration
--=============================================================================
architecture RTL of SIGMOID_ROM is
-- Constants

			


	  -- Signals
	signal IN_UNSIGNED						: unsigned(13 downto 0);
	signal LOOKUP_TABLE_K 					: unsigned(13 downto 0);
	signal LOOKUP_TABLE_OUT 				: sfixed;
	signal LOOKUP_TABLE_OUT_CONSTRAINED	: CONSTRAINED_SFIXED;
	signal UNIT_DELAY_OUT					: CONSTRAINED_SFIXED;
	
	
--=============================================================================
-- architecture begin
--=============================================================================	
	begin
		IN_UNSIGNED <= unsigned(X_VALUE);
		LOOKUP_TABLE_K <= -- Make sure no index will fall out of boundary
			to_unsigned(0, 14) when IN_UNSIGNED <= 0 
		else
			to_unsigned(VECTOR_SIZE, 14) when IN_UNSIGNED >= VECTOR_SIZE 
		else
			IN_UNSIGNED;
  
		LOOKUP_TABLE_OUT <= CONSTRAINED_SFIXED(LOOKUP_TABLE_K);
		
		
		
		LOOKUP_TABLE_OUT_CONSTRAINED<=
			resize(LOOKUP_TABLE_OUT,U_SIZE,L_SIZE);
		

		UNIT_DELAY_PROCESS : process (clk)
			
			begin
				if CLK'event and CLK = '1' then
				UNIT_DELAY_OUT <= LOOKUP_TABLE_OUT_CONSTRAINED;
				end if;
		
		end process UNIT_DELAY_PROCESS;


		Y_VALUE <= UNIT_DELAY_OUT;
end RTL;
--=============================================================================
-- architecture end
--=============================================================================
