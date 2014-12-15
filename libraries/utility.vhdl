--------------------------------------------------------------------------------
--
-- PROJECT: D0 Run IIb Trigger L1 Calorimeter upgrade
--
-- MODULE: Utility package
--
-- ELEMENT: -
--
-- DESCRIPTION: several utility types and functions
-- 
-- AUTHOR: D. Calvet calvet@hep.saclay.cea.fr
--
-- DATE AND HISTORY:
--  Jan 2002
--  March 2004: revision and cleanup
--
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
library ieee;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_BIT.all;

package utility_pkg is

	--
	-- Conversion functions NATURAL <-> STD_LOGIC_VECTOR
	--
	function Std_Logic_Vector_To_Natural ( SLV : std_logic_vector) return NATURAL;
	function Natural_To_Std_Logic_Vector (val, SIZE : integer) return std_logic_vector;

	--
	-- Bit vector Array types
	--
	type bit_vector_N_32 is array (natural range<>) of bit_vector(31 downto 0);
	type bit_vector_N_16 is array (natural range<>) of bit_vector(15 downto 0);
	function Bit_Vector_To_String( bv: Bit_Vector; SIZE : integer) return String;
	
	--
	-- Std_Logic_Vector Array types
	--  
	type std_logic_vector_N_16 is array(natural range<>) of std_logic_vector(15 downto 0);
	type std_logic_vector_N_14 is array(natural range<>) of std_logic_vector(13 downto 0);
	type std_logic_vector_N_10 is array(natural range<>) of std_logic_vector( 9 downto 0);
	type std_logic_vector_N_8  is array(natural range<>) of std_logic_vector( 7 downto 0);
	type std_logic_vector_N_6  is array(natural range<>) of std_logic_vector( 5 downto 0);
	type std_logic_vector_N_5  is array(natural range<>) of std_logic_vector( 4 downto 0);
	type std_logic_vector_N_4  is array(natural range<>) of std_logic_vector( 3 downto 0);
	type std_logic_vector_N_3  is array(natural range<>) of std_logic_vector( 2 downto 0);
	type std_logic_vector_N_2  is array(natural range<>) of std_logic_vector( 1 downto 0);
	
	--
	-- String Array types
	--
	type string_N_4 is array(natural range<>) of string(4 downto 1);
	type string_N_8 is array(natural range<>) of string(8 downto 1);
	
	--
	-- 2 D Arrays
	--
	TYPE std_logic_2D_Array IS ARRAY (NATURAL RANGE <>, NATURAL RANGE <>) OF std_logic;
	function sl2da_to_slv(sl2da: std_logic_2D_Array; ix : integer ) return std_logic_vector;
	
	--
	-- Conversion functions to string
	--
	function Convert_To_String(val : INTEGER) return STRING;
	function Convert_To_String(bv: Bit_Vector) return STRING;
	function Convert_To_String(ti: TIME) return STRING;
	
	--
	-- Conversion functions from string
	--
	function Convert_From_String(str : STRING) return std_logic;
	function Convert_From_String(str : STRING) return std_logic_vector;
	
end utility_pkg;

package body utility_pkg is

--
-- Convert standard logic vector to natural
--
function Std_Logic_Vector_To_Natural ( SLV : std_logic_vector) return NATURAL is

	variable Result : NATURAL := 0;     -- conversion result

	begin
	    for i in SLV'range loop
            Result:= Result * 2;  -- shift the variable to left
            case SLV(i) is
                when '1' | 'H' => Result := Result + 1;
                when '0' | 'L' => Result := Result + 0;
                when others    => null;
            end case;
        end loop;

    return Result;
end Std_Logic_Vector_To_Natural;

--
-- Convert natural to standard logic vector of given size
--
function Natural_To_Std_Logic_Vector (val, SIZE : integer) return std_logic_vector is
	variable result             : std_logic_vector(SIZE-1 downto 0);
	variable l_val              : NATURAL := val;
	
	begin
	-- synopsys translate_off
	assert SIZE > 1
		report "Error : function missuse : Natural_To_Std_Logic_Vector(val, negative size)"
		severity failure;
	-- synopsys translate_on
	
	for i in 0 to result'length-1 loop
		if (l_val mod 2) = 0 then
			result(i) := '0';
		else
			result(i) := '1';
		end if;
		l_val := l_val/2;
	end loop;
	return result;
end Natural_To_Std_Logic_Vector;

function Bit_Vector_To_String( bv: Bit_Vector; SIZE : integer) return String is 
	variable result : string(SIZE downto 1);
	begin
		for i in (SIZE-1) downto 0 loop
			if bv(i) ='0' then
				result(i+1) := '0';
			else
				result(i+1) := '1';
			end if;
		end loop;
		
	return result;
end Bit_Vector_To_String;

function sl2da_to_slv(sl2da: std_logic_2D_Array; ix : integer ) return std_logic_vector is
	variable result : std_logic_vector(sl2da'range(2));
	begin
		-- synopsys translate_off
		--assert sl2da'length(2) /= 10
		--report "Error : sl2da_to_slv : range is not 10"
		--severity failure;
		-- synopsys translate_on
		for i in sl2da'range(2) loop
			result(i) := sl2da(ix,i);
		end loop;
	return result;
end sl2da_to_slv;


--
-- Conversion functions integer to string
--
function Convert_To_String(val : INTEGER) return STRING is
variable result : STRING(11 downto 1) := "-2147483648"; -- smallest integer and longest string
variable tmp    : INTEGER;
variable pos    : NATURAL := 1;
variable digit  : NATURAL;
begin
	 -- for the smallest integer MOD does not seem to work...
	 --if val = -2147483648 then	: compilation error with Xilinx tools...
	 if val < -2147483647 then
	 	pos := 12;
	 else
		pos := 1;
	 	tmp := abs(val);
		loop
	   		digit := abs(tmp MOD 10);
	    		tmp := tmp / 10;
	    		result(pos) := character'val(character'pos('0') + digit);
	    		pos := pos + 1;
				exit when pos = 12;
	    		exit when tmp = 0;
		end loop;
		if val < 0 then
	   		result(pos) := '-';
	   		pos := pos + 1;
		end if;
	end if;
	return result((pos-1) downto 1);
end Convert_To_String;

--
-- Conversion functions Bit_Vector to string
--
function Convert_To_String(bv: Bit_Vector) return STRING is
variable result : string(1 to bv'length);
variable index  : NATURAL := 1;
begin
	for i in bv'range loop
		if bv(i) ='0' then
			result(index) := '0';
		else
			result(index) := '1';
		end if;
		index := index + 1;
	end loop;
	return result;
end Convert_To_String;

--
-- Conversion functions TIME to string
--
-- Note: TIME'image(x) is VHDL'93 only. It returns a value in units of simulator's resolution
-- 
function Convert_To_String(ti: TIME) return STRING is
variable result : STRING(14 downto 1) := "              "; -- longest string is "2147483647 min"
variable tmp    : NATURAL;
variable pos    : NATURAL := 1;
variable digit  : NATURAL;
variable resol  : TIME := TIME'succ(ti) - ti; -- time resolution
variable scale  : NATURAL := 1;
variable unit   : TIME;

begin	
	
	if resol = 100 sec then scale := 100; unit := 1 sec;
	elsif  resol = 10 sec then scale := 10; unit := 1 sec;
	elsif  resol = 1 sec then scale := 1; unit := 1 sec;
	elsif resol = 100 ms then scale := 100; unit := 1 ms;
	elsif  resol = 10 ms then scale := 10; unit := 1 ms;
	elsif  resol = 1 ms then scale := 1; unit := 1 ms;
	elsif resol = 100 us then scale := 100; unit := 1 us;
	elsif  resol = 10 us then scale := 10; unit := 1 us;
	elsif  resol = 1 us then scale := 1; unit := 1 us;	
	elsif resol = 100 ns then scale := 100; unit := 1 ns;
	elsif  resol = 10 ns then scale := 10; unit := 1 ns;
	elsif  resol = 1 ns then scale := 1; unit := 1 ns;		 
	elsif resol = 100 ps then scale := 100; unit := 1 ps;
	elsif  resol = 10 ps then scale := 10; unit := 1 ps;
	elsif  resol = 1 ps then scale := 1; unit := 1 ps;	
	elsif resol = 100 fs then scale := 100; unit := 1 fs;
	elsif  resol = 10 fs then scale := 10; unit := 1 fs;
	elsif  resol = 1 fs then scale := 1; unit := 1 fs;
	else scale := 0; unit := 1 fs;
	end if;
				
	-- Write unit (reversed order)
	if unit = 1 hr then
		result(pos) := 'r';
		pos := pos + 1;
		result(pos) := 'h';
		pos := pos + 1;
		result(pos) := ' ';
		pos := pos + 1;	
	elsif unit = 1 sec then
		result(pos) := 'c';
		pos := pos + 1;
		result(pos) := 'e';
		pos := pos + 1;
		result(pos) := 's';
		pos := pos + 1;
	elsif unit = 1 ms then
		result(pos) := 's';
		pos := pos + 1;
		result(pos) := 'm';
		pos := pos + 1;
		result(pos) := ' ';
		pos := pos + 1;
	elsif unit = 1 us then
		result(pos) := 's';
		pos := pos + 1;
		result(pos) := 'u';
		pos := pos + 1;
		result(pos) := ' ';
		pos := pos + 1;
	elsif unit = 1 ns then
		result(pos) := 's';
		pos := pos + 1;
		result(pos) := 'n';
		pos := pos + 1;
		result(pos) := ' ';
		pos := pos + 1;
	elsif unit = 1 ps then
		result(pos) := 's';
		pos := pos + 1;
		result(pos) := 'p';
		pos := pos + 1;
		result(pos) := ' ';
		pos := pos + 1;
	elsif unit = 1 fs then
		result(pos) := 's';
		pos := pos + 1;
		result(pos) := 'f';
		pos := pos + 1;
		result(pos) := ' ';
		pos := pos + 1;	
	else
		result(pos) := '?';
		pos := pos + 1;
		result(pos) := '?';
		pos := pos + 1;
		result(pos) := ' ';
		pos := pos + 1;	
	end if;

	-- Convert TIME to NATURAL
	tmp := scale * (ti / resol);
	
	loop
	   	digit := tmp MOD 10; -- extract last digit
	    	tmp := tmp / 10;
	    	result(pos) := character'val(character'pos('0') + digit);
	    	pos := pos + 1;
	    	exit when tmp = 0;
	end loop;
	
	-- Return result (put back in right order)
	return result((pos-1) downto 1);
end Convert_To_String;

--
-- Conversion from string to std_logic
--
-- T'value(s) is VHDL'93
function Convert_From_String(str : STRING) return std_logic is
variable result : std_logic := '-';
begin
	if str(1) = '0' then result := '0';
	elsif str(1) = 'L' then result := 'L';
	elsif str(1) = '1' then result := '1';
	elsif str(1) = 'H' then result := 'H';
	elsif str(1) = 'Z' then result := 'Z';
	elsif str(1) = 'U' then result := 'U';
	elsif str(1) = 'X' then result := 'X';
	elsif str(1) = 'W' then result := 'W';
	elsif str(1) = '-' then result := '-';
	else
		-- synopsys translate_off
		assert FALSE
		report "Error : cannot convert string '" & str & "' to std_logic"
		severity failure;
		-- synopsys translate_on
	end if;
	return result;
end Convert_From_String;

--
-- Conversion from string to std_logic_vector
--
-- T'value(s) is VHDL'93
function Convert_From_String(str : STRING) return std_logic_vector is
variable result : std_logic_vector((str'length-1) downto 0) := (others => '-');
variable index : INTEGER := str'length-1;
variable str_1 : STRING(1 to 1);

begin
	for i in str'range loop
		str_1(1) := str(i);
		result(index) := Convert_From_String(str_1);
		index := index - 1;
	end loop;
	return result;
end Convert_From_String;
	
end utility_pkg; 
