---------------------------------------------------------------------------------
-- Company: Trinity College
-- Engineer: Stephen Rowe (Student ID 14319662)
--
-- Microcoded Instruction Set Processor
--------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;

entity processor_full is
end processor_full;

architecture behavioural of processor_full is
    -- DATAPATH 
    component datapath_9x16bit is
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
            DATA_IN : in std_logic_vector (15 downto 0); -- From MEM or PC
            ADDRESS_OUT : out std_logic_vector (15 downto 0);
            DATA_OUT : out std_logic_vector (15 downto 0);
            V : out std_logic;
            C : out std_logic;
            N : out std_logic;
            Z : out std_logic);
    end component;
    
    -- CONTROL UNIT
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
    

    -- MEMORY
    component memory_512x16 is
        Port (address : in unsigned (15 downto 0);
              write_data : in std_logic_vector(15 downto 0);
              MemWrite : in std_logic;
              read_data : out std_logic_vector(15 downto 0));
    end component;
    
    -- Three registers in Control Unit
    signal PC_OUT_internal : std_logic_vector (15 downto 0);
    signal CAR_OUT_internal : std_logic_vector (15 downto 0);
    signal IR_OUT_internal : std_logic_vector (15 downto 0);
    
    -- These signals are all called internal, because we need to be able
    -- to transfer the output between components. Lets say one component
    -- outputs the signal C, and another accepts it. Then we need the
    -- singal C_internal that they can both either modify or read
    signal C_internal : std_logic;
    signal V_internal : std_logic;
    signal Z_internal : std_logic;
    signal N_internal : std_logic;
    signal MW_internal : std_logic;
    signal MM_internal : std_logic;
    signal RW_internal : std_logic;
    signal MD_internal : std_logic;
    signal FS_internal : std_logic_vector(4 downto 0);
    signal MB_internal : std_logic;
    signal TB_internal : std_logic;
    signal TA_internal : std_logic;
    signal TD_internal : std_logic;
    signal PL_internal_x : std_logic;
    signal PI_internal_x : std_logic;
    signal IL_internal_x : std_logic;
    signal MC_internal_x : std_logic;
    signal MS_internal_x : std_logic_vector(2 downto 0);
    signal NA_internal_x : std_logic_vector(7 downto 0);
    signal DR_internal : std_logic_vector (2 downto 0);
    signal SA_internal : std_logic_vector (2 downto 0);
    signal SB_internal : std_logic_vector (2 downto 0); 

    -- Values coming to and from memory (either addresses or data)
    signal ADDRESS_OUT_DP_internal : std_logic_vector (15 downto 0);
    signal DATA_OUT_DP_internal : std_logic_vector (15 downto 0);
    signal DATA_OUT_MEM_internal : std_logic_vector (15 downto 0);
    
    signal ADDRESS_OUT_DP_unsigned : unsigned (15 downto 0);
    
    signal CLK : std_logic := '0';
    constant Clk_period : time := 50 ns;    
    
    begin
        CLK <= not CLK after Clk_period/2;
        ADDRESS_OUT_DP_unsigned <= unsigned(ADDRESS_OUT_DP_internal);  -- type cast from a vector to an unsigned (for the address value of memory)

    ctrl: mp_control_256x28 PORT MAP (
                                 CLK => CLK,
                                 C => C_internal,
                                 V => V_internal,
                                 Z => Z_internal,
                                 N => N_internal,
                                 IR_IN => DATA_OUT_MEM_internal,
                                 MW => MW_internal,
                                 MM => MM_internal,
                                 RW => RW_internal,
                                 MD => MD_internal,
                                 FS => FS_internal,
                                 MB => MB_internal,
                                 TB => TB_internal,
                                 TA => TA_internal,
                                 TD => TD_internal,
                                 PL_out => PL_internal_x,
                                 PI_out => PI_internal_x,
                                 IL_out => IL_internal_x,
                                 MC_out => MC_internal_x,
                                 MS_out => MS_internal_x,
                                 NA_out => NA_internal_x,
                                 DR => DR_internal,
                                 SA => SA_internal,
                                 SB => SB_internal,
                                 PC_OUT => PC_OUT_internal,
                                 CAR_OUT => CAR_OUT_internal,
                                 IR_OUT => IR_OUT_internal );
                                 
    dtp : datapath_9x16bit PORT MAP (
                                CLK => CLK,
                                RW => RW_internal,
                                DR => DR_internal,
                                SA => SA_internal,
                                SB => SB_internal,
                                TD => TD_internal,
                                TA => TA_internal,
                                TB => TB_internal,
                                MB => MB_internal,
                                MD => MD_internal,
                                MM => MM_internal,
                                FS => FS_internal,
                                PC => PC_OUT_internal,
                                DATA_IN => DATA_OUT_MEM_internal,
                                ADDRESS_OUT => ADDRESS_OUT_DP_internal,
                                DATA_OUT => DATA_OUT_DP_internal,
                                V => V_internal,
                                C => C_internal,
                                N => N_internal,
                                Z => Z_internal );
                                
   mem : memory_512x16 PORT MAP (
                            address => ADDRESS_OUT_DP_unsigned,
                            write_data => DATA_OUT_DP_internal,
                            MemWrite => MW_internal,
                            read_data => DATA_OUT_MEM_internal );

end behavioural;
