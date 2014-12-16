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
--	FILE NAME			: generic_neural_net.vhd
--	PROJECT				: FPGA_NEURAL-Network
--	ENTITY				: GENERIC_NEURAL_NET
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
-- Entity declaration for GENERIC_NEURAL_NET
--=============================================================================
entity GENERIC_NEURAL_NET is
	generic	(
				NUMBER_OF_INPUT_NEURONS : natural;
				NUMBER_OF_HIDDEN_NEURONS : natural;
				NUMBER_OF_OUTPUT_NEURONS : natural;
				WEIGHTS_MATRIX : FIXED_WEIGHTS_MATRIX
				);
	
	port		(
				INPUT													:in ARRAY_OF_SFIXED;
				CONTROL_IN, CONTROL_HIDDEN, CONTROL_OUT	:in std_logic;
				START, CLK											:in std_logic;
				OUTPUT												:out ARRAY_OF_SFIXED;
				DATA_READY											:out std_logic
				);

end GENERIC_NEURAL_NET;

--=============================================================================
-- architecture declaration
--=============================================================================
architecture STRUCTURE of GENERIC_NEURAL_NET is
	signal SECOND 				:ARRAY_OF_SFIXED(0 to (PERCEPTRONS_INPUT-1));
	signal THIRD 				:ARRAY_OF_SFIXED(0 to (PERCEPTRONS_HIDDEN-1));
	signal THE_OUTPUT			:ARRAY_OF_SFIXED(0 to (PERCEPTRONS_HIDDEN-1));
	signal PREVIOUS_OUTPUT	:ARRAY_OF_SFIXED(0 to (PERCEPTRONS_HIDDEN-1));

	
	component GENERIC_LAYER
		generic	(
					NUMBER_OF_NEURONS : natural;
					NUMBER_OF_INPUTS : natural;
					LAYER_WEIGHTS_VALUES : LAYER_WEIGHTS
					);
		
		port		(
					LAYER_INPUT		:in ARRAY_OF_SFIXED;
					CONTROL			:in std_logic;
					CLK				:in std_logic;
					LAYER_OUTPUT	:out ARRAY_OF_SFIXED
					);
					
	end component;
	
--=============================================================================
-- architecture begin
--=============================================================================								
	begin
		
		INPUT_GENERIC_LAYER: GENERIC_LAYER 
			generic map	(
							NUMBER_OF_NEURONS		=> NUMBER_OF_INPUT_NEURONS,
							NUMBER_OF_INPUTS		=> NUMBER_OF_INPUT_NEURONS,
							LAYER_WEIGHTS_VALUES	=> LAYER_WEIGHTS(WEIGHTS_MATRIX.INPUT_LAYER)
							)
		
			port map		(
							LAYER_INPUT	=> INPUT,
							CONTROL 		=>	CONTROL_IN,
							CLK 			=> CLK,
							LAYER_OUTPUT => SECOND
							);

		HIDDEN_GENERIC_LAYER: GENERIC_LAYER 
			generic map	(
							NUMBER_OF_NEURONS	=> NUMBER_OF_HIDDEN_NEURONS,
							NUMBER_OF_INPUTS	=> NUMBER_OF_INPUT_NEURONS,
							LAYER_WEIGHTS_VALUES => LAYER_WEIGHTS(WEIGHTS_MATRIX.HIDDEN_LAYER)
							)
		
			port map		(
							LAYER_INPUT	=> SECOND,
							CONTROL 		=>	CONTROL_HIDDEN,
							CLK 			=> CLK,
							LAYER_OUTPUT => THIRD
							);
							
		OUT_GENERIC_LAYER: GENERIC_LAYER
			generic map	(
							NUMBER_OF_NEURONS	=> NUMBER_OF_OUTPUT_NEURONS,
							NUMBER_OF_INPUTS 	=> NUMBER_OF_HIDDEN_NEURONS,
							LAYER_WEIGHTS_VALUES => LAYER_WEIGHTS(WEIGHTS_MATRIX.OUTPUT_LAYER)
							)
		
			port map		(
							LAYER_INPUT	=> THIRD,
							CONTROL 		=>	CONTROL_OUT,
							CLK 			=> CLK,
							LAYER_OUTPUT => THE_OUTPUT
							);
			
			OUTPUT <= THE_OUTPUT;
		
--		STORE_LAST_OUTPUT: process	(THE_OUTPUT, CLK)
--			begin
--				if CLK'event and CLK ='1'then
--					PREVIOUS_OUTPUT<=SECOND;
--				end if;
--		end process;
--
--		DATA_READY_PROCESS: process(PREVIOUS_OUTPUT,SECOND,CLK)
--			begin
--				if CLK'event and CLK ='1'then
--					if PREVIOUS_OUTPUT\=SECOND then
--						DATA_READY<='1';
--					else
--						DATA_READY<='0';
--					end if;
--				end if;
--		end process;
		
		DATA_READY <= '1';
	
end STRUCTURE;
--=============================================================================
-- architecture end
--=============================================================================