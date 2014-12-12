library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

use work.fixed_float_types.all; -- ieee_proposed for VHDL-93 version
use work.fixed_pkg.all; -- ieee_proposed for compatibility version

entity NN_placeholder is 
	port (
		clk		:	in std_logic;
		start		:	in	std_logic;
		flow		: 	in std_logic;
		sample 	: 	in std_logic_vector (7 downto 0);
		result 	: 	out std_logic_vector (2 downto 0)
	);
end NN_placeholder;

architecture structure of NN_placeholder is

begin

end structure;