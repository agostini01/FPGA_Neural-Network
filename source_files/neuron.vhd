library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity NEURON is
	port	(
			INPUT1, INPUT2, INPUT3, INPUT4	:in integer range -5 to 5;
			PROP										:in std_logic;
			OUTPUT									:out integer
			);
end NEURON;

architecture BEHAVIOUR of NEURON is
	signal WEIGHT1, WEIGHT2, WEIGHT3, WEIGHT4 :integer range -5 to 5;
	signal BIAS :integer range -5 to 5;
	begin
		WEIGHT1<=1;
		WEIGHT2<=1;
		WEIGHT3<=1;
		WEIGHT4<=1;
		BIAS	<=0;
	
	
		FORWARDPROPAGATION: process 	(INPUT1, INPUT2, INPUT3, INPUT4,
												PROP, 
												WEIGHT1, WEIGHT2, WEIGHT3, WEIGHT4,
												BIAS
												)
			variable NEWVALUE: integer := 0;
			begin
				NEWVALUE := 0;
				if PROP = '1' then
					NEWVALUE := INPUT1*WEIGHT1 + INPUT2*WEIGHT2 + INPUT3*WEIGHT3 + INPUT4*WEIGHT4;
					NEWVALUE := NEWVALUE + BIAS;
				else
					NULL;
				end if;
				OUTPUT <= NEWVALUE;
		end process;
end;
				
			