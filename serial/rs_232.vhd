library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

use work.fixed_float_types.all; -- ieee_proposed for VHDL-93 version
use work.fixed_pkg.all; -- ieee_proposed for compatibility version

entity rs_232 is 
	port (
		-- async receiver/transmitter com ports
		clk		:	in	std_logic;
		txStart	:	in std_logic;
		txData	:	in std_logic_vector(7 downto 0);		
		rxD 		: 	in std_logic;
		
		rxReady	:	out	std_logic;
		rxData	:	out	std_logic_vector(7 downto 0);
		txBusy	:	out	std_logic; 
		txD		: 	out 	std_logic
	);
end rs_232;

architecture structure of rs_232 is

	component async_receiver
		port (
			clk				: 	in	std_logic;
			RxD				: 	in std_logic;
			RxD_data			: 	out std_logic_vector(7 downto 0);		
			RxD_data_ready	: 	out std_logic
		);
	end component;
	
	component async_transmitter
		port (
			clk			:	in	std_logic;
			TxD_start	:	in std_logic; 
			TxD_data		:	in std_logic_vector(7 downto 0);		
			TxD			:	out std_logic;
			TxD_busy		:	out std_logic
		);
	end component;
	
	begin
	
	receiver : async_receiver 
		port map (  
			clk 				=> clk,     
			RxD 				=> rxD,
			RxD_data 		=> rxData, 
			RxD_data_ready => rxReady
		);

	transmitter : async_transmitter
		port map (
			clk 			=> clk,     
			TxD_start 	=> txStart,
			TxD_data 	=> txData, 
			TxD 			=> txD,
			TxD_busy 	=> txBusy
		);		
end structure;