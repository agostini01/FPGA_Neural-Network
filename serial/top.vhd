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
		UART_TXD : 	out 	std_logic
	);
end top;

architecture structure of top is

	signal 	rxReady	:	std_logic;
	signal	rxData	:	std_logic_vector(7 downto 0);
	signal	txBusy	:	std_logic; 
	signal	txStart	:	std_logic; 
	signal	txData	:	std_logic_vector(7 downto 0);		
	signal	start		: 	std_logic;		-- 0 - stop / 1 - start neural net
	signal	flow		: 	std_logic;		-- 0 - back propagation / 1 - forward propagation
	signal	sample	:	std_logic_vector (7 downto 0);
	signal	result	:	std_logic_vector (2 downto 0);
			
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
			start		: 	out std_logic;		-- 0 - stop / 1 - start neural net
			flow		: 	out std_logic;		-- 0 - back propagation / 1 - forward propagation
			sample	:	out std_logic_vector (7 downto 0);
			result	:	in std_logic_vector (2 downto 0)
		);	
	end component;

	component NN_placeholder
		port (
			clk		:	in	std_logic;
			start		:	in	std_logic;
			flow		: 	in std_logic;
			sample 	: 	in std_logic_vector (7 downto 0);
			result 	: 	out std_logic_vector (2 downto 0)
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
			start		=> start,
			flow		=> flow,
			sample	=> sample,
			result	=> result
		);	

		neural_net	: NN_placeholder 
		port map (  
			clk 		=> CLOCK_50,
			start		=> start,
			flow		=> flow,
			sample	=> sample,
			result	=> result
		);	
		
end structure;