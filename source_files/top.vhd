library ieee;
use ieee.std_logic_1164.all;
use work.NN_TYPES_pkg.all;
use work.NN_CONSTANTS_pkg.all;

entity TOP is
	port	(
			CLK							:in std_logic
			);
end TOP;

architecture STRUCTURE of TOP is
	
	-- Signals for the NEURAL NETWORK
	signal	START			: std_logic;
	signal 	CONTROL_IN, CONTROL_HIDDEN, CONTROL_OUT	:std_logic;
	signal	DATA_READY	: std_logic;
	signal	INPUT													: ARRAY_OF_SFIXED (0 to (PERCEPTRONS_INPUT-1)) := A_SAMPLE_INPUT;
	signal	OUTPUT												: ARRAY_OF_SFIXED (0 to (PERCEPTRONS_HIDDEN-1));
	
	
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
					OUTPUT												:out ARRAY_OF_SFIXED;
					DATA_READY											:out std_logic
					);

	end component;
	
	begin
		CONTROL_IN<='1';
		CONTROL_HIDDEN<='1';
		CONTROL_OUT<='1';
		
		
		GEN_NET: GENERIC_NEURAL_NET 
		generic map	(
						NUMBER_OF_INPUT_NEURONS		=> PERCEPTRONS_INPUT,
						NUMBER_OF_HIDDEN_NEURONS	=> PERCEPTRONS_HIDDEN,
						NUMBER_OF_OUTPUT_NEURONS	=> PERCEPTRONS_OUTPUT,
						WEIGHTS_MATRIX=> FIXED_WEIGHTS_MATRIX_INSTANCE
						)
		
		port map		(
						INPUT => INPUT,
						CONTROL_IN => CONTROL_IN, CONTROL_HIDDEN => CONTROL_IN, CONTROL_OUT => CONTROL_IN,
						START => START, CLK => CLK,
						OUTPUT=>	OUTPUT,
						DATA_READY => DATA_READY
						);
											
end STRUCTURE;