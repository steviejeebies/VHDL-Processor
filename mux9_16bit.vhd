--------------------------------------------------------------------------------
-- Company: Trinity College
-- Engineer: Stephen Rowe (Student ID 14319662)
--
-- 9-to-1 Multiplexer (16-bit) (If S3 set, output Address Reg value, else normal multiplexer)
--------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity mux9_16bit is
	Port (IN_0, IN_1, IN_2, IN_3, IN_4, IN_5, IN_6, IN_7, IN_ADR : in std_logic_vector(15 downto 0);
		  S0, S1, S2, S3 : in std_logic;
		  Z : out std_logic_vector(15 downto 0));
	end mux9_16bit;
	
	-- This multiplexer will output the Address Register if S3 is set (this is TA or TB), 
	-- else it will multiplex the S2|S1|S0 inputs as normal
	
architecture Behavioural of mux9_16bit is
	begin
		Z <= IN_ADR after 1 ns when S3 = '1' else
		     IN_0 after 1 ns when (S2 = '0' and S1 = '0' and S0 = '0') else
			 IN_1 after 1 ns when (S2 = '0' and S1 = '0' and S0 = '1') else
			 IN_2 after 1 ns when (S2 = '0' and S1 = '1' and S0 = '0') else
			 IN_3 after 1 ns when (S2 = '0' and S1 = '1' and S0 = '1') else
			 IN_4 after 1 ns when (S2 = '1' and S1 = '0' and S0 = '0') else
			 IN_5 after 1 ns when (S2 = '1' and S1 = '0' and S0 = '1') else
			 IN_6 after 1 ns when (S2 = '1' and S1 = '1' and S0 = '0') else
			 IN_7 after 1 ns when (S2 = '1' and S1 = '1' and S0 = '1') else
			 "0000000000000000" after 1 ns;
	end Behavioural;
	
	
