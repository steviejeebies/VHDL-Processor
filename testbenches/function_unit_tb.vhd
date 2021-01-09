

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity function_unit_tb is
end function_unit_tb;

architecture Behavioral of function_unit_tb is
component function_unit is
      Port (A_BUS : in std_logic_vector (15 downto 0);
            B_BUS : in std_logic_vector (15 downto 0);
            FS : in std_logic_vector (4 downto 0);
            F : out std_logic_vector (15 downto 0);
            C : out std_logic;
            V : out std_logic;
            Z : out std_logic;
            N : out std_logic);
end component;

signal A_BUS, B_BUS, F : std_logic_vector(15 downto 0);
signal FS : std_logic_vector(4 downto 0);
signal C, V, Z, N : std_logic;

begin

    uut : function_unit PORT MAP (
                             A_BUS => A_BUS,
                             B_BUS => B_BUS,
                             FS => FS,
                             F => F,
                             C => C,
                             V => V,
                             Z => Z,
                             N => N);
                     
    stim : process     
    begin
        -- F = A                
        A_BUS <= "0000000000000001"; B_BUS <= "0000000000000000"; FS <= "00000";
        wait for 100 ns;
        A_BUS <= "1111111111111110"; B_BUS <= "0011111111111111"; FS <= "00000";
        wait for 100 ns;
        -- F = A + 1               
        A_BUS <= "0000000000000001"; B_BUS <= "0000000000000000"; FS <= "00001";
        wait for 100 ns;
        A_BUS <= "1111111111111110"; B_BUS <= "0011111111111111"; FS <= "00001";
        wait for 100 ns;
        -- F = A + B               
        A_BUS <= "0000000000000001"; B_BUS <= "0000000000000000"; FS <= "00010";
        wait for 100 ns;
        A_BUS <= "0000000000000100"; B_BUS <= "0000000000000001"; FS <= "00010";
        wait for 100 ns;
        A_BUS <= "1111111111111111"; B_BUS <= "0000000000000011"; FS <= "00010";
        wait for 100 ns;
        -- F = A + B + 1            
        A_BUS <= "0000000000000001"; B_BUS <= "0000000000000000"; FS <= "00011";
        wait for 100 ns;
        A_BUS <= "0000000000000100"; B_BUS <= "0000000000000001"; FS <= "00011";
        wait for 100 ns;
        A_BUS <= "1111111111111111"; B_BUS <= "0000000000000011"; FS <= "00011";
        wait for 100 ns;
        -- F = A + B'         
        A_BUS <= "0000000000000001"; B_BUS <= "0000000000000000"; FS <= "00100";
        wait for 100 ns;
        A_BUS <= "0000000000000100"; B_BUS <= "0000000000000001"; FS <= "00100";
        wait for 100 ns;
        A_BUS <= "1111111111111111"; B_BUS <= "0000000000000011"; FS <= "00100";
        wait for 100 ns;
        -- F = A + B' + 1       
        A_BUS <= "0000000000000001"; B_BUS <= "0000000000000000"; FS <= "00101";
        wait for 100 ns;
        A_BUS <= "0000000000000100"; B_BUS <= "0000000000000001"; FS <= "00101";
        wait for 100 ns;
        A_BUS <= "1111111111111111"; B_BUS <= "0000000000000011"; FS <= "00101";
        wait for 100 ns;
        -- F = A - 1      
        A_BUS <= "0000000000000001"; B_BUS <= "0000000000000000"; FS <= "00110";
        wait for 100 ns;
        A_BUS <= "0000000000000100"; B_BUS <= "0000000000000001"; FS <= "00110";
        wait for 100 ns;
        A_BUS <= "1111111111111111"; B_BUS <= "0000000000000011"; FS <= "00110";
        wait for 100 ns;
        -- F = A
        A_BUS <= "0000000000000001"; B_BUS <= "0000000000000000"; FS <= "00111";
        wait for 100 ns;
        A_BUS <= "0000000000000100"; B_BUS <= "0000000000000001"; FS <= "00111";
        wait for 100 ns;
        A_BUS <= "1111111111111111"; B_BUS <= "0000000000000011"; FS <= "00111";
        wait for 100 ns;      
        -- F = A /\ B
        A_BUS <= "0000000000000001"; B_BUS <= "0000000000000000"; FS <= "01000";
        wait for 100 ns;
        A_BUS <= "0000000000000100"; B_BUS <= "0000000000000001"; FS <= "01000";
        wait for 100 ns;
        A_BUS <= "1111111111111111"; B_BUS <= "0000000000000011"; FS <= "01000";
        wait for 100 ns;
        -- F = A \/ B
        A_BUS <= "0000000000000001"; B_BUS <= "0000000000000000"; FS <= "01010";
        wait for 100 ns;
        A_BUS <= "0000000000000100"; B_BUS <= "0000000000000001"; FS <= "01010";
        wait for 100 ns;
        A_BUS <= "1111111111111111"; B_BUS <= "0000000000000011"; FS <= "01010";
        wait for 100 ns;
        -- F = A XOR B
        A_BUS <= "0000000000000001"; B_BUS <= "0000000000000000"; FS <= "01100";
        wait for 100 ns;
        A_BUS <= "0000000000000100"; B_BUS <= "0000000000000001"; FS <= "01100";
        wait for 100 ns;
        A_BUS <= "1111111111111111"; B_BUS <= "0000000000000011"; FS <= "01100";
        wait for 100 ns;
        -- F = A'
        A_BUS <= "0000000000000001"; B_BUS <= "0000000000000000"; FS <= "01110";
        wait for 100 ns;
        A_BUS <= "0000000000000100"; B_BUS <= "0000000000000001"; FS <= "01110";
        wait for 100 ns;
        A_BUS <= "1111111111111111"; B_BUS <= "0000000000000011"; FS <= "01110";
        wait for 100 ns;
        -- F = B
        B_BUS <= "0111111111111110"; FS <= "10000";
        wait for 100 ns;
        -- F = sr B
        B_BUS <= "0111111111111110"; FS <= "10100";
        wait for 100 ns;
        -- F = sl B
        B_BUS <= "0111111111111110"; FS <= "11000";
        wait for 100 ns;
        
    end process;
        
    
end Behavioral;
