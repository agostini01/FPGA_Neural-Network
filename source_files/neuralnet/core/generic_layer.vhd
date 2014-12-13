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
--	FILE NAME			: generic_layer.vhd
--	PROJECT				: FPGA_NEURAL-Network
--	ENTITY				: GENERIC_LAYER
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
use work.NN_TYPES_pkg.all;

--=============================================================================
-- Entity declaration for NN_INSTANCE
--=============================================================================
entity GENERIC_LAYER is
	generic	(
				NUMBER_OF_NEURONS : natural;
				NUMBER_OF_INPUTS : natural;
				LAYER_WEIGHTS_VALUES : LAYER_WEIGHTS
				);
	
	port		(
				LAYER_INPUT		:in ARRAY_OF_SFIXED;
				CONTROL	:in std_logic;
				CLK		:in std_logic;
				LAYER_OUTPUT	:out ARRAY_OF_SFIXED
				);
				
end GENERIC_LAYER;

--=============================================================================
-- architecture declaration
--=============================================================================
architecture STRUCTURE of GENERIC_LAYER is
	
	component GENERIC_NEURON
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
					
	end component;
	
--=============================================================================
-- architecture begin
--=============================================================================	
	begin
		
		-- All neurons get all input, each neuron has a specific output(I) and weight(I)
		GEN_NEURONS: 
		for I in 0 to (NUMBER_OF_NEURONS-1) generate
			NX: GENERIC_NEURON
				generic map	(
								NUMBER_OF_INPUTS=> NUMBER_OF_INPUTS,
								NEURON_WEIGHTS=> LAYER_WEIGHTS_VALUES(I)
								)
									
				port map 	(
								IN_VALUES => LAYER_INPUT,
								CONTROL => CONTROL,
								CLK => CLK,
								OUTPUT=> LAYER_OUTPUT(I)
								);
								
		end generate GEN_NEURONS;
									
end STRUCTURE;
--=============================================================================
-- architecture end
--=============================================================================