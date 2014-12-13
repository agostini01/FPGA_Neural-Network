library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

use work.fixed_float_types.all; -- ieee_proposed for VHDL-93 version
use work.fixed_pkg.all; -- ieee_proposed for compatibility version

entity top is 
	port (
		-- async receiver/transmitter com ports
		CLOCK_50	:	in	std_logic;
		UART_RXD : 	in std_logic;
		UART_TXD : 	out std_logic
	);
end top;

architecture structure of top is

	signal 	rxReady		:	std_logic;
	signal	rxData		:	std_logic_vector(7 downto 0);
	signal	txBusy		:	std_logic; 
	signal	txStart		:	std_logic; 
	signal	txData		:	std_logic_vector(7 downto 0);		
	signal	NN_start		: 	std_logic;		-- 0 - stop / 1 - start neural net
	signal	NN_sample	:	std_logic_vector (8 downto 0);
	signal	NN_result	:	std_logic_vector (1 downto 0);
	signal	NN_expected	:	std_logic_vector (1 downto 0);
	signal 	NN_ready		: 	std_logic;
			
	component rs_232
		port (
			clk		:	in	std_logic;
			txStart	:	in std_logic;
			txData	:	in std_logic_vector(7 downto 0);		
			rxD 		: 	in std_logic;
			
			rxReady	:	out	std_logic;
			rxData	:	out	std_logic_vector(7 downto 0);
			txBusy	:	out	std_logic; 
			txD		: 	out 	std_logic
		);
	end component;

	component controller
		port (
			-- async receiver/transmitter com ports
			clk		:	in	std_logic;
			rxReady	:	in	std_logic;
			rxData	:	in	std_logic_vector(7 downto 0); -- command string (character)
			txBusy	:	in	std_logic; 
			txStart	:	out std_logic; 
			txData	:	out std_logic_vector(7 downto 0);		
			
			-- LEDs (for debugging)
			LEDR		: 	out std_logic_vector (17 downto 0);
			
			-- control ports
			NN_start		: 	out std_logic;	
			NN_sample	:	out std_logic_vector (8 downto 0);		
			NN_result	:	in std_logic_vector (1 downto 0);
			NN_expected	:	in std_logic_vector (1 downto 0);
			NN_ready		:	in std_logic
		);	
	end component;

	component NN_placeholder
		port (
			clk			:	in	std_logic;
			NN_start		:	in	std_logic;
			NN_sample 	: 	in std_logic_vector (8 downto 0);		
			NN_result 	: 	out std_logic_vector (1 downto 0);
			NN_expected	:	out std_logic_vector (1 downto 0);
			NN_ready 	: 	out std_logic
		);
	end component;
		
	begin
	
	serial_interface : rs_232 
		port map (  
			clk 		=> CLOCK_50,
			txStart	=>	txStart,		
			txData	=> txData,
			rxD 		=> UART_RXD,
			rxReady	=> rxReady,
			rxData	=> rxData,
			txBusy	=> txBusy,
			txD 		=> UART_TXD
		);
	
	control_block	: controller 
		port map (  
			clk 		=> CLOCK_50,
			rxReady	=> rxReady,
			rxData	=> rxData,
			txBusy	=> txBusy,
			txStart	=>	txStart,		
			txData	=> txData,
			NN_start		=> NN_start,
			NN_sample	=> NN_sample,
			NN_result	=> NN_result,
			NN_ready		=> NN_ready,
			NN_expected => NN_expected
		);	

		neural_net	: NN_placeholder 
		port map (  
			clk 		=> CLOCK_50,
			NN_start		=> NN_start,
			NN_sample	=> NN_sample,
			NN_result	=> NN_result,
			NN_ready		=> NN_ready,
			NN_expected => NN_expected
		);	
		
end structure;