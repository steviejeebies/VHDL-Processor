library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity logic_unit_tb is
--  Port ( );
end logic_unit_tb;

architecture Behavioral of logic_unit_tb is
component logic_unit is
  Port (A : in std_logic_vector (15 downto 0);
        B : in std_logic_vector (15 downto 0);
        LOGIC_SELECT_0 : in std_logic;
        LOGIC_SELECT_1 : in std_logic;
        RESULT : out std_logic_vector (15 downto 0));
end component;

signal a_value, b_value : std_logic_vector (15 downto 0);
signal S0, S1 : std_logic;
signal ourResult : std_logic_vector (15 downto 0);

begin
    uut : logic_unit PORT MAP (
        A => a_value,
        B => b_value,
        LOGIC_SELECT_0 => S0,
        LOGIC_SELECT_1 => S1,
        RESULT => ourResult);
        
    stim : process
    begin
        a_value <= "0000111111110000"; b_value <= "1111110000111111";
        S0 <= '0'; S1 <= '0';
        wait for 50 ns;
        S0 <= '1'; S1 <= '0';
        wait for 50 ns;
        S0 <= '0'; S1 <= '1';
        wait for 50 ns;
        S0 <= '1'; S1 <= '1';
        wait for 50 ns;
    end process;
        

end Behavioral;
