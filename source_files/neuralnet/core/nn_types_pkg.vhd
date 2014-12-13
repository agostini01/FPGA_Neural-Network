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
--	FILE NAME			: neural_net_types_pkg.vhd
--	PROJECT				: FPGA_NEURAL-Network
--	PACKAGE				: NN_TYPES_pkg
--=============================================================================
--	AUTORS(s)			: Agostini, N
--	DEPARTMENT      	: Electrical Engineering (UFRGS)
--	DATE					: Dec 10, 2014
--=============================================================================
--	Description:
--	
--=============================================================================

library ieee;
	use work.fixed_pkg.all; -- ieee_proposed for compatibility version
	
--=============================================================================
-- Package declaration for NN_TYPES_pkg
--=============================================================================
package NN_TYPES_pkg is

			constant	PERCEPTRONS_INPUT 	: natural := 13;	-- Number of input neurons
			constant	PERCEPTRONS_HIDDEN 	: natural := 3;	-- Number of hidden neurons
			constant	PERCEPTRONS_OUTPUT 	: natural := 3;	-- Number of output neurons
			
			constant	U_SIZE : integer :=8;		--bits before decimal point
			constant	L_SIZE : integer :=-14;		--bits after decimal point
			
			------------------------------------------------------------------------------
			subtype	CONSTRAINED_SFIXED 			is sfixed(U_SIZE downto L_SIZE);
			
			------------------------------------------------------------------------------
			type 		ARRAY_OF_SFIXED 				is array (natural range <>) of CONSTRAINED_SFIXED;
						
			subtype 	INPUT_IN_VALUES 				is ARRAY_OF_SFIXED  (0 to (PERCEPTRONS_INPUT-1));		--input values for in layer
			subtype 	HIDDEN_IN_VALUES				is ARRAY_OF_SFIXED  (0 to (PERCEPTRONS_INPUT-1));		--input values for hidden layer
			subtype 	OUTPUT_IN_VALUES				is ARRAY_OF_SFIXED  (0 to (PERCEPTRONS_HIDDEN-1));		--input values for output layer
			
			subtype 	INPUT_NEURON_WEIGHTS 		is ARRAY_OF_SFIXED (0 to (PERCEPTRONS_INPUT));		-- Weights + bias
			subtype 	HIDDEN_NEURON_WEIGHTS 		is ARRAY_OF_SFIXED (0 to (PERCEPTRONS_INPUT));		-- Weights + bias
			subtype 	OUTPUT_NEURON_WEIGHTS 		is ARRAY_OF_SFIXED (0 to (PERCEPTRONS_HIDDEN));		-- Weights + bias
			
			------------------------------------------------------------------------------
			type 		LAYER_WEIGHTS 					is array (natural range <>) 				of ARRAY_OF_SFIXED(open);
			type 		INPUT_LAYER_WEIGHTS 			is array (0 to (PERCEPTRONS_INPUT-1)) 	of INPUT_NEURON_WEIGHTS; -- Record requires constrained
			type 		HIDDEN_LAYER_WEIGHTS 		is array (0 to (PERCEPTRONS_HIDDEN-1))	of HIDDEN_NEURON_WEIGHTS;
			type 		OUTPUT_LAYER_WEIGHTS 		is array (0 to (PERCEPTRONS_OUTPUT-1)) of OUTPUT_NEURON_WEIGHTS;
			
			------------------------------------------------------------------------------	
			type 		FIXED_WEIGHTS_MATRIX	is 			--It is not possible to have an array of elements with different size, thus RECORD is used
				record
					INPUT_LAYER : INPUT_LAYER_WEIGHTS;		--The RECORD's elements must be constrained in ALTERA VHDL-2008 Compiler
					HIDDEN_LAYER: HIDDEN_LAYER_WEIGHTS;
					OUTPUT_LAYER: OUTPUT_LAYER_WEIGHTS;
				end record;
			
end;

--=============================================================================
-- package body declaration
--=============================================================================
package body NN_TYPES_pkg is


end package body;