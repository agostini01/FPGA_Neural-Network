-------------------------------------------------------
-- Design Name : User Pakage
-- File Name   : nn_constants_pkg.vhd
-- Function    : 
-- Coder       : Barbosa F. 
-------------------------------------------------------
library ieee;
--	use ieee.std_logic_1164.all;
--	use ieee.numeric_std.all;

--	use work.fixed_float_types.all; -- ieee_proposed for VHDL-93 version
	use work.fixed_pkg.all; -- ieee_proposed for compatibility version
	use work.NN_TYPES_pkg.all;

package NN_CONSTANTS_pkg is

			constant A_SAMPLE_INPUT : ARRAY_OF_SFIXED := (
				(to_sfixed(1,U_SIZE,L_SIZE), to_sfixed(0,U_SIZE,L_SIZE), to_sfixed(0,U_SIZE,L_SIZE), to_sfixed(0,U_SIZE,L_SIZE), to_sfixed(0,U_SIZE,L_SIZE), to_sfixed(0,U_SIZE,L_SIZE), to_sfixed(0,U_SIZE,L_SIZE), to_sfixed(0,U_SIZE,L_SIZE), to_sfixed(0,U_SIZE,L_SIZE), to_sfixed(0,U_SIZE,L_SIZE), to_sfixed(0,U_SIZE,L_SIZE), to_sfixed(0,U_SIZE,L_SIZE), to_sfixed(0,U_SIZE,L_SIZE))
				);

			constant INPUT_LAYER_WEIGHTS_INSTANCE : INPUT_LAYER_WEIGHTS := (
				(to_sfixed(1,U_SIZE,L_SIZE), to_sfixed(0,U_SIZE,L_SIZE), to_sfixed(0,U_SIZE,L_SIZE), to_sfixed(0,U_SIZE,L_SIZE), to_sfixed(0,U_SIZE,L_SIZE), to_sfixed(0,U_SIZE,L_SIZE), to_sfixed(0,U_SIZE,L_SIZE), to_sfixed(0,U_SIZE,L_SIZE), to_sfixed(0,U_SIZE,L_SIZE), to_sfixed(0,U_SIZE,L_SIZE), to_sfixed(0,U_SIZE,L_SIZE), to_sfixed(0,U_SIZE,L_SIZE), to_sfixed(0,U_SIZE,L_SIZE), to_sfixed(0,U_SIZE,L_SIZE)),
				(to_sfixed(0,U_SIZE,L_SIZE), to_sfixed(1,U_SIZE,L_SIZE), to_sfixed(0,U_SIZE,L_SIZE), to_sfixed(0,U_SIZE,L_SIZE), to_sfixed(0,U_SIZE,L_SIZE), to_sfixed(0,U_SIZE,L_SIZE), to_sfixed(0,U_SIZE,L_SIZE), to_sfixed(0,U_SIZE,L_SIZE), to_sfixed(0,U_SIZE,L_SIZE), to_sfixed(0,U_SIZE,L_SIZE), to_sfixed(0,U_SIZE,L_SIZE), to_sfixed(0,U_SIZE,L_SIZE), to_sfixed(0,U_SIZE,L_SIZE), to_sfixed(0,U_SIZE,L_SIZE)),
				(to_sfixed(0,U_SIZE,L_SIZE), to_sfixed(0,U_SIZE,L_SIZE), to_sfixed(1,U_SIZE,L_SIZE), to_sfixed(0,U_SIZE,L_SIZE), to_sfixed(0,U_SIZE,L_SIZE), to_sfixed(0,U_SIZE,L_SIZE), to_sfixed(0,U_SIZE,L_SIZE), to_sfixed(0,U_SIZE,L_SIZE), to_sfixed(0,U_SIZE,L_SIZE), to_sfixed(0,U_SIZE,L_SIZE), to_sfixed(0,U_SIZE,L_SIZE), to_sfixed(0,U_SIZE,L_SIZE), to_sfixed(0,U_SIZE,L_SIZE), to_sfixed(0,U_SIZE,L_SIZE)),
				(to_sfixed(0,U_SIZE,L_SIZE), to_sfixed(0,U_SIZE,L_SIZE), to_sfixed(0,U_SIZE,L_SIZE), to_sfixed(1,U_SIZE,L_SIZE), to_sfixed(0,U_SIZE,L_SIZE), to_sfixed(0,U_SIZE,L_SIZE), to_sfixed(0,U_SIZE,L_SIZE), to_sfixed(0,U_SIZE,L_SIZE), to_sfixed(0,U_SIZE,L_SIZE), to_sfixed(0,U_SIZE,L_SIZE), to_sfixed(0,U_SIZE,L_SIZE), to_sfixed(0,U_SIZE,L_SIZE), to_sfixed(0,U_SIZE,L_SIZE), to_sfixed(0,U_SIZE,L_SIZE)),
				(to_sfixed(0,U_SIZE,L_SIZE), to_sfixed(0,U_SIZE,L_SIZE), to_sfixed(0,U_SIZE,L_SIZE), to_sfixed(0,U_SIZE,L_SIZE), to_sfixed(1,U_SIZE,L_SIZE), to_sfixed(0,U_SIZE,L_SIZE), to_sfixed(0,U_SIZE,L_SIZE), to_sfixed(0,U_SIZE,L_SIZE), to_sfixed(0,U_SIZE,L_SIZE), to_sfixed(0,U_SIZE,L_SIZE), to_sfixed(0,U_SIZE,L_SIZE), to_sfixed(0,U_SIZE,L_SIZE), to_sfixed(0,U_SIZE,L_SIZE), to_sfixed(0,U_SIZE,L_SIZE)),
				(to_sfixed(0,U_SIZE,L_SIZE), to_sfixed(0,U_SIZE,L_SIZE), to_sfixed(0,U_SIZE,L_SIZE), to_sfixed(0,U_SIZE,L_SIZE), to_sfixed(0,U_SIZE,L_SIZE), to_sfixed(1,U_SIZE,L_SIZE), to_sfixed(0,U_SIZE,L_SIZE), to_sfixed(0,U_SIZE,L_SIZE), to_sfixed(0,U_SIZE,L_SIZE), to_sfixed(0,U_SIZE,L_SIZE), to_sfixed(0,U_SIZE,L_SIZE), to_sfixed(0,U_SIZE,L_SIZE), to_sfixed(0,U_SIZE,L_SIZE), to_sfixed(0,U_SIZE,L_SIZE)),
				(to_sfixed(0,U_SIZE,L_SIZE), to_sfixed(0,U_SIZE,L_SIZE), to_sfixed(0,U_SIZE,L_SIZE), to_sfixed(0,U_SIZE,L_SIZE), to_sfixed(0,U_SIZE,L_SIZE), to_sfixed(0,U_SIZE,L_SIZE), to_sfixed(1,U_SIZE,L_SIZE), to_sfixed(0,U_SIZE,L_SIZE), to_sfixed(0,U_SIZE,L_SIZE), to_sfixed(0,U_SIZE,L_SIZE), to_sfixed(0,U_SIZE,L_SIZE), to_sfixed(0,U_SIZE,L_SIZE), to_sfixed(0,U_SIZE,L_SIZE), to_sfixed(0,U_SIZE,L_SIZE)),
				(to_sfixed(0,U_SIZE,L_SIZE), to_sfixed(0,U_SIZE,L_SIZE), to_sfixed(0,U_SIZE,L_SIZE), to_sfixed(0,U_SIZE,L_SIZE), to_sfixed(0,U_SIZE,L_SIZE), to_sfixed(0,U_SIZE,L_SIZE), to_sfixed(0,U_SIZE,L_SIZE), to_sfixed(1,U_SIZE,L_SIZE), to_sfixed(0,U_SIZE,L_SIZE), to_sfixed(0,U_SIZE,L_SIZE), to_sfixed(0,U_SIZE,L_SIZE), to_sfixed(0,U_SIZE,L_SIZE), to_sfixed(0,U_SIZE,L_SIZE), to_sfixed(0,U_SIZE,L_SIZE)),
				(to_sfixed(0,U_SIZE,L_SIZE), to_sfixed(0,U_SIZE,L_SIZE), to_sfixed(0,U_SIZE,L_SIZE), to_sfixed(0,U_SIZE,L_SIZE), to_sfixed(0,U_SIZE,L_SIZE), to_sfixed(0,U_SIZE,L_SIZE), to_sfixed(0,U_SIZE,L_SIZE), to_sfixed(0,U_SIZE,L_SIZE), to_sfixed(1,U_SIZE,L_SIZE), to_sfixed(0,U_SIZE,L_SIZE), to_sfixed(0,U_SIZE,L_SIZE), to_sfixed(0,U_SIZE,L_SIZE), to_sfixed(0,U_SIZE,L_SIZE), to_sfixed(0,U_SIZE,L_SIZE)),
				(to_sfixed(0,U_SIZE,L_SIZE), to_sfixed(0,U_SIZE,L_SIZE), to_sfixed(0,U_SIZE,L_SIZE), to_sfixed(0,U_SIZE,L_SIZE), to_sfixed(0,U_SIZE,L_SIZE), to_sfixed(0,U_SIZE,L_SIZE), to_sfixed(0,U_SIZE,L_SIZE), to_sfixed(0,U_SIZE,L_SIZE), to_sfixed(0,U_SIZE,L_SIZE), to_sfixed(1,U_SIZE,L_SIZE), to_sfixed(0,U_SIZE,L_SIZE), to_sfixed(0,U_SIZE,L_SIZE), to_sfixed(0,U_SIZE,L_SIZE), to_sfixed(0,U_SIZE,L_SIZE)),
				(to_sfixed(0,U_SIZE,L_SIZE), to_sfixed(0,U_SIZE,L_SIZE), to_sfixed(0,U_SIZE,L_SIZE), to_sfixed(0,U_SIZE,L_SIZE), to_sfixed(0,U_SIZE,L_SIZE), to_sfixed(0,U_SIZE,L_SIZE), to_sfixed(0,U_SIZE,L_SIZE), to_sfixed(0,U_SIZE,L_SIZE), to_sfixed(0,U_SIZE,L_SIZE), to_sfixed(0,U_SIZE,L_SIZE), to_sfixed(1,U_SIZE,L_SIZE), to_sfixed(0,U_SIZE,L_SIZE), to_sfixed(0,U_SIZE,L_SIZE), to_sfixed(0,U_SIZE,L_SIZE)),
				(to_sfixed(0,U_SIZE,L_SIZE), to_sfixed(0,U_SIZE,L_SIZE), to_sfixed(0,U_SIZE,L_SIZE), to_sfixed(0,U_SIZE,L_SIZE), to_sfixed(0,U_SIZE,L_SIZE), to_sfixed(0,U_SIZE,L_SIZE), to_sfixed(0,U_SIZE,L_SIZE), to_sfixed(0,U_SIZE,L_SIZE), to_sfixed(0,U_SIZE,L_SIZE), to_sfixed(0,U_SIZE,L_SIZE), to_sfixed(0,U_SIZE,L_SIZE), to_sfixed(1,U_SIZE,L_SIZE), to_sfixed(0,U_SIZE,L_SIZE), to_sfixed(0,U_SIZE,L_SIZE)),
				(to_sfixed(0,U_SIZE,L_SIZE), to_sfixed(0,U_SIZE,L_SIZE), to_sfixed(0,U_SIZE,L_SIZE), to_sfixed(0,U_SIZE,L_SIZE), to_sfixed(0,U_SIZE,L_SIZE), to_sfixed(0,U_SIZE,L_SIZE), to_sfixed(0,U_SIZE,L_SIZE), to_sfixed(0,U_SIZE,L_SIZE), to_sfixed(0,U_SIZE,L_SIZE), to_sfixed(0,U_SIZE,L_SIZE), to_sfixed(0,U_SIZE,L_SIZE), to_sfixed(0,U_SIZE,L_SIZE), to_sfixed(1,U_SIZE,L_SIZE), to_sfixed(0,U_SIZE,L_SIZE))
			);

			constant HIDDEN_LAYER_WEIGHTS_INSTANCE : HIDDEN_LAYER_WEIGHTS := (
				(to_sfixed(22.5922,U_SIZE,L_SIZE), to_sfixed(43.5699,U_SIZE,L_SIZE), to_sfixed(43.0207,U_SIZE,L_SIZE), to_sfixed(97.9748,U_SIZE,L_SIZE), to_sfixed(25.8065,U_SIZE,L_SIZE), to_sfixed(26.2212,U_SIZE,L_SIZE), to_sfixed(22.1747,U_SIZE,L_SIZE), to_sfixed(31.8778,U_SIZE,L_SIZE), to_sfixed(8.5516,U_SIZE,L_SIZE), to_sfixed(2.9220,U_SIZE,L_SIZE), to_sfixed(48.8609,U_SIZE,L_SIZE), to_sfixed(45.8849,U_SIZE,L_SIZE), to_sfixed(52.1136,U_SIZE,L_SIZE), to_sfixed(9.8712,U_SIZE,L_SIZE)),
				(to_sfixed(17.0708,U_SIZE,L_SIZE), to_sfixed(31.1102,U_SIZE,L_SIZE), to_sfixed(18.4816,U_SIZE,L_SIZE), to_sfixed(43.8870,U_SIZE,L_SIZE), to_sfixed(40.8720,U_SIZE,L_SIZE), to_sfixed(60.2843,U_SIZE,L_SIZE), to_sfixed(11.7418,U_SIZE,L_SIZE), to_sfixed(42.4167,U_SIZE,L_SIZE), to_sfixed(26.2482,U_SIZE,L_SIZE), to_sfixed(92.8854,U_SIZE,L_SIZE), to_sfixed(57.8525,U_SIZE,L_SIZE), to_sfixed(96.3089,U_SIZE,L_SIZE), to_sfixed(23.1594,U_SIZE,L_SIZE), to_sfixed(26.1871,U_SIZE,L_SIZE)),
				(to_sfixed(22.7664,U_SIZE,L_SIZE), to_sfixed(92.3380,U_SIZE,L_SIZE), to_sfixed(90.4881,U_SIZE,L_SIZE), to_sfixed(11.1119,U_SIZE,L_SIZE), to_sfixed(59.4896,U_SIZE,L_SIZE), to_sfixed(71.1216,U_SIZE,L_SIZE), to_sfixed(29.6676,U_SIZE,L_SIZE), to_sfixed(50.7858,U_SIZE,L_SIZE), to_sfixed(80.1015,U_SIZE,L_SIZE), to_sfixed(73.0331,U_SIZE,L_SIZE), to_sfixed(23.7284,U_SIZE,L_SIZE), to_sfixed(54.6806,U_SIZE,L_SIZE), to_sfixed(48.8898,U_SIZE,L_SIZE), to_sfixed(33.5357,U_SIZE,L_SIZE))
			);

			constant OUTPUT_LAYER_WEIGHTS_INSTANCE : OUTPUT_LAYER_WEIGHTS := (
				(to_sfixed(62.4060,U_SIZE,L_SIZE), to_sfixed(36.7437,U_SIZE,L_SIZE), to_sfixed(88.5168,U_SIZE,L_SIZE), to_sfixed(67.9728,U_SIZE,L_SIZE)),
				(to_sfixed(67.9136,U_SIZE,L_SIZE), to_sfixed(98.7982,U_SIZE,L_SIZE), to_sfixed(91.3287,U_SIZE,L_SIZE), to_sfixed(13.6553,U_SIZE,L_SIZE)),
				(to_sfixed(39.5515,U_SIZE,L_SIZE), to_sfixed(3.7739,U_SIZE,L_SIZE), to_sfixed(79.6184,U_SIZE,L_SIZE), to_sfixed(72.1227,U_SIZE,L_SIZE))
			);
			
			constant FIXED_WEIGHTS_MATRIX_INSTANCE: FIXED_WEIGHTS_MATRIX
				:= (
					INPUT_LAYER 	=> INPUT_LAYER_WEIGHTS_INSTANCE,
					HIDDEN_LAYER	=> HIDDEN_LAYER_WEIGHTS_INSTANCE,
					OUTPUT_LAYER	=> OUTPUT_LAYER_WEIGHTS_INSTANCE
					);
end;


package body NN_CONSTANTS_pkg is

end package body;