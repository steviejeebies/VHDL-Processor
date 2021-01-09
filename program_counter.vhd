---------------------------------------------------------------------------------
-- Company: Trinity College
-- Engineer: Stephen Rowe (Student ID 14319662)
--
-- Program Counter
--------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.all;

entity program_counter is
        Port (CLK, PI, PL : in std_logic;
              DR : in std_logic_vector(2 downto 0);
              SB : in std_logic_vector(2 downto 0);
              Q : out std_logic_vector(15 downto 0));
end program_counter;

architecture behavioural of program_counter is
	signal pc_value : std_logic_vector(15 downto 0) := X"0000"; -- PC needs to be initialized as 0x0000
	signal sign_extension : std_logic_vector(9 downto 0);
	signal branch : std_logic_vector(15 downto 0);
	
    begin
        Q <= pc_value;
    
        -- entend the value of the MSB of the destination value
        sign_extension <= "1111111111" when DR(2) = '1' else
                          "0000000000";
        -- concatenate and sign extend
        branch <= sign_extension & DR & SB;
        
        pc : process(CLK)
        begin
            if(rising_edge(CLK)) then
                if(PI = '1') then
                    pc_value <= pc_value + 1;
                elsif (PL = '1') then
                    pc_value <= pc_value + branch;
                end if;
            end if;
        end process;    
	end behavioural;