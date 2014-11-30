-------------------------------------------------------
-- Design Name : User Pakage
-- File Name   : lfsr_pkg.vhd
-- Function    : Defines function for LFSR
-- Coder       : Alexander H Pham (VHDL)
-------------------------------------------------------
library ieee;
	use ieee.std_logic_1164.all;
	use ieee.numeric_std.all;

	use work.fixed_float_types.all; -- ieee_proposed for VHDL-93 version
	use work.fixed_pkg.all; -- ieee_proposed for compatibility version

    
package NN_PKG is

			type INT_ARRAY is array (integer range <>) of integer;
			constant INPUT_PERCEPTRONS 	: integer := 4;
			constant HIDDEN_PERCEPTRONS 	: integer := 4;
			constant OUT_PERCEPTRONS 		: integer := 4;
			
			type FIX_ARRAY is array (integer range <>) of sfixed;
			constant FIX_SIZE 	: sfixed := to_sfixed(6.5 ,3,-3);



			

end;

package body NN_PKG is
end package body;


    