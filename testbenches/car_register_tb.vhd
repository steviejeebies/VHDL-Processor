---------------------------------------------------------------------------------
-- Company: Trinity College
-- Engineer: Stephen Rowe (Student ID 14319662)
--
-- CAR Register Testbench
--------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.all;

entity car_register_tb is
end car_register_tb;

architecture behavioural of car_register_tb is
    component car_register is
        Port (CLK, ms_mux_result : in std_logic;
              D : in std_logic_vector(15 downto 0);
              Q : out std_logic_vector(15 downto 0));
    end component;
    
    signal CLK : std_logic := '0';
	signal ms_mux_result : std_logic := '0';
	signal D : std_logic_vector(15 downto 0);
	signal Q : std_logic_vector(15 downto 0);
	
	constant Clk_period : time := 50 ns;
	
    begin
        CLK <= not CLK after Clk_period/2;
    	uut : car_register PORT MAP(CLK => CLK,
                                    ms_mux_result => ms_mux_result,
                                    D => D,
                                    Q => Q);
        
        stim : process
        begin
            -- see the CAR increment
            ms_mux_result <= '0';
            wait for Clk_period;
            
            
            -- see the CAR load
            D <= X"ABBA";
            ms_mux_result <= '1';
            wait for 100 ns;
            
        end process;    
	end behavioural;