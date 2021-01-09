library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity function_unit is
      Port (A_BUS : in std_logic_vector (15 downto 0);
            B_BUS : in std_logic_vector (15 downto 0);
            FS : in std_logic_vector (4 downto 0);
            F : out std_logic_vector (15 downto 0);
            C : out std_logic;
            V : out std_logic;
            Z : out std_logic;
            N : out std_logic);
end function_unit;

architecture Behavioral of function_unit is

component func_operand_modifier is
    Port (B_BUS : in std_logic_vector(15 downto 0);
          S0 : in std_logic;
          S1 : in std_logic;
          Y : out std_logic_vector(15 downto 0));
end component;

component ripple_carry_16bit is
  Port (A : in std_logic_vector (15 downto 0);
        B : in std_logic_vector (15 downto 0);
        C_IN : in std_logic;
        SUM : out std_logic_vector (15 downto 0);
        C_OUT : out std_logic;
        V : out std_logic);
end component;

component logic_unit is
  Port (A : in std_logic_vector (15 downto 0);
        B : in std_logic_vector (15 downto 0);
        LOGIC_SELECT_0 : in std_logic;
        LOGIC_SELECT_1 : in std_logic;
        RESULT : out std_logic_vector (15 downto 0));
end component;

component shifter_16bit is
  Port (B : in std_logic_vector (15 downto 0);
        SHIFT_SELECT_0 : in std_logic;
        SHIFT_SELECT_1 : in std_logic;
        RESULT : out std_logic_vector (15 downto 0));
  end component;
  
component zero_detect is
  Port (I : in std_logic_vector(15 downto 0);
        RESULT : out std_logic);
end component;

component mux2_16bit is
	Port (IN_0 : in std_logic_vector(15 downto 0);
		  IN_1 : in std_logic_vector(15 downto 0);
		  S : in std_logic;
		  Z : out std_logic_vector(15 downto 0));
	end component;

signal Y, adder_result, logic_result, shifter_result, alu_result, final_result: std_logic_vector(15 downto 0);
signal C_IN : std_logic;
  
begin
    C_IN <= FS(0);
    
    y_out : func_operand_modifier PORT MAP (
                            B_BUS => B_BUS,
                            S0 => FS(2),
                            S1 => FS(1),
                            Y => Y);
                           
    adder : ripple_carry_16bit PORT MAP (
                                    A => A_BUS,
                                    B => Y,
                                    C_IN => C_IN,
                                    SUM => adder_result,
                                    C_OUT => C,
                                    V => V);
                                    
    logic : logic_unit PORT MAP (
                            A => A_BUS,
                            B => Y,
                            LOGIC_SELECT_0 => FS(1),
                            LOGIC_SELECT_1 => FS(2),
                            RESULT => logic_result);
                            
    shifter : shifter_16bit PORT MAP (
                                 B => Y,
                                 SHIFT_SELECT_0 => FS(2),
                                 SHIFT_SELECT_1 => FS(3),
                                 RESULT => shifter_result);
                                 
    alu_mux : mux2_16bit PORT MAP (
                              IN_0 => adder_result,
		                      IN_1 => logic_result,
		                      S => FS(3),
		                      Z => alu_result);
		                      
    fu_mux : mux2_16bit PORT MAP (
                             IN_0 => alu_result,
		                     IN_1 => shifter_result,
		                     S => FS(4),
		                     Z => final_result);
		                     
    zero : zero_detect PORT MAP (
                            I => final_result,
                            RESULT => Z);
    
    N <= final_result(15);
    F <= final_result;      
    
end Behavioral;
