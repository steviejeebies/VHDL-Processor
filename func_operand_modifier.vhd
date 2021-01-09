library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity func_operand_modifier is
  Port (B_BUS : in std_logic_vector(15 downto 0);
        S0 : in std_logic;
        S1 : in std_logic;
        Y : out std_logic_vector(15 downto 0));
end func_operand_modifier;

architecture Behavioral of func_operand_modifier is
component mux2_1bit is
	Port (IN_0, IN_1 : in std_logic;
		  S : in std_logic;
		  Z : out std_logic);
	end component;

begin
    -- total propagation delay = 3 ns (for multiplexers)
    bit00 : mux2_1bit PORT MAP (
                        IN_0 => S0,
                        IN_1 => S1,
                        S => B_BUS(0),
                        Z => Y(0));

    bit01 : mux2_1bit PORT MAP (
                        IN_0 => S0,
                        IN_1 => S1,
                        S => B_BUS(1),
                        Z => Y(1));
                        
    bit02 : mux2_1bit PORT MAP (
                        IN_0 => S0,
                        IN_1 => S1,
                        S => B_BUS(2),
                        Z => Y(2));
                        
    bit03 : mux2_1bit PORT MAP (
                        IN_0 => S0,
                        IN_1 => S1,
                        S => B_BUS(3),
                        Z => Y(3));
                        
    bit04 : mux2_1bit PORT MAP (
                        IN_0 => S0,
                        IN_1 => S1,
                        S => B_BUS(4),
                        Z => Y(4));
                        
    bit05 : mux2_1bit PORT MAP (
                        IN_0 => S0,
                        IN_1 => S1,
                        S => B_BUS(5),
                        Z => Y(5));
                        
    bit06 : mux2_1bit PORT MAP (
                        IN_0 => S0,
                        IN_1 => S1,
                        S => B_BUS(6),
                        Z => Y(6));
                        
    bit07 : mux2_1bit PORT MAP (
                        IN_0 => S0,
                        IN_1 => S1,
                        S => B_BUS(7),
                        Z => Y(7));
                        
    bit08 : mux2_1bit PORT MAP (
                        IN_0 => S0,
                        IN_1 => S1,
                        S => B_BUS(8),
                        Z => Y(8));
                        
    bit09 : mux2_1bit PORT MAP (
                        IN_0 => S0,
                        IN_1 => S1,
                        S => B_BUS(9),
                        Z => Y(9));

    bit10 : mux2_1bit PORT MAP (
                        IN_0 => S0,
                        IN_1 => S1,
                        S => B_BUS(10),
                        Z => Y(10));
                        
    bit11 : mux2_1bit PORT MAP (
                        IN_0 => S0,
                        IN_1 => S1,
                        S => B_BUS(11),
                        Z => Y(11));
                        
    bit12 : mux2_1bit PORT MAP (
                        IN_0 => S0,
                        IN_1 => S1,
                        S => B_BUS(12),
                        Z => Y(12));
                        
    bit13 : mux2_1bit PORT MAP (
                        IN_0 => S0,
                        IN_1 => S1,
                        S => B_BUS(13),
                        Z => Y(13));
                        
    bit14 : mux2_1bit PORT MAP (
                        IN_0 => S0,
                        IN_1 => S1,
                        S => B_BUS(14),
                        Z => Y(14));
                        
    bit15 : mux2_1bit PORT MAP (
                        IN_0 => S0,
                        IN_1 => S1,
                        S => B_BUS(15),
                        Z => Y(15));
end Behavioral;
