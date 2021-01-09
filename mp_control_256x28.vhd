---------------------------------------------------------------------------------
-- Company: Trinity College
-- Engineer: Stephen Rowe (Student ID 14319662)
--
-- Microprogrammed Control Unit (with 256x28-bit Control Memory)
--------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mp_control_256x28 is
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
end mp_control_256x28;

architecture Behavioral of mp_control_256x28 is
    -- Control Memory
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
    
    -- MS Multiplexer
    component mux8_1bit
		Port (IN_0, IN_1, IN_2, IN_3, IN_4, IN_5, IN_6, IN_7 : in std_logic;
		      S0, S1, S2 : in std_logic;
		      Z : out std_logic );
	end component;
	
	component program_counter is
        Port (CLK, PI, PL : in std_logic;
              DR : in std_logic_vector(2 downto 0);
              SB : in std_logic_vector(2 downto 0);
              Q : out std_logic_vector(15 downto 0));
    end component;
	
	-- Used for IR
	component register_16bit is
        Port (D : in std_logic_vector(15 downto 0);
              LOAD, RW, CLK : in std_logic;
              Q : out std_logic_vector(15 downto 0));
	end component;
	
	component car_register is
        Port (CLK, ms_mux_result : in std_logic;
              D : in std_logic_vector(15 downto 0);
              Q : out std_logic_vector(15 downto 0));
    end component;
	
	-- MC multiplexer
    component mux2_16bit is
        Port (IN_0 : in std_logic_vector(15 downto 0);
              IN_1 : in std_logic_vector(15 downto 0);
              S : in std_logic;
              Z : out std_logic_vector(15 downto 0));
        end component;
        
    -- Signals from the Control Memory that are internal to the Control Unit
    signal PL, PI, IL, MC : std_logic;
    signal MS : std_logic_vector(2 downto 0);
    signal NA : std_logic_vector(7 downto 0);
    signal not_C, not_Z : std_logic;
    
    -- Isolating values from IR
    signal OPCODE : std_logic_vector(15 downto 0); -- isolating opcode from IR
    signal DR_instr : std_logic_vector(2 downto 0); -- isolating DR from IR
    signal SA_instr : std_logic_vector(2 downto 0); -- isolating SA from IR
    signal SB_instr : std_logic_vector(2 downto 0); -- isolating SA from IR
    
    -- multiplexer outputs 
    signal ms_mux_result : std_logic;
    signal mc_mux_result : std_logic_vector (15 downto 0);
    
    -- register outputs
    signal program_counter_q : std_logic_vector (15 downto 0);
    signal IR_q : std_logic_vector (15 downto 0);
    signal CAR_q : std_logic_vector (15 downto 0);
    
    -- as we are using 16-bit muxes on 8-bit values, we need to 
    -- shorten/lengthen some values
    signal NA_extended : std_logic_vector (15 downto 0);
    
    begin
        -- So that we can see these values outside of the Control Unit (e.g. in a test-bench)
        CAR_OUT <= car_q;
        IR_OUT <= ir_q;
        not_C <= not C;
        not_Z <= not Z;
        PL_out <= PL;
        PI_out <= PI;
        IL_out <= IL;
        MC_out <= MC;
        MS_out <= MS;
        NA_out <= NA;
        
        PC_OUT <= program_counter_q;
       
        -- Extracting data from the Instruction register (OPCODE, DR, SA, and SB)
        DR_instr <= IR_q(8 downto 6);
        SA_instr <= IR_q(5 downto 3);
        SB_instr <= IR_q(2 downto 0);

        -- On the schematic, it said to extend the OPCODE to 8 bits,
        -- but since I'm using a 16-bit multiplexer, I will extend it to 16 bits
        OPCODE <= "000000000" & IR_q(15 downto 9);
        
        -- Need to specify these for Output
        DR <= DR_instr;
        SA <= SA_instr;
        SB <= SB_instr;
        
        -- Shortening/Lengthening some values 
        NA_extended <= "00000000" & NA;
        
        -- PROGRAM COUNTER
    	pc : program_counter PORT MAP(
    	                          CLK => CLK,
                                  PI => PI,
                                  PL => PL,
                                  DR => DR_instr,
                                  SB => SB_instr,
                                  Q => program_counter_q );
                                  
        -- MS MULTIPLEXER                               
        ms_mux : mux8_1bit PORT MAP(
                                IN_0 => '0',
                                IN_1 => '1',
                                IN_2 => C,
                                IN_3 => V,
                                IN_4 => Z,
                                IN_5 => N,
                                IN_6 => not_C,
                                IN_7 => not_Z,
                                S0 => MS(0),
                                S1 => MS(1),
                                S2 => MS(2),
                                Z => ms_mux_result ); 

        -- INSTRUCTION REGISTER
        IR : register_16bit PORT MAP(
                                 D => IR_IN,
                                 LOAD => IL,
                                 RW => '1',
                                 CLK => CLK,
                                 Q => IR_q );
        
        -- MC MULTIPLEXER                     
        mc_mux : mux2_16bit PORT MAP (
                                 IN_0 => NA_extended,
                                 IN_1 => OPCODE,
                                 S => MC,
                                 Z => mc_mux_result );
        
        -- CAR is intended to be an 8-bit register, but we can use
        -- a 16-bit register by omitting the first 8 bits when inputting
        -- it the Control Memory       
        
        -- CONTROL ADDRESS REGISTER                  
        CAR : car_register PORT MAP(
                                CLK => CLK,
                                ms_mux_result => ms_mux_result,
                                D => mc_mux_result,
                                Q => CAR_q);
                        
        -- CONTROL MEMORY         
        cntrl_mem : control_mem_256x28 PORT MAP(
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
                                            IN_CAR => CAR_q(7 downto 0));
                                         
end Behavioral;