library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity mux2_16bit is
	Port (IN_0 : in std_logic_vector(15 downto 0);
		  IN_1 : in std_logic_vector(15 downto 0);
		  S : in std_logic;
		  Z : out std_logic_vector(15 downto 0));
	end mux2_16bit;
	
architecture Behavioural of mux2_16bit is
	begin
		Z <= IN_0 after 5 ns when S = '0' else
			 IN_1 after 5 ns when S = '1' else
			 X"0000" after 1 ns;
	end Behavioural;
	
	
