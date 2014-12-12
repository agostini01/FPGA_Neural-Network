-------------------------------------------------------
-- Design Name : GENERIC_NEURON
-- File Name   : generic_neuron.vhd
-- Function    : 
-- Coder       : Agostini
-------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
--use ieee.numeric_std.all;
--use work.NN_PKG.all;
--use work.fixed_float_types.all; -- ieee_proposed for VHDL-93 version
use work.fixed_pkg.all; -- ieee_proposed for compatibility version
use work.NN_TYPES_pkg.all;

entity GENERIC_NEURON is
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
				
end GENERIC_NEURON;

architecture BEHAVIOUR of GENERIC_NEURON is
	signal WEIGHTS : ARRAY_OF_SFIXED(0 to NUMBER_OF_INPUTS-1);
	signal BIAS		: CONSTRAINED_SFIXED;

	begin
		--initialization
		GEN_WEIGHTS:
			for I in 0 to (NUMBER_OF_INPUTS-1) generate 
				WEIGHTS(I)<= NEURON_WEIGHTS(I);
			end generate GEN_WEIGHTS;
		
		BIAS <= NEURON_WEIGHTS(NUMBER_OF_INPUTS);
		
		FORWARDPROPAGATION: process	(
												IN_VALUES,
												CONTROL,
												CLK
												)
												
			variable NEWVALUE: CONSTRAINED_SFIXED;
			begin
				
				if CLK'event and CLK ='1'then
					NEWVALUE := to_sfixed(0 ,U_SIZE,L_SIZE);
					for I in 0 to (NUMBER_OF_INPUTS-1) loop 
						NEWVALUE := resize(
						(NEWVALUE + resize(
										(IN_VALUES(I) * NEURON_WEIGHTS(I)),
										NEWVALUE'high,NEWVALUE'low))
						,NEWVALUE'high,NEWVALUE'low);
					end loop;
					
					NEWVALUE := resize(
										(NEWVALUE + BIAS),
										NEWVALUE'high,NEWVALUE'low);
				end if;
				
				OUTPUT <= NEWVALUE;
		end process;
		
		
			
end;	
			