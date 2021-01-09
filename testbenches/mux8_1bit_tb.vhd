library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux8_1bit_tb is
--  Port ( );
end mux8_1bit_tb;

architecture Behavioral of mux8_1bit_tb is
component mux8_1bit is
	Port (IN_0, IN_1, IN_2, IN_3, IN_4, IN_5, IN_6, IN_7 : in std_logic;
		  S0, S1, S2 : in std_logic;
		  Z : out std_logic );
end component;

signal IN_0, IN_1, IN_2, IN_3, IN_4, IN_5, IN_6, IN_7 : std_logic := '0';
signal S0, S1, S2 : std_logic;
signal Z : std_logic;

begin   
    uut : mux8_1bit PORT MAP(
                         IN_0 => IN_0,
                         IN_1 => IN_1,
                         IN_2 => IN_2,
                         IN_3 => IN_3,
                         IN_4 => IN_4,
                         IN_5 => IN_5,
                         IN_6 => IN_6,
                         IN_7 => IN_7,
		                 S0 => S0,
		                 S1 => S1,
		                 S2 => S2,
		                 Z => Z );
    stim : process
    begin
		IN_0 <= '0';
		IN_1 <= '1';
		IN_2 <= '0';
		IN_3 <= '1';
		IN_4 <= '0';
		IN_5 <= '1';
		IN_6 <= '0';
		IN_7 <= '1';
		
		S0 <= '0'; 
		S1 <= '0';
		S2 <= '0';
		wait for 100 ns;
		
		S0 <= '1'; 
		S1 <= '0';
		S2 <= '0';
		wait for 100 ns;
		
		S0 <= '0'; 
		S1 <= '1';
		S2 <= '0';
		wait for 100 ns;
		
		S0 <= '1'; 
		S1 <= '1';
		S2 <= '0';
		wait for 100 ns;
		
		S0 <= '0'; 
		S1 <= '0';
		S2 <= '1';
		wait for 100 ns;
		
		S0 <= '1'; 
		S1 <= '0';
		S2 <= '1';
		wait for 100 ns;
		
		S0 <= '0'; 
		S1 <= '1';
		S2 <= '1';
		wait for 100 ns;
		
		S0 <= '1'; 
		S1 <= '1';
		S2 <= '1';
		wait for 100 ns;
    end process;
        

end Behavioral;
