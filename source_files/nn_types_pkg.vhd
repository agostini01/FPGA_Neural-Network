-------------------------------------------------------
-- Design Name : User Pakage
-- File Name   : neural_net_types_pkg.vhd
-- Function    : 
-- Coder       : Agostini, 
-------------------------------------------------------
library ieee;
	use work.fixed_pkg.all; -- ieee_proposed for compatibility version
	

package NN_TYPES_pkg is

			constant	PERCEPTRONS_INPUT 	: natural := 4;	-- Number of input neurons
			constant	PERCEPTRONS_HIDDEN 	: natural := 4;	-- Number of hidden neurons
			constant	PERCEPTRONS_OUTPUT 	: natural := 3;	-- Number of output neurons
			
			constant	U_SIZE : integer :=4;		--bits before decimal point
			constant	L_SIZE : integer :=-8;	--bits after decimal point
			
			------------------------------------------------------------------------------
			subtype	CONSTRAINED_SFIXED 			is sfixed(U_SIZE downto L_SIZE);
			
			------------------------------------------------------------------------------
			type 		ARRAY_OF_SFIXED 				is array (natural range <>) of CONSTRAINED_SFIXED;
						
			subtype 	INPUT_IN_VALUES 				is ARRAY_OF_SFIXED  (0 to (PERCEPTRONS_INPUT-1));		--input values for in layer
			subtype 	HIDDEN_IN_VALUES				is ARRAY_OF_SFIXED  (0 to (PERCEPTRONS_HIDDEN-1));		--input values for hidden layer
			subtype 	OUTPUT_IN_VALUES				is ARRAY_OF_SFIXED  (0 to (PERCEPTRONS_OUTPUT-1));		--input values for output layer
			
			subtype 	INPUT_NEURON_WEIGHTS 		is ARRAY_OF_SFIXED (0 to (PERCEPTRONS_INPUT));		-- Weights + bias
			subtype 	HIDDEN_NEURON_WEIGHTS 		is ARRAY_OF_SFIXED (0 to (PERCEPTRONS_HIDDEN));		-- Weights + bias
			subtype 	OUTPUT_NEURON_WEIGHTS 		is ARRAY_OF_SFIXED (0 to (PERCEPTRONS_OUTPUT));		-- Weights + bias
			
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

package body NN_TYPES_pkg is


end package body;