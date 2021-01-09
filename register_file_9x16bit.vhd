---------------------------------------------------------------------------------
-- Company: Trinity College
-- Engineer: Stephen Rowe (Student ID 14319662)
--
-- Register File (8 16-bit registers + 1 Address Register)
--------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity register_file_9x16bit is
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
	end register_file_9x16bit;
	
architecture Behavioural of register_file_9x16bit is 
	COMPONENT register_16bit
		Port(D : in std_logic_vector(15 downto 0);
			 LOAD : in std_logic;
			 RW : in std_logic;
			 CLK : in std_logic;
			 Q : out std_logic_vector(15 downto 0));
	END COMPONENT;
	
	COMPONENT decoder_4to9
		Port(a0 : in std_logic;
			 a1 : in std_logic;
			 a2 : in std_logic;
			 a3 : in std_logic;
			 q0 : out std_logic;
			 q1 : out std_logic;
			 q2 : out std_logic;
			 q3 : out std_logic;
			 q4 : out std_logic;
			 q5 : out std_logic;
			 q6 : out std_logic;
			 q7 : out std_logic;
			 qA : out std_logic);
	END COMPONENT;
	
	COMPONENT mux9_16bit
		Port(IN_0 : in std_logic_vector(15 downto 0);
			 IN_1 : in std_logic_vector(15 downto 0);
			 IN_2 : in std_logic_vector(15 downto 0);
			 IN_3 : in std_logic_vector(15 downto 0);
			 IN_4 : in std_logic_vector(15 downto 0);
			 IN_5 : in std_logic_vector(15 downto 0);
			 IN_6 : in std_logic_vector(15 downto 0);
			 IN_7 : in std_logic_vector(15 downto 0);
			 IN_ADR : in std_logic_vector(15 downto 0);
			 S0 : in std_logic;
			 S1 : in std_logic;
			 S2 : in std_logic;
			 S3 : in std_logic;
			 Z : out std_logic_vector(15 downto 0));
	END COMPONENT;
	
	-- As we have a shared RW signals across all the registers, we also need a LOAD signal to specify 
	-- which of the registers we are actually writing into
	signal LOAD_RA, LOAD_R0, LOAD_R1, LOAD_R2, LOAD_R3, LOAD_R4, LOAD_R5, LOAD_R6, LOAD_R7 : std_logic;
	
	-- values stored in each of the 9 registers
	signal regADR_q, reg0_q, reg1_q, reg2_q, reg3_q, reg4_q, reg5_q, reg6_q, reg7_q : std_logic_vector(15 downto 0);
	
	begin	                                    
	   reg00 : register_16bit PORT MAP(D => D,
                                       LOAD => LOAD_R0,
                                       RW => RW,
                                       CLK => CLK,
                                       Q => reg0_q);
							  
	   reg01 : register_16bit PORT MAP(D => D,
                                       LOAD => LOAD_R1,
                                       RW => RW,
                                       CLK => CLK,
                                       Q => reg1_q);
                                        
	   reg02 : register_16bit PORT MAP(D => D,
                                       LOAD => LOAD_R2,
                                       RW => RW,
                                       CLK => CLK,
                                       Q => reg2_q);
		
	   reg03 : register_16bit PORT MAP(D => D,
                                       LOAD => LOAD_R3,
                                       RW => RW,
                                       CLK => CLK,
                                       Q => reg3_q);
							  
	   reg04 : register_16bit PORT MAP(D => D,
                                       LOAD => LOAD_R4,
                                       RW => RW,
                                       CLK => CLK,
                                       Q => reg4_q);
							  
	   reg05 : register_16bit PORT MAP(D => D,
                                       LOAD => LOAD_R5,
                                       RW => RW,                                        
                                       CLK => CLK,
                                       Q => reg5_q);
		
	   reg06 : register_16bit PORT MAP(D => D,
                                       LOAD => LOAD_R6,
                                       RW => RW,
                                       CLK => CLK,
                                       Q => reg6_q);
		
	   reg07 : register_16bit PORT MAP(D => D,
                                       LOAD => LOAD_R7,
                                       RW => RW,
                                       CLK => CLK,
                                       Q => reg7_q);
                                       
	   regADR : register_16bit PORT MAP(D => D,
	                                   LOAD => LOAD_RA,
	                                   RW => RW,
	                                   CLK => CLK,
	                                   Q => regADR_q);
							  
	   destination_select : decoder_4to9 PORT MAP(a0 => DR(0),
                                                  a1 => DR(1),
										          a2 => DR(2),
										          a3 => TD,
                                                  Q0 => LOAD_R0,
                                                  Q1 => LOAD_R1,
                                                  Q2 => LOAD_R2,
                                                  Q3 => LOAD_R3,
									              Q4 => LOAD_R4,
										          Q5 => LOAD_R5,
                                                  Q6 => LOAD_R6,
                                                  Q7 => LOAD_R7,
                                                  QA => LOAD_RA);
		
	   a_select : mux9_16bit PORT MAP(IN_0 => reg0_q,
                                      IN_1 => reg1_q,
                                      IN_2 => reg2_q,
                                      IN_3 => reg3_q,
                                      IN_4 => reg4_q,
                                      IN_5 => reg5_q,
                                      IN_6 => reg6_q,
                                      IN_7 => reg7_q,
                                      IN_ADR => regADR_q,
                                      S0 => SA(0),
                                      S1 => SA(1),
                                      S2 => SA(2),
                                      S3 => TA,
                                      Z => A_OUT_REG);
                                                                                                     
       b_select : mux9_16bit PORT MAP(IN_0 => reg0_q,
                                      IN_1 => reg1_q,
                                      IN_2 => reg2_q,
                                      IN_3 => reg3_q,
                                      IN_4 => reg4_q,
                                      IN_5 => reg5_q,
                                      IN_6 => reg6_q,
                                      IN_7 => reg7_q,
                                      IN_ADR => regADR_q,
                                      S0 => SB(0),
                                      S1 => SB(1),
                                      S2 => SB(2),
                                      S3 => TB,
                                      Z => B_OUT_REG);
                                      
	end Behavioural;
											
