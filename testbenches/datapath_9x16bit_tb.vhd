library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity datapath_9x16bit_tb is
end datapath_9x16bit_tb;

architecture Behavioral of datapath_9x16bit_tb is
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

signal DATA_IN, ADDRESS_OUT, DATA_OUT, PC : std_logic_vector (15 downto 0);
signal DR, SA, SB : std_logic_vector (2 downto 0);
signal FS : std_logic_vector (4 downto 0);
signal CLK, RW, TD, TA, TB, MB, MD, MM, V, C, N, Z : std_logic := '0';

begin
    uut : datapath_9x16bit PORT MAP (
                                CLK => CLK,
                                RW => RW,
                                DR => DR,
                                SA => SA,
                                SB => SB,
                                TD => TD,
                                TA => TA,
                                TB => TB,
                                MB => MB,
                                MD => MD,
                                MM => MM,
                                FS => FS,
                                PC => PC,
                                DATA_IN => DATA_IN,
                                ADDRESS_OUT => ADDRESS_OUT,
                                DATA_OUT => DATA_OUT,
                                V => V,
                                C => C,
                                N => N,
                                Z => Z);
                                
    CLK <= NOT CLK after 50 ns;
    stim : process
    begin
        MD <= '1';
        MB <= '0';  
        MM <= '0';
        RW <= '1'; 
        PC <= (others => '0');
        -- RW to R0
        DATA_IN <= "1111100000011111"; DR <= "000"; wait for 100 ns;
        -- RW to R1
        DATA_IN <= "0001111111111000"; DR <= "001"; wait for 100 ns;
        -- RW to R2
        DATA_IN <= "0000000000000000"; DR <= "010"; wait for 100 ns;
        -- RW to R3
        DATA_IN <= "0111111111111111"; DR <= "011"; wait for 100 ns;
        MD <= '0';
        
        DR <= "010"; -- Destination Register remains R2 for the rest of the program, this is
                     -- where we are saving results
        
        -- After every micro-op, we'll RW the RESULT to R2. We'll then switch 
        -- B address to R2 so that it can output the value of R2 as the DATA_OUT value.
        SA <= "000"; SB <= "001";
        
        -- F = A                
        FS <= "00000";
            wait for 100 ns;    -- SHOW RESULTS - wait
            SB <= "010";        -- have DATA_OUT point to R2
            wait for 100 ns;    -- wait
            SB <= "001";        -- have DATA_OUT point to R1
            
        -- F = A + 1               
        FS <= "00001";
            wait for 100 ns;    -- SHOW RESULTS - wait
            SB <= "010";        -- have DATA_OUT point to R2
            wait for 100 ns;    -- wait
            SB <= "001";        -- have DATA_OUT point to R1
        -- F = A + B               
        FS <= "00010";
            wait for 100 ns;    -- SHOW RESULTS - wait
            SB <= "010";        -- have DATA_OUT point to R2
            wait for 100 ns;    -- wait
            SB <= "001";        -- have DATA_OUT point to R1
        -- F = A + B + 1            
        FS <= "00011";
            wait for 100 ns;    -- SHOW RESULTS - wait
            SB <= "010";        -- have DATA_OUT point to R2
            wait for 100 ns;    -- wait
            SB <= "001";        -- have DATA_OUT point to R1  
        -- F = A + B'         
        FS <= "00100";
            wait for 100 ns;    -- SHOW RESULTS - wait
            SB <= "010";        -- have DATA_OUT point to R2
            wait for 100 ns;    -- wait
            SB <= "001";        -- have DATA_OUT point to R1 
        -- F = A + B' + 1       
        FS <= "00101";
            wait for 100 ns;    -- SHOW RESULTS - wait
            SB <= "010";        -- have DATA_OUT point to R2
            wait for 100 ns;    -- wait
            SB <= "001";        -- have DATA_OUT point to R1 
        -- F = A - 1      
        FS <= "00110";
            wait for 100 ns;    -- SHOW RESULTS - wait
            SB <= "010";        -- have DATA_OUT point to R2
            wait for 100 ns;    -- wait
            SB <= "001";        -- have DATA_OUT point to R1  
        -- F = A
        FS <= "00111";
            wait for 100 ns;    -- SHOW RESULTS - wait
            SB <= "010";        -- have DATA_OUT point to R2
            wait for 100 ns;    -- wait
            SB <= "001";        -- have DATA_OUT point to R1
        -- F = A /\ B
        FS <= "01000";
            wait for 100 ns;    -- SHOW RESULTS - wait
            SB <= "010";        -- have DATA_OUT point to R2
            wait for 100 ns;    -- wait
            SB <= "001";        -- have DATA_OUT point to R1
        -- F = A \/ B
        FS <= "01010";
            wait for 100 ns;    -- SHOW RESULTS - wait
            SB <= "010";        -- have DATA_OUT point to R2
            wait for 100 ns;    -- wait
            SB <= "001";        -- have DATA_OUT point to R1
        -- F = A XOR B
        FS <= "01100";
            wait for 100 ns;    -- SHOW RESULTS - wait
            SB <= "010";        -- have DATA_OUT point to R2
            wait for 100 ns;    -- wait
            SB <= "001";        -- have DATA_OUT point to R1
        -- F = A'
        FS <= "01110";
            wait for 100 ns;    -- SHOW RESULTS - wait
            SB <= "010";        -- have DATA_OUT point to R2
            wait for 100 ns;    -- wait
            SB <= "001";        -- have DATA_OUT point to R1
        -- F = B
        FS <= "10000";
            wait for 100 ns;    -- SHOW RESULTS - wait
            SB <= "010";        -- have DATA_OUT point to R2
            wait for 100 ns;    -- wait
            SB <= "001";        -- have DATA_OUT point to R1
        -- F = sr B
        FS <= "10100";
            wait for 100 ns;    -- SHOW RESULTS - wait
            SB <= "010";        -- have DATA_OUT point to R2
            wait for 100 ns;    -- wait
            SB <= "001";        -- have DATA_OUT point to R1
        -- F = sl B
        FS <= "11000";
            wait for 100 ns;    -- SHOW RESULTS - wait
            SB <= "010";        -- have DATA_OUT point to R2
            wait for 100 ns;    -- wait
            SB <= "001";        -- have DATA_OUT point to R1
        
        -- test constant_in. I will do the shift B operation, but chosing neither left nor right. So, the RESULT
        -- should be indentical to the input value. 
        MB <= '1'; SB <= "111"; FS <= "10000"; -- SB is our constant value
        wait for 100 ns;
        
        -- test overflow flag
        MB <= '0';
        SA <= "011"; SB <= "011";   -- Address_out and Data_out are now both "0111111111111111"
        FS <= "00010";
            wait for 100 ns;    -- SHOW RESULTS - wait
            SB <= "010";        -- have DATA_OUT point to R2
            wait for 100 ns;    -- wait
    end process; 

end Behavioral;
