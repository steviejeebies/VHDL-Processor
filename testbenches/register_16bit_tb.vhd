--------------------------------------------------------------------------------
-- Company: Trinity College
-- Engineer: Stephen Rowe (Student ID 14319662)
--
-- Test Bench for Register (16-bit)
--------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
 
ENTITY register_16bit_tb IS
END register_16bit_tb;
 
ARCHITECTURE behavior OF register_16bit_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
	COMPONENT register_16bit
		Port (D : in std_logic_vector(15 downto 0);
		      load, RW, Clk : in std_logic;
		      Q : out std_logic_vector(15 downto 0));
	END COMPONENT;   
	
	--Inputs
    signal D : std_logic_vector(15 downto 0) := (others => '0');
    signal load : std_logic := '0';
    signal Clk : std_logic := '0';
    signal RW : std_logic := '1';
    
 	--Outputs
    signal Q : std_logic_vector(15 downto 0) := (others => '0');
    
    --Constants
    constant hex_FFFF : std_logic_vector(15 downto 0) := "1111111111111111";
	constant hex_CCCC : std_logic_vector(15 downto 0) := "1100110011001100";
	
    
    --Clock Period
    constant Clk_period : time := 100 ns;
	
BEGIN
	-- Instantiate the Unit Under Test (UUT)
   uut: register_16bit PORT MAP (
          D => D,
          load => load,
          RW => RW,
          Clk => Clk,
          Q => Q);
          
          Clk <= not Clk after Clk_period/2;

   stim_proc: process
   
   begin	
        D <= hex_FFFF;      -- instantiate D as FFFF, but register will not store
                            -- the value as 'load' is already set to 0
        wait for 200 ns;
		
        load <= '1';        -- register will now store FFFF
        wait for 200 ns;
		
        load <= '0';        -- tell register not to store value
        D <= hex_CCCC;      -- D is now CCCC, register will remain as FFFF
        wait for 200 ns;    
        
        load <= '1';        -- register will now store CCCC
        wait for 100 ns;
        load <= '0';        -- keep CCCC in register while this process loops around again
    end process;
	
END;
