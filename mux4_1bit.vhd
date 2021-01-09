library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity mux4_1bit is
	Port (IN_0, IN_1, in2, in3 : in std_logic;
		  S0, S1 : in std_logic;
		  Z : out std_logic);
	end mux4_1bit;
	
architecture Behavioural of mux4_1bit is
    signal not_s0, not_s1 : std_logic;
    signal a_result, b_result, c_result, d_result : std_logic;
	begin
	-- total propagation delay : 3 ns
		not_s0 <= NOT S0 after 1 ns;
		not_s1 <= NOT S1 after 1 ns;
		a_result <= IN_0 AND not_s1 AND not_s0 after 1 ns;
		b_result <= IN_1 AND not_s1 AND S0 after 1 ns;
		c_result <= in2 AND S1 AND not_s0 after 1 ns;
		d_result <= in3 AND S1 AND S0 after 1 ns;
		Z <= a_result XOR b_result XOR c_result XOR d_result after 1 ns;
	end Behavioural;
	
	
