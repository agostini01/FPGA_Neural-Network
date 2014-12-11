library ieee;
use ieee.std_logic_1164.all;
use work.NN_TYPES_pkg.all;

entity TOP is
	port	(
			START, CLK							:in std_logic;
			IN1, IN2, IN3, IN4				:in integer range -5 to 5;
			OUT1, OUT2, OUT3, OUT4 			:out integer
			);
end TOP;

architecture STRUCTURE of TOP is
	
	-- Signals for the NEURAL NETWORK
	signal 	CONTROL_IN, CONTROL_HIDDEN, CONTROL_OUT	:std_logic;	
	signal	INPUT													: ARRAY_OF_SFIXED;
	signal	OUTPUT												: ARRAY_OF_SFIXED;
	
	component NEURAL_NET
		port	(
				INPUT1, INPUT2, INPUT3, INPUT4				:in integer range -5 to 5;
				CONTROL_IN, CONTROL_HIDDEN, CONTROL_OUT	:in std_logic;
				OUTPUT1, OUTPUT2, OUTPUT3, OUTPUT4			:out integer;
				START, CLK											:in std_logic		
				);
	end component;
	
	component GENERIC_NEURAL_NET 
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

	end component;
	
	begin
		CONTROL_IN<='1';
		CONTROL_HIDDEN<='1';
		CONTROL_OUT<='1';
		
		
		--INPUT <= ;
		
		--W_B_ARRAY_3D<=wine_dataset_init_layer_matrix;
		
		NET: NEURAL_NET 
		port map	(
					IN1, IN2, IN3, IN4,
					CONTROL_IN, CONTROL_HIDDEN, CONTROL_OUT,
					OUT1, OUT2, OUT3, OUT4,
					START, CLK	
					);
		

		
		GEN_NET: GENERIC_NEURAL_NET 
		generic map	(
						NUMBER_OF_INPUT_NEURONS		=> PERCEPTRONS_INPUT,
						NUMBER_OF_HIDDEN_NEURONS	=> PERCEPTRONS_HIDDEN,
						NUMBER_OF_OUTPUT_NEURONS	=> PERCEPTRONS_OUTPUT,
						WEIGHTS_MATRIX=> NULL
						)
		
		port map		(
						INPUT => INPUT,
						CONTROL_IN => CONTROL_IN, CONTROL_HIDDEN => CONTROL_IN, CONTROL_OUT => CONTROL_IN,
						START => START, CLK => CLK,
						OUTPUT=>	OUTPUT
						);
											
end STRUCTURE;