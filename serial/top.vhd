library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

use work.fixed_float_types.all; -- ieee_proposed for VHDL-93 version
use work.fixed_pkg.all; -- ieee_proposed for compatibility version


entity top is
		PORT (
			UART_RXD		:	in std_logic;
			UART_TXD 	:	in std_logic
		);
		
end top;

architecture behaviour of top is
	
begin
	
end behaviour;