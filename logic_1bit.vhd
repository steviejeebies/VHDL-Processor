library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity logic_1bit is
  Port (A : in std_logic;
        B : in std_logic;
        LOGIC_SELECT_0 : in std_logic;
        LOGIC_SELECT_1 : in std_logic;
        RESULT : out std_logic);
end logic_1bit;

architecture Behavioral of logic_1bit is

component mux4_1bit is
    Port (IN_0, IN_1, in2, in3 : in std_logic;
              S0, S1 : in std_logic;
              Z : out std_logic);
    end component;
    
signal and_result, or_result, xor_result, not_result : std_logic;

begin    
    -- total propagation delay : 3ns (due to mux taking 3 ns)
    and_result <= A AND B after 1 ns;
    or_result <= A OR B after 1 ns;
    xor_result <= A XOR B after 1 ns;
    not_result <= NOT A after 1 ns; 
    
    logic_mux : mux4_1bit PORT MAP (
        IN_0 => and_result,
        IN_1 => or_result,
        in2 => xor_result,
        in3 => not_result,
        S0 => LOGIC_SELECT_0,
        S1 => LOGIC_SELECT_1,
        Z => RESULT);

end Behavioral;
