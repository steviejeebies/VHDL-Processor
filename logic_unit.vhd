library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity logic_unit is
  Port (A : in std_logic_vector (15 downto 0);
        B : in std_logic_vector (15 downto 0);
        LOGIC_SELECT_0 : in std_logic;
        LOGIC_SELECT_1 : in std_logic;
        RESULT : out std_logic_vector (15 downto 0));
end logic_unit;

architecture Behavioral of logic_unit is

component logic_1bit is
  Port (A : in std_logic;
        B : in std_logic;
        LOGIC_SELECT_0 : in std_logic;
        LOGIC_SELECT_1 : in std_logic;
        RESULT : out std_logic);
end component;

begin
    logic_bit_00: logic_1bit PORT MAP (
                                A => A(0),
                                B => B(0),
                                LOGIC_SELECT_0 => LOGIC_SELECT_0,
                                LOGIC_SELECT_1 => LOGIC_SELECT_1,
                                RESULT => RESULT(0)); 

    logic_bit_01: logic_1bit PORT MAP (
                                A => A(1),
                                B => B(1),
                                LOGIC_SELECT_0 => LOGIC_SELECT_0,
                                LOGIC_SELECT_1 => LOGIC_SELECT_1,
                                RESULT => RESULT(1)); 
                                
    logic_bit_02: logic_1bit PORT MAP (
                                A => A(2),
                                B => B(2),
                                LOGIC_SELECT_0 => LOGIC_SELECT_0,
                                LOGIC_SELECT_1 => LOGIC_SELECT_1,
                                RESULT => RESULT(2)); 
                                
    logic_bit_03: logic_1bit PORT MAP (
                                A => A(3),
                                B => B(3),
                                LOGIC_SELECT_0 => LOGIC_SELECT_0,
                                LOGIC_SELECT_1 => LOGIC_SELECT_1,
                                RESULT => RESULT(3)); 
                                
    logic_bit_04: logic_1bit PORT MAP (
                                A => A(4),
                                B => B(4),
                                LOGIC_SELECT_0 => LOGIC_SELECT_0,
                                LOGIC_SELECT_1 => LOGIC_SELECT_1,
                                RESULT => RESULT(4)); 
                                
    logic_bit_05: logic_1bit PORT MAP (
                                A => A(5),
                                B => B(5),
                                LOGIC_SELECT_0 => LOGIC_SELECT_0,
                                LOGIC_SELECT_1 => LOGIC_SELECT_1,
                                RESULT => RESULT(5));

    logic_bit_06: logic_1bit PORT MAP (
                                A => A(6),
                                B => B(6),
                                LOGIC_SELECT_0 => LOGIC_SELECT_0,
                                LOGIC_SELECT_1 => LOGIC_SELECT_1,
                                RESULT => RESULT(6)); 
                                
    logic_bit_07: logic_1bit PORT MAP (
                                A => A(7),
                                B => B(7),
                                LOGIC_SELECT_0 => LOGIC_SELECT_0,
                                LOGIC_SELECT_1 => LOGIC_SELECT_1,
                                RESULT => RESULT(7));
                                
    logic_bit_08: logic_1bit PORT MAP (
                                A => A(8),
                                B => B(8),
                                LOGIC_SELECT_0 => LOGIC_SELECT_0,
                                LOGIC_SELECT_1 => LOGIC_SELECT_1,
                                RESULT => RESULT(8)); 
                                
    logic_bit_09: logic_1bit PORT MAP (
                                A => A(9),
                                B => B(9),
                                LOGIC_SELECT_0 => LOGIC_SELECT_0,
                                LOGIC_SELECT_1 => LOGIC_SELECT_1,
                                RESULT => RESULT(9)); 
                                
    logic_bit_10: logic_1bit PORT MAP (
                                A => A(10),
                                B => B(10),
                                LOGIC_SELECT_0 => LOGIC_SELECT_0,
                                LOGIC_SELECT_1 => LOGIC_SELECT_1,
                                RESULT => RESULT(10));
                                
    logic_bit_11: logic_1bit PORT MAP (
                                A => A(11),
                                B => B(11),
                                LOGIC_SELECT_0 => LOGIC_SELECT_0,
                                LOGIC_SELECT_1 => LOGIC_SELECT_1,
                                RESULT => RESULT(11)); 
                                
    logic_bit_12: logic_1bit PORT MAP (
                                A => A(12),
                                B => B(12),
                                LOGIC_SELECT_0 => LOGIC_SELECT_0,
                                LOGIC_SELECT_1 => LOGIC_SELECT_1,
                                RESULT => RESULT(12)); 

    logic_bit_13: logic_1bit PORT MAP (
                                A => A(13),
                                B => B(13),
                                LOGIC_SELECT_0 => LOGIC_SELECT_0,
                                LOGIC_SELECT_1 => LOGIC_SELECT_1,
                                RESULT => RESULT(13)); 

    logic_bit_14: logic_1bit PORT MAP (
                                A => A(14),
                                B => B(14),
                                LOGIC_SELECT_0 => LOGIC_SELECT_0,
                                LOGIC_SELECT_1 => LOGIC_SELECT_1,
                                RESULT => RESULT(14)); 
                                
    logic_bit_15: logic_1bit PORT MAP (
                                A => A(15),
                                B => B(15),
                                LOGIC_SELECT_0 => LOGIC_SELECT_0,
                                LOGIC_SELECT_1 => LOGIC_SELECT_1,
                                RESULT => RESULT(15)); 
end Behavioral;
