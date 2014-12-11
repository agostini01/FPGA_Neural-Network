library ieee;
use ieee.std_logic_1164.all;
use work.NN_TYPES_pkg.all;


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

architecture STRUCTURE of GENERIC_LAYER is
	
	component NEURON
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
	
	
	begin
		
		-- All neurons get all input, each neuron has a specific output(I) and weight(I)
		GEN_NEURONS: 
		for I in 0 to (NUMBER_OF_NEURONS-1) generate
			NX: NEURON
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