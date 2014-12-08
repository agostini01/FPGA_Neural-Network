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
			OUTPUT	:out S_SFIXED;
			W_B_ARRAY:in FIX_ARRAY(0 to (N+1))
			);
end GENERIC_NEURON;

architecture BEHAVIOUR of GENERIC_NEURON is
	signal WEIGHTS : FIX_ARRAY(0 to N);
	signal BIAS		: S_SFIXED;

	begin
		--initialization
		GEN_WEIGHTS:
			for I in 0 to N generate 
				WEIGHTS(I)<= W_B_ARRAY(I);
			end generate GEN_WEIGHTS;
		
		BIAS <= W_B_ARRAY(N+1);
		
		FORWARDPROPAGATION: process	(
												INPUT,
												CONTROL
												)
			variable NEWVALUE: sfixed;
			begin
				NEWVALUE := to_sfixed(0 ,F_U_SIZE,F_L_SIZE);
				if CONTROL = '1' then
				
					for I in 0 to N loop 
						NEWVALUE := NEWVALUE + INPUT(I)*WEIGHTS(I);
					end loop;
					
					NEWVALUE := NEWVALUE + BIAS;
				else
					NULL;
				end if;
				OUTPUT <= NEWVALUE;
		end process;
		
		
			
end;	
			