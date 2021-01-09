library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ripple_carry_16bit_tb is
end ripple_carry_16bit_tb;

architecture Behavioral of ripple_carry_16bit_tb is
signal A, B, SUM : std_logic_vector (15 downto 0);
signal C_IN, C_OUT, V : std_logic;

component ripple_carry_16bit is
    Port (A : in std_logic_vector (15 downto 0);
          B : in std_logic_vector (15 downto 0);
          C_IN : in std_logic;
          SUM : out std_logic_vector (15 downto 0);
          C_OUT : out std_logic;
          V : out std_logic);
end component;

begin
    uut : ripple_carry_16bit PORT MAP (
        A => A,
        B => B,
        C_IN => C_IN,
        SUM => SUM,
        C_OUT => C_OUT,
        V => V);
        
    stim : process
    begin
        A <= "0000000010101010"; B <= "0000000001010101"; C_IN <= '0';
        wait for 100 ns;
        A <= "0000000000000000"; B <= "0000000000000001"; C_IN <= '1';
        wait for 100 ns;
        A <= "1111111111111111"; B <= "0000000000000000"; C_IN <= '1';
        wait for 100 ns;
        A <= "0111111111111110"; B <= "0000000000000011"; C_IN <= '0';
        wait for 100 ns;
        A <= "0000000000000000"; B <= "0000000000000000"; C_IN <= '0';
        wait for 100 ns;
        A <= "1111111111111111"; B <= "1111111111111111"; C_IN <= '0';
        wait for 100 ns;
    end process;

end Behavioral;
