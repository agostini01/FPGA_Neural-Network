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
--	FILE NAME			: rs_232.vhd
--	PROJECT				: FPGA_NEURAL-Network
--	ENTITY				: rs_232
--	ARCHITECTURE		: structure
--=============================================================================
--	AUTORS(s)			: Barbosa, F
--	DEPARTMENT      	: Electrical Engineering (UFRGS)
--	DATE					: NOV 29, 2014
--=============================================================================
--	Description:
--	
--=============================================================================

library ieee;
use ieee.std_logic_1164.all;

--=============================================================================
-- Entity declaration for rs_232
--=============================================================================
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

--=============================================================================
-- architecture declaration
--=============================================================================
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
	
--=============================================================================
-- architecture begin
--=============================================================================	
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
--=============================================================================
-- architecture end
--=============================================================================