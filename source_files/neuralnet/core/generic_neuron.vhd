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
--	FILE NAME			: generic_neuron.vhd
--	PROJECT				: FPGA_NEURAL-Network
--	ENTITY				: GENERIC_NEURON
--	ARCHITECTURE		: behaviour
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
use work.fixed_pkg.all; -- ieee_proposed for compatibility version
use work.NN_TYPES_pkg.all;

--=============================================================================
-- Entity declaration for GENERIC_NEURON
--=============================================================================
entity GENERIC_NEURON is
	generic	(
				NUMBER_OF_INPUTS : natural;
				NEURON_WEIGHTS : ARRAY_OF_SFIXED
				);
				
	port		(
				IN_VALUES	:in ARRAY_OF_SFIXED;
				CONTROL		:in std_logic;
				CLK			:in std_logic;
				OUTPUT		:out CONSTRAINED_SFIXED
				);
				
end GENERIC_NEURON;

--=============================================================================
-- architecture declaration
--=============================================================================
architecture BEHAVIOUR of GENERIC_NEURON is
	signal WEIGHTS : ARRAY_OF_SFIXED(0 to NUMBER_OF_INPUTS-1);
	signal BIAS		: CONSTRAINED_SFIXED;

--=============================================================================
-- architecture begin
--=============================================================================
	begin
		--initialization
		GEN_WEIGHTS:
			for I in 0 to (NUMBER_OF_INPUTS-1) generate 
				WEIGHTS(I)<= NEURON_WEIGHTS(I);
			end generate GEN_WEIGHTS;
		
		BIAS <= NEURON_WEIGHTS(NUMBER_OF_INPUTS);
		
		FORWARDPROPAGATION: process	(
												IN_VALUES,
												CONTROL,
												CLK
												)
												
			variable NEWVALUE: CONSTRAINED_SFIXED;
			begin
				
				if CLK'event and CLK ='1'then
					NEWVALUE := to_sfixed(0 ,U_SIZE,L_SIZE);
					for I in 0 to (NUMBER_OF_INPUTS-1) loop 
						NEWVALUE := resize(
						(NEWVALUE + resize(
										(IN_VALUES(I) * NEURON_WEIGHTS(I)),
										NEWVALUE'high,NEWVALUE'low))
						,NEWVALUE'high,NEWVALUE'low);
					end loop;
					
					NEWVALUE := resize(
										(NEWVALUE + BIAS),
										NEWVALUE'high,NEWVALUE'low);
				end if;
				
				OUTPUT <= NEWVALUE;
		end process;
		
				
end;	
--=============================================================================
-- architecture end
--=============================================================================		