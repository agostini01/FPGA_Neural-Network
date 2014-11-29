library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_signed.all;
use work.NN_PKG.all;


entity GENERIC_LAYER is
	generic	(
				N,M : natural -- N: Number of inputs; M: Number of Neurons/outputs
				);
	
	port		(
				INPUT		:in INT_ARRAY(0 to N);
				CONTROL	:in std_logic;
				OUTPUT	:out INT_ARRAY(0 to M)
				);
				
end GENERIC_LAYER;

architecture STRUCTURE of GENERIC_LAYER is
	component NEURON
		generic	(
					N: natural
					);
					
		port		(
					INPUT		:in INT_ARRAY(0 to N);
					CONTROL	:in std_logic;
					OUTPUT	:out integer
					);
	end component;
	
	begin
	
		-- All neurons get all input, each neuron has a specific output(I)
		GEN_NEURONS: 
		for I in 0 to M generate
			NX: NEURON
				generic map	(
								N
								)
									
				port map 	(
								INPUT,
								CONTROL,
								OUTPUT(I)
								);
		end generate GEN_NEURONS;
									
end STRUCTURE;