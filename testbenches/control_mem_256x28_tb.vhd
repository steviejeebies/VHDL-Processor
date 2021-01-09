---------------------------------------------------------------------------------
-- Company: Trinity College
-- Engineer: Stephen Rowe (Student ID 14319662)
--
-- Control Memory Testbench
--------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity control_mem_256x28_tb is
end control_mem_256x28_tb;

architecture behavioural of control_mem_256x28_tb is
    component control_mem_256x28 is
        Port ( MW : out std_logic;
               MM : out std_logic;
               RW : out std_logic;
               MD : out std_logic;
               FS : out std_logic_vector(4 downto 0);
               MB : out std_logic;
               TB : out std_logic;
               TA : out std_logic;
               TD : out std_logic;
               PL : out std_logic;
               PI : out std_logic;
               IL : out std_logic;
               MC : out std_logic;
               MS : out std_logic_vector(2 downto 0);
               NA : out std_logic_vector(7 downto 0);
               IN_CAR : in std_logic_vector(7 downto 0));
    end component;
    
    -- inputs
    signal IN_CAR : std_logic_vector(7 downto 0);
    
    -- outputs
    signal MW, MM, RW, MD, MB, TB, TA, TD, PL, PI, IL, MC : std_logic;
    signal MS : std_logic_vector(2 downto 0);
    signal FS : std_logic_vector(4 downto 0);
    signal NA : std_logic_vector(7 downto 0);
    
    begin
        uut : control_mem_256x28 PORT MAP(
                                 MW => MW,
                                 MM => MM,
                                 RW => RW,
                                 MD => MD,
                                 FS => FS,
                                 MB => MB,
                                 TB => TB,
                                 TA => TA,
                                 TD => TD,
                                 PL => PL,
                                 PI => PI,
                                 IL => IL,
                                 MC => MC,
                                 MS => MS,
                                 NA => NA,
                                 IN_CAR => IN_CAR );
    
    stim : process
    begin
        -- Initialise IN_CAR as the 'Instruction Fetch' state in Control Memory
        
        IN_CAR <= NA;
        
        wait for 100 ns;
        
        -- Now we'll just go through the states, depending on the NA of the instruction
        -- we're currently on. Since MC doesn't matter here (i.e. we're not reading from 
        -- the IR, just the NA), then we'll go through a loop of IF -> EXO -> ADI over and over.
    end process;
end behavioural;
                
                                                          
                                                
                                                
           