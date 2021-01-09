library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ripple_carry_16bit is
  Port (A : in std_logic_vector (15 downto 0);
        B : in std_logic_vector (15 downto 0);
        C_IN : in std_logic;
        SUM : out std_logic_vector (15 downto 0);
        C_OUT : out std_logic;
        V : out std_logic);
end ripple_carry_16bit;

architecture Behavioral of ripple_carry_16bit is
    signal C01, C02, C03, C04, C05, C06, C07, C08, C09, C10, C11, C12, C13, C14, C15, C16 : std_logic;
    signal sum_res : std_logic_vector(15 downto 0);
    
    
    component full_adder is
        Port (A : in std_logic;
              B : in std_logic;
              C_IN : in std_logic;
              SUM : out std_logic;
              C_OUT : out std_logic);
    end component;
    
begin
    C_OUT <= C16;                  -- C = C(N)
    V <= C16 XOR C15 after 1 ns;   -- V = C(N) XOR C(N-1)   CURRENTLY WRONG
    SUM <= sum_res after 1 ns;
    
    sum00 : full_adder PORT MAP(
        A => A(0),
        B => B(0),
        C_IN => C_IN,
        SUM => sum_res(0),
        C_OUT => C01
    );
    
    sum01 : full_adder PORT MAP(
        A => A(1),
        B => B(1),
        C_IN => C01,
        SUM => sum_res(1),
        C_OUT => C02
    );
    
    sum02 : full_adder PORT MAP(
        A => A(2),
        B => B(2),
        C_IN => C02,
        SUM => sum_res(2),
        C_OUT => C03
    );
    
    sum03 : full_adder PORT MAP(
        A => A(3),
        B => B(3),
        C_IN => C03,
        SUM => sum_res(3),
        C_OUT => C04
    );
    
    sum04 : full_adder PORT MAP(
        A => A(4),
        B => B(4),
        C_IN => C04,
        SUM => sum_res(4),
        C_OUT => C05
    );
    
    sum05 : full_adder PORT MAP(
        A => A(5),
        B => B(5),
        C_IN => C05,
        SUM => sum_res(5),
        C_OUT => C06
    );
    
    sum06 : full_adder PORT MAP(
        A => A(6),
        B => B(6),
        C_IN => C06,
        SUM => sum_res(6),
        C_OUT => C07
    );
    
    sum07 : full_adder PORT MAP(
        A => A(7),
        B => B(7),
        C_IN => C07,
        SUM => sum_res(7),
        C_OUT => C08
    );
    
    sum08 : full_adder PORT MAP(
        A => A(8),
        B => B(8),
        C_IN => C08,
        SUM => sum_res(8),
        C_OUT => C09
    );
    
    sum09 : full_adder PORT MAP(
        A => A(9),
        B => B(9),
        C_IN => C09,
        SUM => sum_res(9),
        C_OUT => C10
    );
    
    sum10 : full_adder PORT MAP(
        A => A(10),
        B => B(10),
        C_IN => C10,
        SUM => sum_res(10),
        C_OUT => C11
    );
    
    sum11 : full_adder PORT MAP(
        A => A(11),
        B => B(11),
        C_IN => C11,
        SUM => sum_res(11),
        C_OUT => C12
    );
    
    sum12 : full_adder PORT MAP(
        A => A(12),
        B => B(12),
        C_IN => C12,
        SUM => sum_res(12),
        C_OUT => C13
    );
    
    sum13 : full_adder PORT MAP(
        A => A(13),
        B => B(13),
        C_IN => C13,
        SUM => sum_res(13),
        C_OUT => C14
    );
    
    sum14 : full_adder PORT MAP(
        A => A(14),
        B => B(14),
        C_IN => C14,
        SUM => sum_res(14),
        C_OUT => C15
    );
    
    sum15 : full_adder PORT MAP(
        A => A(15),
        B => B(15),
        C_IN => C15,
        SUM => sum_res(15),
        C_OUT => C16
    );

end Behavioral;
