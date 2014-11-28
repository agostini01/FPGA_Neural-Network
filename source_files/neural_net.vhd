library ieee;
use ieee.std_logic_1164.all;

entity NEURAL_NET is
	port	(
			INPUT1, INPUT2, INPUT3, INPUT4				:in integer range -5 to 5;
			CONTROL_IN, CONTROL_HIDDEN, CONTROL_OUT	:in std_logic;
			OUTPUT1, OUTPUT2, OUTPUT3, OUTPUT4			:out integer;
			START, CLK											:in std_logic			
			);
end NEURAL_NET;

architecture STRUCTURE of NEURAL_NET is
	signal FIRST1, FIRST2, FIRST3, FIRST4 				:integer range -5 to 5;
	signal SECOND1, SECOND2, SECOND3, SECOND4 		:integer;
	signal THIRD1, THIRD2, THIRD3, THIRD4 				:integer;
	
	component LAYER
		port	(
				INPUT1, INPUT2, INPUT3, INPUT4			:in integer range -5 to 5;
				CONTROL											:in std_logic;
				OUTPUT1, OUTPUT2, OUTPUT3, OUTPUT4 		:out integer
				);
	end component;
	
	type STATE_TYPE is(S0, S1, S2, S3);
	
	begin
	   FIRST1 <= INPUT1;
		FIRST2 <= INPUT2;
		FIRST3 <= INPUT3;
		FIRST4 <= INPUT4;
		
		INPUT_LAYER: LAYER port map	(
												FIRST1, FIRST2, FIRST3, FIRST4,
												CONTROL_IN,
												SECOND1, SECOND2, SECOND3, SECOND4
												);
		HIDDEN_LAYER: LAYER port map	(
												SECOND1, SECOND2, SECOND3, SECOND4,
												CONTROL_HIDDEN,
												THIRD1, THIRD2, THIRD3, THIRD4
												);
		OUT_LAYER: LAYER port map		(
												THIRD1, THIRD2, THIRD3, THIRD4,
												CONTROL_OUT,
												OUTPUT1, OUTPUT2, OUTPUT3, OUTPUT4
												);

	
end STRUCTURE;