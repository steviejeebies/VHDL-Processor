--------------------------------------------------------------------------------
-- Company: Trinity College
-- Engineer: Stephen Rowe (Student ID 14319662)
--
-- Test bench for Register File (Eight 16-bit registers)
--------------------------------------------------------------------------------


-- REALLY OUTDATED FILE, MAY HAVE TO START OVER---
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
 
ENTITY register_file_9x16bit_tb IS
END register_file_9x16bit_tb;
 
ARCHITECTURE behavioural OF register_file_9x16bit_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
    COMPONENT register_file_9x16bit
    PORT(CLK : in std_logic;
	     DR : in std_logic_vector (2 downto 0);
	     SA : in std_logic_vector (2 downto 0);
		 SB : in std_logic_vector (2 downto 0);
		 TD : in std_logic;    -- Concatenated with SD
		 TA : in std_logic;    -- Concatenated with SA
		 TB : in std_logic;    -- Concatenated with SB
		 D : in std_logic_vector (15 downto 0);
		 RW : in std_logic;
		 A_OUT_REG : out std_logic_vector (15 downto 0);
		 B_OUT_REG : out std_logic_vector (15 downto 0));
    END COMPONENT;
    

   --Inputs
    signal CLK : std_logic := '0';
    signal DR : std_logic_vector(2 downto 0) := "000";
    signal SA : std_logic_vector(2 downto 0) := "000";
    signal SB : std_logic_vector(2 downto 0) := "000";
    signal TD : std_logic := '0';
    signal TA : std_logic := '0';
    signal TB : std_logic := '0';
    signal D : std_logic_vector(15 downto 0) := (others => '0');
    signal RW : std_logic := '0';
    
 	--Outputs
    signal A_OUT_REG : std_logic_vector(15 downto 0);
    signal B_OUT_REG : std_logic_vector(15 downto 0);
    
    --Constants 
    constant Clk_period : time := 50 ns;
 
begin
    CLK <= not CLK after Clk_period/2;
   
    uut: register_file_9x16bit PORT MAP (
                                    CLK => CLK,
                                    DR => DR,
                                    SA => SA,
                                    SB => SB,
                                    TD => TD,
                                    TA => TA,
                                    TB => TB,
                                    D => D,
                                    RW => RW,
                                    A_OUT_REG => A_OUT_REG,
                                    B_OUT_REG => B_OUT_REG );
          
    stim_proc: process
    begin
         TD <= '0';  
         TA <= '0';
         TB <= '0';  
        
        RW <= '1'; -- start writing
    
        -- Fill R0 to R7 with the constants
        DR <= "000";
        D <= X"2222";  wait for 100 ns;
        DR <= "001";
        D <= X"4444";  wait for 100 ns;
        DR <= "010";
        D <= X"5555";  wait for 100 ns;
        DR <= "011";
        D <= X"8888";  wait for 100 ns;
        DR <= "100";
        D <= X"AAAA";  wait for 100 ns;
        DR <= "101";
        D <= X"BBBB";  wait for 100 ns;
        DR <= "110";
        D <= X"CCCC";  wait for 100 ns;
        DR <= "111";
        D <= X"FFFF";  wait for 100 ns;
        D <= X"0000";
        
        RW <= '0'; -- finished writing
        
        -- make sure both SA and SB are reading out the values in the registers correctly
        SA <= "000"; SB <= "000";  wait for 100 ns;   
        SA <= "001"; SB <= "001";  wait for 100 ns;
        SA <= "010"; SB <= "010";  wait for 100 ns;
        SA <= "011"; SB <= "011";  wait for 100 ns;
        SA <= "100"; SB <= "100";  wait for 100 ns;
        SA <= "101"; SB <= "101";  wait for 100 ns;
        SA <= "110"; SB <= "110";  wait for 100 ns;
        SA <= "111"; SB <= "111";  wait for 100 ns;
        
        -- testing the address register
        
         -- first, set the TD, TA, TB so all are pointing to the Address Regsiter
         TD <= '1';  
         TA <= '1';
         TB <= '1';
         wait for 100 ns;
         
         RW <= '1'; -- start writing
         D <= X"5555"; -- write 0x5555 to address register
         wait for 100 ns;
         
         -- A_OUT_REG and B_OUT_REG should now be outputting 0x5555
         
         -- Now I will iterate through all possible values of SA and SB to show that once
         -- their TA or TB bit is set, they will always point to the Address Register
        SA <= "000"; SB <= "000";  wait for 100 ns;   
        SA <= "001"; SB <= "001";  wait for 100 ns;
        SA <= "010"; SB <= "010";  wait for 100 ns;
        SA <= "011"; SB <= "011";  wait for 100 ns;
        SA <= "100"; SB <= "100";  wait for 100 ns;
        SA <= "101"; SB <= "101";  wait for 100 ns;
        SA <= "110"; SB <= "110";  wait for 100 ns;
        SA <= "111"; SB <= "111";  wait for 100 ns;
         
         -- clear address register
         D <= X"0000"; -- write 0x0000
         wait for 100 ns;
         
        
    end process;

end behavioural;
