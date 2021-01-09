--------------------------------------------------------------------------------
-- Company: Trinity College
-- Engineer: Stephen Rowe (Student ID 14319662)
--
-- Register (16-bit)
--------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity register_16bit is
	Port (D : in std_logic_vector(15 downto 0);
		  LOAD, RW, CLK : in std_logic;
		  Q : out std_logic_vector(15 downto 0));
	end register_16bit;
	
architecture Behavioural of register_16bit is
    signal register_value : std_logic_vector(15 downto 0) := X"0000";
    -- initialise register value as 0x0000
	begin
	   Q <= register_value;
		process(CLK)
		begin
			if(rising_edge(CLK)) then
				if LOAD = '1' AND RW = '1' then
					register_value <= D after 1 ns;
				end if;
			end if;
		end process;
	end Behavioural;
	