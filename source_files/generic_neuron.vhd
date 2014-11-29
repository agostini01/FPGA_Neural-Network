library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_signed.all;
use work.NN_PKG.all;

entity GENERIC_NEURON is
	generic (N : natural);
	port	(
			INPUT		:in INT_ARRAY(0 to N);
			CONTROL	:in std_logic;
			OUTPUT	:out integer
			);
end GENERIC_NEURON;

architecture BEHAVIOUR of GENERIC_NEURON is
	begin

end;
				
			