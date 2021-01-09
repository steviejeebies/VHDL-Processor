--------------------------------------------------------------------------------
-- Company: Trinity College
-- Engineer: Stephen Rowe (Student ID 14319662)
--
-- 8-to-1 Multiplexer (1-bit)
--------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity mux8_1bit is
	Port (IN_0, IN_1, IN_2, IN_3, IN_4, IN_5, IN_6, IN_7 : in std_logic;
		  S0, S1, S2 : in std_logic;
		  Z : out std_logic );
	end mux8_1bit;
	
architecture Behavioural of mux8_1bit is
	begin
		Z <= IN_0 after 5 ns when (S2 = '0' and S1 = '0' and S0 = '0') else
			 IN_1 after 5 ns when (S2 = '0' and S1 = '0' and S0 = '1') else
			 IN_2 after 5 ns when (S2 = '0' and S1 = '1' and S0 = '0') else
			 IN_3 after 5 ns when (S2 = '0' and S1 = '1' and S0 = '1') else
			 IN_4 after 5 ns when (S2 = '1' and S1 = '0' and S0 = '0') else
			 IN_5 after 5 ns when (S2 = '1' and S1 = '0' and S0 = '1') else
			 IN_6 after 5 ns when (S2 = '1' and S1 = '1' and S0 = '0') else
			 IN_7 after 5 ns when (S2 = '1' and S1 = '1' and S0 = '1') else
			 '0' after 5 ns;
	end Behavioural;
	
	
