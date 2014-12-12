library ieee;
use ieee.std_logic_1164.all;
use work.NN_TYPES_pkg.all;

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
				OUTPUT												:out ARRAY_OF_SFIXED
				);

end GENERIC_NEURAL_NET;

architecture STRUCTURE of GENERIC_NEURAL_NET is
	signal SECOND 				:ARRAY_OF_SFIXED(0 to (PERCEPTRONS_INPUT-1));
	signal THIRD 				:ARRAY_OF_SFIXED(0 to (PERCEPTRONS_HIDDEN-1));
	
	component GENERIC_LAYER
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
					
	end component;
							
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
							LAYER_OUTPUT => OUTPUT
							);
	
end STRUCTURE;