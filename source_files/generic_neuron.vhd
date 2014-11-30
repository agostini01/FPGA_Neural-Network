library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.NN_PKG.all;
use work.fixed_float_types.all; -- ieee_proposed for VHDL-93 version
use work.fixed_pkg.all; -- ieee_proposed for compatibility version

entity GENERIC_NEURON is
	generic (N : natural);
	port	(
			INPUT		:in INT_ARRAY(0 to N);
			CONTROL	:in std_logic;
			OUTPUT	:out integer
			);
end GENERIC_NEURON;

architecture BEHAVIOUR of GENERIC_NEURON is
	signal WEIGHTS : FIX_ARRAY(0 to N);
	signal BIAS		: sfixed;

	begin
		--initialization
		GEN_WEIGHTS:
			for I in 0 to N generate 
				WEIGHTS(I)<= to_sfixed(6.5 ,FIX_SIZE);
			end generate GEN_WEIGHTS;
		
		BIAS <= to_sfixed(6.5 ,FIX_SIZE);
		
		FORWARDPROPAGATION: process	(
												INPUT,
												CONTROL
												)
			variable NEWVALUE: sfixed;
			begin
				NEWVALUE := to_sfixed(0 ,FIX_SIZE);
				if CONTROL = '1' then
				
					for I in 0 to N loop 
						NEWVALUE := NEWVALUE + INPUT(I)*WEIGHTS(I);
					end loop;
					
					NEWVALUE := NEWVALUE + BIAS;
				else
					NULL;
				end if;
				OUTPUT <= to_integer(NEWVALUE);
		end process;
		
		
			
end;	
			