---------------------------------------------------------------------------------
-- Company: Trinity College
-- Engineer: Stephen Rowe (Student ID 14319662)
--
-- Microprogrammed Control Unit Testbench
--------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mp_control_256x28_tb is
end mp_control_256x28_tb;

architecture behavioural of mp_control_256x28_tb is
    -- Control Memory
    component mp_control_256x28 is
          Port (CLK : in std_logic;
                C : in std_logic;
                V : in std_logic;
                Z : in std_logic;
                N : in std_logic;
                IR_IN : in std_logic_vector(15 downto 0);
                MW : out std_logic;
                MM : out std_logic;
                RW : out std_logic;
                MD : out std_logic;
                FS : out std_logic_vector(4 downto 0);
                MB : out std_logic;
                TB : out std_logic;
                TA : out std_logic;
                TD : out std_logic;
                PL_out : out std_logic;
                PI_out : out std_logic;
                IL_out : out std_logic;
                MC_out : out std_logic;
                MS_out : out std_logic_vector(2 downto 0);
                NA_out : out std_logic_vector(7 downto 0);
                DR : out std_logic_vector (2 downto 0);
                SA : out std_logic_vector (2 downto 0);
                SB : out std_logic_vector (2 downto 0);
                PC_OUT : out std_logic_vector(15 downto 0);
                CAR_OUT : out std_logic_vector(15 downto 0);
                IR_OUT : out std_logic_vector(15 downto 0));
    end component;
    
    signal CLK : std_logic := '0';
    signal C : std_logic := '0';
    signal V : std_logic := '0';
    signal Z : std_logic := '0';
    signal N : std_logic := '0';
    signal IR_IN : std_logic_vector(15 downto 0) := X"0000";
    
    -- OUTPUTS
    signal MW : std_logic;
    signal MM : std_logic;
    signal RW : std_logic;
    signal MD : std_logic;
    signal FS : std_logic_vector(4 downto 0);
    signal MB : std_logic;
    signal TB : std_logic;
    signal TA : std_logic;
    signal TD : std_logic;
    signal PL_out : std_logic;
    signal PI_out : std_logic;
    signal IL_out : std_logic;
    signal MC_out : std_logic;
    signal MS_out : std_logic_vector(2 downto 0);
    signal NA_out : std_logic_vector(7 downto 0);
    signal DR : std_logic_vector (2 downto 0);
    signal SA : std_logic_vector (2 downto 0);
    signal SB : std_logic_vector (2 downto 0);
    signal PC_OUT : std_logic_vector(15 downto 0);
    signal CAR_OUT : std_logic_vector(15 downto 0);
    signal IR_OUT : std_logic_vector(15 downto 0);
    
    constant Clk_period : time := 50 ns;
           
    begin
        CLK <= not CLK after Clk_period/2;
    
        uut: mp_control_256x28 PORT MAP (
                                         CLK => CLK,
                                         C => C,
                                         V => V,
                                         Z => Z,
                                         N => N,
                                         IR_IN => IR_IN,
                                         MW => MW,
                                         MM => MM,
                                         RW => RW,
                                         MD => MD,
                                         FS => FS,
                                         MB => MB,
                                         TB => TB,
                                         TA => TA,
                                         TD => TD,
                                         PL_out => PL_out,
                                         PI_out => PI_out,
                                         IL_out => IL_out,
                                         MC_out => MC_out,
                                         MS_out => MS_out,
                                         NA_out => NA_out,
                                         DR => DR,
                                         SA => SA,
                                         SB => SB,
                                         PC_OUT => PC_OUT,
                                         CAR_OUT => CAR_OUT,
                                         IR_OUT => IR_OUT);
                                                                                             
        stim : process 
        begin
            C <= '0';
            V <= '0';
            Z <= '0';
            N <= '0';
            wait for Clk_period;
            IR_IN <= "0000011000001011";   -- LDR R0, MEM[R1];
            wait for Clk_period;
            IR_IN <= "0000000000001010";   -- ADD R0, R1, Constant
            wait for Clk_period;
            IR_IN <= "0000010000001011";   -- LDR R0, MEM[R1];
            wait for Clk_period;
            
        end process;
                                     
end behavioural;
