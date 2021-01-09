library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity zero_detect is
  Port (I : in std_logic_vector(15 downto 0);
        RESULT : out std_logic);
end zero_detect;

architecture Behavioral of zero_detect is

signal not_result : std_logic;
begin
    not_result <= I(0) OR I(1) OR I(2) OR I(3) OR 
                  I(4) OR I(5) OR I(6) OR I(7) OR 
                  I(8) OR I(9) OR I(10) OR I(11) OR 
                  I(12) OR I(13) OR I(14) OR I(15) after 1 ns;
    RESULT <= NOT not_result after 1 ns;

end Behavioral;
