library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity full_adder is
    Port (A : in std_logic;
          B : in std_logic;
          C_IN : in std_logic;
          SUM : out std_logic;
          C_OUT : out std_logic);
end full_adder;

architecture Behavioral of full_adder is
    signal S1 : std_logic;
    signal S2 : std_logic;
    signal S3 : std_logic;
begin
    -- total delay = 3 ns
    S1 <= A XOR B after 1 ns;
    SUM <= S1 XOR C_IN after 1 ns;
    S2 <= S1 AND C_IN after 1 ns;
    S3 <= A AND B after 1 ns;
    C_OUT <= S2 OR S3 after 1 ns;
end Behavioral;
