library ieee;
use ieee.std_logic_1164.all;

entity TOP is
	port	(
			START, CLK											:in std_logic;
			IN1, IN2, IN3, IN4				:in integer range -5 to 5;
			OUT1, OUT2, OUT3, OUT4 			:out integer
			);
end TOP;

architecture STRUCTURE of TOP is
	signal CONTROL_IN, CONTROL_HIDDEN, CONTROL_OUT	:std_logic;
	
	component NEURAL_NET
		port	(
				INPUT1, INPUT2, INPUT3, INPUT4				:in integer range -5 to 5;
				CONTROL_IN, CONTROL_HIDDEN, CONTROL_OUT	:in std_logic;
				OUTPUT1, OUTPUT2, OUTPUT3, OUTPUT4			:out integer;
				START, CLK											:in std_logic		
				);
	end component;
	
	begin
		CONTROL_IN<='1';
		CONTROL_HIDDEN<='1';
		CONTROL_OUT<='1';
		
		NET: NEURAL_NET port map	(
											IN1, IN2, IN3, IN4,
											CONTROL_IN, CONTROL_HIDDEN, CONTROL_OUT,
											OUT1, OUT2, OUT3, OUT4,
											START, CLK	
											);
end STRUCTURE;