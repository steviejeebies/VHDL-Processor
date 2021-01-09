---------------------------------------------------------------------------------
-- Company: Trinity College
-- Engineer: Stephen Rowe (Student ID 14319662)
--
-- Program Counter Testbench
--------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.all;

entity program_counter_tb is
end program_counter_tb;

architecture behavioural of program_counter_tb is
    component program_counter is
        Port( CLK, PI, PL : in std_logic;
              DR : in std_logic_vector(2 downto 0);
              SB : in std_logic_vector(2 downto 0);
              Q : out std_logic_vector(15 downto 0));
    end component;
    
    signal D : std_logic_vector(15 downto 0) := (others => '0');
    signal CLK : std_logic := '0';
	signal PI, PL : std_logic := '0';
	signal DR, SB : std_logic_vector(2 downto 0) := (others => '0');
	signal Q : std_logic_vector(15 downto 0) := (others => '0');
	
	constant Clk_period : time := 50 ns;
	
    begin
        CLK <= not CLK after Clk_period/2;
    	uut : program_counter PORT MAP(CLK => CLK,
                                       PI => PI,
                                       PL => PL,
                                       DR => DR,
                                       SB => SB,
                                       Q => Q);
        
        stim : process
        begin
            
            -- To show that PC resets to 0x00000000 on its own, we will wait
            -- a clock cycle
            wait for Clk_period;
            
            -- Adding 7 to the PC by accepting the DR|SB value
            PL <= '1';
            DR <= "000";
            SB <= "111";
            wait for Clk_period; -- PC should be 0x00000111 at this point
            
            PL <= '0';
            PI <= '1';
            -- we will leave Q to increment ~8 times. 
            wait for 400 ns;
            
            PL <= '1';
            PI <= '0';
            
            -- To show that sign extension works, we will have -15 (which is
            -- the value of the register after the imcrementing test above) 
            -- loaded as the branch vale, so that the register value returns
            -- to 0 again.
            DR <= "110";
            SB <= "001";
            
            wait for Clk_period;
            
            PL <= '0';
            
        end process;    
	end behavioural;