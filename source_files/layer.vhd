library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity LAYER is
	port	(
			INPUT1, INPUT2, INPUT3, INPUT4				:in integer range -5 to 5;
			CONTROL												:in std_logic;
			OUTPUT1, OUTPUT2, OUTPUT3, OUTPUT4 			:out integer
			);
end LAYER;

architecture STRUCTURE of LAYER is
	
	component NEURON
		port	(
				INPUT1, INPUT2, INPUT3, INPUT4	:in integer range -5 to 5;
				PROP										:in std_logic;
				OUTPUT									:out integer
				);
	end component;
	
	begin
		N1: NEURON port map (
									INPUT1,INPUT2,INPUT3,INPUT4,
									CONTROL,
									OUTPUT1
									);
		N2: NEURON port map (
									INPUT1,INPUT2,INPUT3,INPUT4,
									CONTROL,
									OUTPUT2
									);
		N3: NEURON port map (
									INPUT1,INPUT2,INPUT3,INPUT4,
									CONTROL,
									OUTPUT3
									);
		N4: NEURON port map (
									INPUT1,INPUT2,INPUT3,INPUT4,
									CONTROL,
									OUTPUT4
									);
									
end STRUCTURE;