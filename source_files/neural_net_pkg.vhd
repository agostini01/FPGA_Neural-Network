-------------------------------------------------------
-- Design Name : User Pakage
-- File Name   : lfsr_pkg.vhd
-- Function    : Defines function for LFSR
-- Coder       : Alexander H Pham (VHDL)
-------------------------------------------------------
library ieee;
    use ieee.std_logic_1164.all;
    use ieee.std_logic_unsigned.all;
    
package NN_PKG is

			type INT_ARRAY is array (integer range <>) of integer;
			constant INPUT_PERCEPTRONS 	: integer := 4;
			constant HIDDEN_PERCEPTRONS 	: integer := 4;
			constant OUT_PERCEPTRONS 		: integer := 4;

end;

package body NN_PKG is
end package body;


    