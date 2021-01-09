---------------------------------------------------------------------------------
-- Company: Trinity College
-- Engineer: Stephen Rowe (Student ID 14319662)
--
-- CAR Register
--------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.all;

entity car_register is
        Port (CLK, ms_mux_result : in std_logic;
              D : in std_logic_vector(15 downto 0);
              Q : out std_logic_vector(15 downto 0));
end car_register;

architecture behavioural of car_register is	
    -- This entity is a modified version of the register file, to allow for incrementing and
    -- loading specifically depending on the result of the MS multiplexer.
    
	signal car_value : std_logic_vector(15 downto 0) := X"00C0"; -- CAR needs to be initialised as 192 (IF)
	
    begin
        Q <= car_value;
        car : process(CLK)
        begin
            if(rising_edge(CLK)) then
                if(ms_mux_result = '0') then
                    car_value <= car_value + 1;
                else
                    car_value <= D;
                end if;
            end if;
        end process;    
	end behavioural;