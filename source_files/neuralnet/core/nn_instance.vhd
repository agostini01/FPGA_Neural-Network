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
--	FILE NAME			: nn_instance.vhd
--	PROJECT				: FPGA_NEURAL-Network
--	ENTITY				: NN_INSTANCE
--	ARCHITECTURE		: structure
--=============================================================================
--	AUTORS(s)			: Agostini, N; Barbosa, F
--	DEPARTMENT      	: Electrical Engineering (UFRGS)
--	DATE					: Dec 12, 2014
--=============================================================================
--	Description:
--	
--=============================================================================

library ieee;
use ieee.std_logic_1164.all;
use work.NN_TYPES_pkg.all;
use work.NN_CONSTANTS_pkg.all;

--=============================================================================
-- Entity declaration for NN_INSTANCE
--=============================================================================
entity NN_INSTANCE is 
	port (
		clk			:	in std_logic;
		NN_start		:	in	std_logic;
		NN_sample 	: 	in std_logic_vector (7 downto 0);
		NN_result 	: 	out std_logic_vector (1 downto 0);
		NN_expected	: 	out std_logic_vector (1 downto 0);
		NN_ready		: 	out std_logic
	);
end NN_INSTANCE;

--=============================================================================
-- architecture declaration
--=============================================================================
architecture structure of NN_INSTANCE is

	-- Signals for the NEURAL NETWORK
	signal	START			: std_logic;
	signal 	CONTROL_IN, CONTROL_HIDDEN, CONTROL_OUT	:std_logic;
	signal	DATA_READY	: std_logic;
	signal	NN_INPUT												: ARRAY_OF_SFIXED (0 to (PERCEPTRONS_INPUT-1));
	signal	NN_OUTPUT											: ARRAY_OF_SFIXED (0 to (PERCEPTRONS_OUTPUT-1));
	signal	TARGET												: ARRAY_OF_SFIXED (0 to PERCEPTRONS_OUTPUT-1); -- number of outputs: 3 for this example
	
	
	component GENERIC_NEURAL_NET 
		generic	(
					NUMBER_OF_INPUT_NEURONS : natural;
					NUMBER_OF_HIDDEN_NEURONS : natural;
					NUMBER_OF_OUTPUT_NEURONS : natural;
					WEIGHTS_MATRIX : FIXED_WEIGHTS_MATRIX
					);
		
		port		(
					INPUT													:in ARRAY_OF_SFIXED;
					CONTROL_IN, CONTROL_HIDDEN, CONTROL_OUT	:in std_logic;
					START, CLK											:in std_logic;
					OUTPUT												:out ARRAY_OF_SFIXED;
					DATA_READY											:out std_logic
					);				
	end component;
	

	component INPUT_SELECT 
		port (
			CLK					:	in std_logic;
			SAMPLE_NUMBER 		: 	in std_logic_vector (7 downto 0);
			NN_INPUT				: 	out ARRAY_OF_SFIXED;
			TARGET_VALUE		: 	out ARRAY_OF_SFIXED
			);
	end component;
	
	component OUTPUT_CONTROL 
		port (
			CLK				:	in std_logic;
			DATA_READY		:	in std_logic;
			OUTPUT_READY	:	out std_logic;
			NN_OUTPUT		: 	in ARRAY_OF_SFIXED;
			TARGET_VALUE	: 	in ARRAY_OF_SFIXED;
			NN_result 	: 	out std_logic_vector (1 downto 0);
			NN_expected	: 	out std_logic_vector (1 downto 0)
			);
	end component;
--=============================================================================
-- architecture begin
--=============================================================================	
	begin
		-- Signals Assigments
		CONTROL_IN<='1';
		CONTROL_HIDDEN<='1';
		CONTROL_OUT<='1';
		
		
		
		-- Components Assigments
		GEN_NET: GENERIC_NEURAL_NET 
		generic map	(
						NUMBER_OF_INPUT_NEURONS		=> PERCEPTRONS_INPUT,
						NUMBER_OF_HIDDEN_NEURONS	=> PERCEPTRONS_HIDDEN,
						NUMBER_OF_OUTPUT_NEURONS	=> PERCEPTRONS_OUTPUT,
						WEIGHTS_MATRIX=> FIXED_WEIGHTS_MATRIX_INSTANCE
						)
		
		port map		(
						INPUT => NN_INPUT,
						CONTROL_IN => CONTROL_IN, CONTROL_HIDDEN => CONTROL_IN, CONTROL_OUT => CONTROL_IN,
						START => START, CLK => CLK,
						OUTPUT=>	NN_OUTPUT,
						DATA_READY => DATA_READY
						);

		IN_SELECTION: INPUT_SELECT 
		port map		(
						CLK					=>	CLK,
						SAMPLE_NUMBER 		=>	NN_sample,
						NN_INPUT				=> NN_INPUT,
						TARGET_VALUE		=> TARGET
						);
						
		OUTPUT_CTR: OUTPUT_CONTROL
		port map		(
						CLK				=> CLK,
						DATA_READY		=> DATA_READY,
						OUTPUT_READY	=> NN_ready,
						NN_OUTPUT		=> NN_OUTPUT,
						TARGET_VALUE	=> TARGET,
						NN_result 		=> NN_result,
						NN_expected		=> NN_expected
						);
						
end structure;
--=============================================================================
-- architecture end
--=============================================================================