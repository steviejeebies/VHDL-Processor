library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity shifter_16bit_tb is
end shifter_16bit_tb;

architecture Behavioral of shifter_16bit_tb is
component shifter_16bit is
  Port (B : in std_logic_vector (15 downto 0);
        SHIFT_SELECT_0 : in std_logic;
        SHIFT_SELECT_1 : in std_logic;
        RESULT : out std_logic_vector (15 downto 0));
  end component;
  
signal b_input, result_output : std_logic_vector (15 downto 0);
signal S0, S1 : std_logic;

begin
    uut : shifter_16bit PORT MAP (
        B => b_input,
        SHIFT_SELECT_0 => S0,
        SHIFT_SELECT_1 => S1,
        RESULT => result_output
    );

    stim : process
    begin
        b_input <= "0111111111111110";
        S0 <= '1'; S1 <= '0';
        wait for 100 ns;
        S0 <= '0'; S1 <= '1';
        wait for 100 ns;
        S0 <= '0'; S1 <= '0';
        wait for 100 ns;
    end process;
end Behavioral;
