--=============================================================================
--    This file is part of FPGA_NEURAL-Network.
--
--    FPGA_NEURAL-Network is free software: you can redistribute it and/or 
--    modify it under the terms of the GNU General Public License as published 
--    by the Free Software Foundation, either version 3 of the License, or
--    (at your option) any later version.
--
--    FPGA_NEURAL-Network is distributed in the hope that it will be useful,
--    but WITHOUT ANY WARRANTY; without even the implied warranty of
--    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
--    GNU General Public License for more details.
--
--    You should have received a copy of the GNU General Public License
--    along with FPGA_NEURAL-Network.  
--		If not, see <http://www.gnu.org/licenses/>.

--=============================================================================
--	FILE NAME			: nn_constants_pkg.vhd
--	PROJECT				: FPGA_NEURAL-Network
--	PACKAGE				: NN_CONSTANTS_pkg
--=============================================================================
--	AUTORS(s)			: Barbosa, F
--	DEPARTMENT      	: Electrical Engineering (UFRGS)
--	DATE					: Dec 10, 2014
--=============================================================================
--	Description:
--	
--=============================================================================

library ieee;
	use work.fixed_pkg.all; -- ieee_proposed for compatibility version
	use work.NN_TYPES_pkg.all;

--=============================================================================
-- Package declaration for NN_TYPES_pkg
--=============================================================================
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
--				(to_sfixed(22.5922,U_SIZE,L_SIZE), to_sfixed(43.5699,U_SIZE,L_SIZE), to_sfixed(43.0207,U_SIZE,L_SIZE), to_sfixed(97.9748,U_SIZE,L_SIZE), to_sfixed(25.8065,U_SIZE,L_SIZE), to_sfixed(26.2212,U_SIZE,L_SIZE), to_sfixed(22.1747,U_SIZE,L_SIZE), to_sfixed(31.8778,U_SIZE,L_SIZE), to_sfixed(8.5516,U_SIZE,L_SIZE), to_sfixed(2.9220,U_SIZE,L_SIZE), to_sfixed(48.8609,U_SIZE,L_SIZE), to_sfixed(45.8849,U_SIZE,L_SIZE), to_sfixed(52.1136,U_SIZE,L_SIZE), to_sfixed(9.8712,U_SIZE,L_SIZE)),
--				(to_sfixed(17.0708,U_SIZE,L_SIZE), to_sfixed(31.1102,U_SIZE,L_SIZE), to_sfixed(18.4816,U_SIZE,L_SIZE), to_sfixed(43.8870,U_SIZE,L_SIZE), to_sfixed(40.8720,U_SIZE,L_SIZE), to_sfixed(60.2843,U_SIZE,L_SIZE), to_sfixed(11.7418,U_SIZE,L_SIZE), to_sfixed(42.4167,U_SIZE,L_SIZE), to_sfixed(26.2482,U_SIZE,L_SIZE), to_sfixed(92.8854,U_SIZE,L_SIZE), to_sfixed(57.8525,U_SIZE,L_SIZE), to_sfixed(96.3089,U_SIZE,L_SIZE), to_sfixed(23.1594,U_SIZE,L_SIZE), to_sfixed(26.1871,U_SIZE,L_SIZE)),
--				(to_sfixed(22.7664,U_SIZE,L_SIZE), to_sfixed(92.3380,U_SIZE,L_SIZE), to_sfixed(90.4881,U_SIZE,L_SIZE), to_sfixed(11.1119,U_SIZE,L_SIZE), to_sfixed(59.4896,U_SIZE,L_SIZE), to_sfixed(71.1216,U_SIZE,L_SIZE), to_sfixed(29.6676,U_SIZE,L_SIZE), to_sfixed(50.7858,U_SIZE,L_SIZE), to_sfixed(80.1015,U_SIZE,L_SIZE), to_sfixed(73.0331,U_SIZE,L_SIZE), to_sfixed(23.7284,U_SIZE,L_SIZE), to_sfixed(54.6806,U_SIZE,L_SIZE), to_sfixed(48.8898,U_SIZE,L_SIZE), to_sfixed(33.5357,U_SIZE,L_SIZE))
		
				(to_sfixed(1.5122,U_SIZE,L_SIZE), to_sfixed(0.6097,U_SIZE,L_SIZE), to_sfixed(0.9763,U_SIZE,L_SIZE), to_sfixed(-0.8762,U_SIZE,L_SIZE), to_sfixed(0.1932,U_SIZE,L_SIZE), to_sfixed(0.0908,U_SIZE,L_SIZE), to_sfixed(0.4391,U_SIZE,L_SIZE), to_sfixed(-0.0864,U_SIZE,L_SIZE), to_sfixed(-0.5696,U_SIZE,L_SIZE), to_sfixed(0.5749,U_SIZE,L_SIZE), to_sfixed(-0.4827,U_SIZE,L_SIZE), to_sfixed(0.6270,U_SIZE,L_SIZE), to_sfixed(1.7584,U_SIZE,L_SIZE), to_sfixed(0.5553,U_SIZE,L_SIZE)),
				(to_sfixed(1.0114,U_SIZE,L_SIZE), to_sfixed(0.9375,U_SIZE,L_SIZE), to_sfixed(0.3523,U_SIZE,L_SIZE), to_sfixed(0.4041,U_SIZE,L_SIZE), to_sfixed(1.5389,U_SIZE,L_SIZE), to_sfixed(-0.9106,U_SIZE,L_SIZE), to_sfixed(-2.2535,U_SIZE,L_SIZE), to_sfixed(-0.0119,U_SIZE,L_SIZE), to_sfixed(-0.7724,U_SIZE,L_SIZE), to_sfixed(2.9647,U_SIZE,L_SIZE), to_sfixed(-1.4867,U_SIZE,L_SIZE), to_sfixed(-2.3596,U_SIZE,L_SIZE), to_sfixed(0.8667,U_SIZE,L_SIZE), to_sfixed(-1.2566,U_SIZE,L_SIZE)),
				(to_sfixed(-0.7440,U_SIZE,L_SIZE), to_sfixed(-0.2641,U_SIZE,L_SIZE), to_sfixed(-1.0074,U_SIZE,L_SIZE), to_sfixed(0.7037,U_SIZE,L_SIZE), to_sfixed(-0.0806,U_SIZE,L_SIZE), to_sfixed(0.1825,U_SIZE,L_SIZE), to_sfixed(-0.3537,U_SIZE,L_SIZE), to_sfixed(0.8026,U_SIZE,L_SIZE), to_sfixed(-0.4890,U_SIZE,L_SIZE), to_sfixed(0.2165,U_SIZE,L_SIZE), to_sfixed(0.1458,U_SIZE,L_SIZE), to_sfixed(-0.8806,U_SIZE,L_SIZE), to_sfixed(-1.3739,U_SIZE,L_SIZE), to_sfixed(0.5034,U_SIZE,L_SIZE))
			);

			constant OUTPUT_LAYER_WEIGHTS_INSTANCE : OUTPUT_LAYER_WEIGHTS := (
--				(to_sfixed(62.4060,U_SIZE,L_SIZE), to_sfixed(36.7437,U_SIZE,L_SIZE), to_sfixed(88.5168,U_SIZE,L_SIZE), to_sfixed(67.9728,U_SIZE,L_SIZE)),
--				(to_sfixed(67.9136,U_SIZE,L_SIZE), to_sfixed(98.7982,U_SIZE,L_SIZE), to_sfixed(91.3287,U_SIZE,L_SIZE), to_sfixed(13.6553,U_SIZE,L_SIZE)),
--				(to_sfixed(39.5515,U_SIZE,L_SIZE), to_sfixed(3.7739,U_SIZE,L_SIZE), to_sfixed(79.6184,U_SIZE,L_SIZE), to_sfixed(72.1227,U_SIZE,L_SIZE))
				
				(to_sfixed(1.9494,U_SIZE,L_SIZE), to_sfixed(-2.3810,U_SIZE,L_SIZE), to_sfixed(-1.1301,U_SIZE,L_SIZE), to_sfixed(0.0489,U_SIZE,L_SIZE)),
				(to_sfixed(-2.9926,U_SIZE,L_SIZE), to_sfixed(-2.1257,U_SIZE,L_SIZE), to_sfixed(1.5242,U_SIZE,L_SIZE), to_sfixed(-0.1979,U_SIZE,L_SIZE)),
				(to_sfixed(-0.8011,U_SIZE,L_SIZE), to_sfixed(4.6621,U_SIZE,L_SIZE), to_sfixed(1.2713,U_SIZE,L_SIZE), to_sfixed(-0.2438,U_SIZE,L_SIZE))
			);
			
			constant FIXED_WEIGHTS_MATRIX_INSTANCE: FIXED_WEIGHTS_MATRIX
				:= (
					INPUT_LAYER 	=> INPUT_LAYER_WEIGHTS_INSTANCE,
					HIDDEN_LAYER	=> HIDDEN_LAYER_WEIGHTS_INSTANCE,
					OUTPUT_LAYER	=> OUTPUT_LAYER_WEIGHTS_INSTANCE
					);
end;

--=============================================================================
-- package body declaration
--=============================================================================
package body NN_CONSTANTS_pkg is

end package body;