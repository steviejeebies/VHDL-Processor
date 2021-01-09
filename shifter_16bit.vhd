library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity shifter_16bit is
  Port (B : in std_logic_vector (15 downto 0);
        SHIFT_SELECT_0 : in std_logic;
        SHIFT_SELECT_1 : in std_logic;
        RESULT : out std_logic_vector (15 downto 0);
        C_OUT : out std_logic
        );

end shifter_16bit;

architecture Behavioral of shifter_16bit is
-- NOTE: if shift_select = "11", this is an invalid input

component mux4_1bit is
	Port (IN_0, IN_1, in2, in3 : in std_logic;
		  S0, S1 : in std_logic;
		  Z : out std_logic);
	end component;
	
signal ir : std_logic := '0';
signal il : std_logic := '0';
signal extra : std_logic := '0';

begin
    -- total propagation time : 3 ns (for each multiplexer, as they are concurrent)
    
    -- C_OUT <= B(0) OR B(15);
    
    shift_bit_00: mux4_1bit PORT MAP (
        IN_0 => B(0),
        IN_1 => B(1),
        in2 => il,
        in3 => extra,
        S0 => SHIFT_SELECT_0,
        S1 => SHIFT_SELECT_1,
        Z => RESULT(0)
    );
    
    shift_bit_01: mux4_1bit PORT MAP (
        IN_0 => B(1),
        IN_1 => B(2),
        in2 => B(0),
        in3 => extra,
        S0 => SHIFT_SELECT_0,
        S1 => SHIFT_SELECT_1,
        Z => RESULT(1)
    );
    
    shift_bit_02: mux4_1bit PORT MAP (
        IN_0 => B(2),
        IN_1 => B(3),
        in2 => B(1),
        in3 => extra,
        S0 => SHIFT_SELECT_0,
        S1 => SHIFT_SELECT_1,
        Z => RESULT(2)
    );
    
    shift_bit_03: mux4_1bit PORT MAP (
        IN_0 => B(3),
        IN_1 => B(4),
        in2 => B(2),
        in3 => extra,
        S0 => SHIFT_SELECT_0,
        S1 => SHIFT_SELECT_1,
        Z => RESULT(3)
    );
  
    shift_bit_04: mux4_1bit PORT MAP (
        IN_0 => B(4),
        IN_1 => B(5),
        in2 => B(3),
        in3 => extra,
        S0 => SHIFT_SELECT_0,
        S1 => SHIFT_SELECT_1,
        Z => RESULT(4)
    );
    
    shift_bit_05: mux4_1bit PORT MAP (
        IN_0 => B(5),
        IN_1 => B(6),
        in2 => B(4),
        in3 => extra,
        S0 => SHIFT_SELECT_0,
        S1 => SHIFT_SELECT_1,
        Z => RESULT(5)
    );
    
    shift_bit_06: mux4_1bit PORT MAP (
        IN_0 => B(6),
        IN_1 => B(7),
        in2 => B(5),
        in3 => extra,
        S0 => SHIFT_SELECT_0,
        S1 => SHIFT_SELECT_1,
        Z => RESULT(6)
    );
    
    shift_bit_07: mux4_1bit PORT MAP (
        IN_0 => B(7),
        IN_1 => B(8),
        in2 => B(6),
        in3 => extra,
        S0 => SHIFT_SELECT_0,
        S1 => SHIFT_SELECT_1,
        Z => RESULT(7)
    );
    
    shift_bit_08: mux4_1bit PORT MAP (
        IN_0 => B(8),
        IN_1 => B(9),
        in2 => B(7),
        in3 => extra,
        S0 => SHIFT_SELECT_0,
        S1 => SHIFT_SELECT_1,
        Z => RESULT(8)
    );
    
    shift_bit_09: mux4_1bit PORT MAP (
        IN_0 => B(9),
        IN_1 => B(10),
        in2 => B(8),
        in3 => extra,
        S0 => SHIFT_SELECT_0,
        S1 => SHIFT_SELECT_1,
        Z => RESULT(9)
    );
    
    shift_bit_10: mux4_1bit PORT MAP (
        IN_0 => B(10),
        IN_1 => B(11),
        in2 => B(9),
        in3 => extra,
        S0 => SHIFT_SELECT_0,
        S1 => SHIFT_SELECT_1,
        Z => RESULT(10)
    );
    
    shift_bit_11: mux4_1bit PORT MAP (
        IN_0 => B(11),
        IN_1 => B(12),
        in2 => B(10),
        in3 => extra,
        S0 => SHIFT_SELECT_0,
        S1 => SHIFT_SELECT_1,
        Z => RESULT(11)
    );
    
    shift_bit_12: mux4_1bit PORT MAP (
        IN_0 => B(12),
        IN_1 => B(13),
        in2 => B(11),
        in3 => extra,
        S0 => SHIFT_SELECT_0,
        S1 => SHIFT_SELECT_1,
        Z => RESULT(12)
    );
    
    shift_bit_13: mux4_1bit PORT MAP (
        IN_0 => B(13),
        IN_1 => B(14),
        in2 => B(12),
        in3 => extra,
        S0 => SHIFT_SELECT_0,
        S1 => SHIFT_SELECT_1,
        Z => RESULT(13)
    );
    
    shift_bit_14: mux4_1bit PORT MAP (
        IN_0 => B(14),
        IN_1 => B(15),
        in2 => B(13),
        in3 => extra,
        S0 => SHIFT_SELECT_0,
        S1 => SHIFT_SELECT_1,
        Z => RESULT(14)
    );
    
    shift_bit_15: mux4_1bit PORT MAP (
        IN_0 => B(15),
        IN_1 => ir,
        in2 => B(14),
        in3 => extra,
        S0 => SHIFT_SELECT_0,
        S1 => SHIFT_SELECT_1,
        Z => RESULT(15)
    );

end Behavioral;
