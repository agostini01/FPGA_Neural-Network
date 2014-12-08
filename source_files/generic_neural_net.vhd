library ieee;
use ieee.std_logic_1164.all;
use work.NN_PKG.all;

entity GENERIC_NEURAL_NET is
	generic	(
				N_I,N_H,N_O : natural -- N: Number of inputs; M: Number of Neurons/outputs
				);
	
	port		(
				INPUT													:in FIX_ARRAY(0 to N_I);
				CONTROL_IN, CONTROL_HIDDEN, CONTROL_OUT	:in std_logic;
				OUTPUT												:out FIX_ARRAY(0 to N_O);
				START, CLK											:in std_logic;
				W_B_ARRAY_3D: in FIX_ARRAY_3D(0 to (2))
				);

end GENERIC_NEURAL_NET;

architecture STRUCTURE of GENERIC_NEURAL_NET is
	signal SECOND 				:FIX_ARRAY(0 to N_I);
	signal THIRD 				:FIX_ARRAY(0 to N_H);
	
	component GENERIC_LAYER
	generic	(
				N,M : natural -- N: Number of inputs; M: Number of Neurons/outputs
				);
	
	port		(
				INPUT		:in FIX_ARRAY(0 to N);
				CONTROL	:in std_logic;
				OUTPUT	:out FIX_ARRAY(0 to M);
				W_B_ARRAY_2D: in FIX_ARRAY_2D(0 to (N+1))
				);
	end component;
	
	type STATE_TYPE is(S0, S1, S2, S3);
	
	begin
		
		INPUT_GENERIC_LAYER: GENERIC_LAYER 
			generic map	(
							N_I,N_I
							)
		
			port map		(
							INPUT,
							CONTROL_IN,
							SECOND,
							W_B_ARRAY_3D(0)
							);

		HIDDEN_GENERIC_LAYER: GENERIC_LAYER 
			generic map	(
							N_I,N_H
							)
		
			port map		(
							SECOND,
							CONTROL_HIDDEN,
							THIRD,
							W_B_ARRAY_3D(1)
							);
							
		OUT_GENERIC_LAYER: GENERIC_LAYER
			generic map	(
							N_H,N_O
							)
		
			port map		(
							THIRD,
							CONTROL_OUT,
							OUTPUT,
							W_B_ARRAY_3D(2)
							);
	
end STRUCTURE;