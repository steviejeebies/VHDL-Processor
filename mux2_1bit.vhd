library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity mux2_1bit is
	Port (IN_0, IN_1 : in std_logic;
		  S : in std_logic;
		  Z : out std_logic);
	end mux2_1bit;
	
architecture Behavioural of mux2_1bit is
    signal NOT_S : std_logic;
    signal OUT_0, OUT_1 : std_logic;
	begin
	-- total propagation delay : 3 ns
		NOT_S <= NOT S after 1 ns;
		OUT_0 <= IN_0 AND not_s after 1 ns;
		OUT_1 <= IN_1 AND S after 1 ns;
		Z <= OUT_0 XOR OUT_1 after 1 ns;
	end Behavioural;
	
	