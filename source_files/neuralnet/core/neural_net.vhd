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
--	FILE NAME			: neural_net.vhd
--	PROJECT				: FPGA_NEURAL-Network
--	ENTITY				: NEURAL_NET
--	ARCHITECTURE		: structure
--=============================================================================
--	AUTORS(s)			: Agostini, N
--	DEPARTMENT      	: Electrical Engineering (UFRGS)
--	DATE					: NOV 28, 2014
--=============================================================================
--	Description:
--	
--=============================================================================

library ieee;
use ieee.std_logic_1164.all;

--=============================================================================
-- Entity declaration for NEURAL_NET
--=============================================================================
entity NEURAL_NET is
	port	(
			INPUT1, INPUT2, INPUT3, INPUT4				:in integer range -5 to 5;
			CONTROL_IN, CONTROL_HIDDEN, CONTROL_OUT	:in std_logic;
			OUTPUT1, OUTPUT2, OUTPUT3, OUTPUT4			:out integer;
			START, CLK											:in std_logic			
			);
end NEURAL_NET;

--=============================================================================
-- architecture declaration
--=============================================================================
architecture STRUCTURE of NEURAL_NET is
	signal FIRST1, FIRST2, FIRST3, FIRST4 				:integer range -5 to 5;
	signal SECOND1, SECOND2, SECOND3, SECOND4 		:integer;
	signal THIRD1, THIRD2, THIRD3, THIRD4 				:integer;
	
	component LAYER
		port	(
				INPUT1, INPUT2, INPUT3, INPUT4			:in integer range -5 to 5;
				CONTROL											:in std_logic;
				OUTPUT1, OUTPUT2, OUTPUT3, OUTPUT4 		:out integer
				);
	end component;
	
	type STATE_TYPE is(S0, S1, S2, S3);

--=============================================================================
-- architecture begin
--=============================================================================		
	begin
	   FIRST1 <= INPUT1;
		FIRST2 <= INPUT2;
		FIRST3 <= INPUT3;
		FIRST4 <= INPUT4;
		
		INPUT_LAYER: LAYER port map	(
												FIRST1, FIRST2, FIRST3, FIRST4,
												CONTROL_IN,
												SECOND1, SECOND2, SECOND3, SECOND4
												);
		HIDDEN_LAYER: LAYER port map	(
												SECOND1, SECOND2, SECOND3, SECOND4,
												CONTROL_HIDDEN,
												THIRD1, THIRD2, THIRD3, THIRD4
												);
		OUT_LAYER: LAYER port map		(
												THIRD1, THIRD2, THIRD3, THIRD4,
												CONTROL_OUT,
												OUTPUT1, OUTPUT2, OUTPUT3, OUTPUT4
												);

	
end STRUCTURE;
--=============================================================================
-- architecture end
--=============================================================================