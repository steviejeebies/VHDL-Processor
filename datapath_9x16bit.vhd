---------------------------------------------------------------------------------
-- Company: Trinity College
-- Engineer: Stephen Rowe (Student ID 14319662)
--
-- Datapath (with 8 16-bit registers + 1 Address Register)
--------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity datapath_9x16bit is
  Port (CLK : in std_logic;
        RW : in std_logic;
		DR : in std_logic_vector (2 downto 0); -- DR
		SA : in std_logic_vector (2 downto 0); -- SA
		SB : in std_logic_vector (2 downto 0); -- SB
		TD : in std_logic;    -- Concatenated with SD
		TA : in std_logic;    -- Concatenated with SA
		TB : in std_logic;    -- Concatenated with SB
		MB : in std_logic;
		MD : in std_logic;
		MM : in std_logic; 
		FS : in std_logic_vector (4 downto 0);
		PC : in std_logic_vector (15 downto 0); -- for MM Mux
		DATA_IN : in std_logic_vector (15 downto 0); -- From MEM
		ADDRESS_OUT : out std_logic_vector (15 downto 0);
		DATA_OUT : out std_logic_vector (15 downto 0);
		V : out std_logic;
		C : out std_logic;
		N : out std_logic;
		Z : out std_logic);
end datapath_9x16bit;

architecture Behavioral of datapath_9x16bit is
component register_file_9x16bit is
	Port (CLK : in std_logic;
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
	end component;
	
component function_unit is
      Port (A_BUS : in std_logic_vector (15 downto 0);
            B_BUS : in std_logic_vector (15 downto 0);
            FS : in std_logic_vector (4 downto 0);
            F : out std_logic_vector (15 downto 0);
            C : out std_logic;
            V : out std_logic;
            Z : out std_logic;
            N : out std_logic);
    end component;

component mux2_16bit is
	Port (IN_0 : in std_logic_vector(15 downto 0);
		  IN_1 : in std_logic_vector(15 downto 0);
		  S : in std_logic;
		  Z : out std_logic_vector(15 downto 0));
    end component;

signal B, F, D_BUS, A_BUS, B_BUS : std_logic_vector (15 downto 0);
signal CONSTANT_IN_ZERO_FILLER : std_logic_vector (15 downto 0);
begin
    DATA_OUT <= B_BUS;
    CONSTANT_IN_ZERO_FILLER <= "0000000000000" & SB;

    register_file : register_file_9x16bit PORT MAP (
                                               CLK => CLK,
                                               DR => DR,
                                               SA => SA,
                                               SB => SB,
                                               TD => TD,
                                               TA => TA,
                                               TB => TB,
                                               D => D_BUS,
                                               RW => RW,
                                               A_OUT_REG => A_BUS,
                                               B_OUT_REG => B );
                                               
    md_mux : mux2_16bit PORT MAP (
                             IN_0 => F,
                             IN_1 => DATA_IN,
                             S => MD,
                             Z => D_BUS );
                             
    mb_mux : mux2_16bit PORT MAP (
                             IN_0 => B,
                             IN_1 => CONSTANT_IN_ZERO_FILLER,
                             S => MB,
                             Z => B_BUS );
                             
    mm_mux : mux2_16bit PORT MAP (
                             IN_0 => A_BUS,
                             IN_1 => PC,
                             S => MM,
                             Z => ADDRESS_OUT );
                                               
    f_unit : function_unit PORT MAP (
                                A_BUS => A_BUS,
                                B_BUS => B_BUS,
                                FS => FS,
                                F => F,
                                C => C,
                                V => V,
                                Z => Z,
                                N => N );        

end Behavioral;
