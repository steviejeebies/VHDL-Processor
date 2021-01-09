---------------------------------------------------------------------------------
-- Company: Trinity College
-- Engineer: Stephen Rowe (Student ID 14319662)
--
-- Memory 512x16-bit Testbench
--------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;

entity memory_512x16_tb is
end memory_512x16_tb;

architecture behavioural of memory_512x16_tb is 
    component memory_512x16 is
        Port (address : in unsigned (15 downto 0);
              write_data : in std_logic_vector(15 downto 0);
              MemWrite : in std_logic;
              read_data : out std_logic_vector(15 downto 0));
    end component;
    
    -- inputs 
    signal address : unsigned(15 downto 0);
    signal write_data : std_logic_vector(15 downto 0);
    signal MemWrite : std_logic;
    
    -- outputs
    signal read_data : std_logic_vector(15 downto 0);
    
    -- constants
    constant addrX: unsigned  := X"1111";
    constant addrY: unsigned  := X"8888";
    constant addrZ: unsigned  := X"FFFF";
    
    begin
        uut : memory_512x16 PORT MAP (
                                 address => address,
                                 write_data => write_data,
                                 MemWrite => MemWrite,
                                 read_data => read_data );
                                 
        stim : process
        begin
           -- test reading from memory
           address <= addrX;
           MemWrite <= '0';
           wait for 100 ns;
           
           MemWrite <= '1';
           
           -- MEM[addrX] = 0xAAAA;
           address <= addrX;
           write_data <= X"AAAA";
           wait for 100 ns;
           
           -- MEM[addrY] = 0xBBBB;
           address <= addrY;
           write_data <= X"BBBB";
           wait for 100 ns;
           
           -- MEM[addrZ] = 0xCCCC;
           address <= addrZ;
           write_data <= X"CCCC";
           wait for 100 ns;
           
           -- turn off write and clear write_data for time being
           MemWrite <= '0';
           write_data <= X"0000";
           
           -- To double check that the values are stored, we will 
           -- iterate through the addresses, and read from them  
           
           -- MEM[addrX]
           address <= addrX;
           wait for 100 ns;
           
           -- MEM[addrY]
           address <= addrY;
           wait for 100 ns;
           
           -- MEM[addrZ]
           address <= addrZ;
           wait for 100 ns;
           
           -- To make sure only 9 bits from address are being read, I'll
           -- set MemRead to 1, start by looking at address 0x000F, then 
           -- add an MSB repeatedly. It should output 0x0000 up until
           -- we get to address 0x01FF, as we are looking at different
           -- registers that are initialised at 0x0000. Once we get to
           -- 0x01FF, then we are looking at the register that we wrote
           -- 0xCCCC to. When we keep adding MSBs, then this value will
           -- not change, as we are looking at the same register the whole
           -- time, since the higher MSBs don't count in the address.
           
           address <= X"000F";
           wait for 20 ns;
           address <= X"001F";
           wait for 20 ns;
           address <= X"003F";
           wait for 20 ns;
           address <= X"007F";
           wait for 20 ns;
           address <= X"00FF";
           wait for 20 ns;
           address <= X"01FF";
           wait for 20 ns;
           address <= X"03FF";
           wait for 20 ns;
           address <= X"07FF";
           wait for 20 ns;
           address <= X"0FFF";
           wait for 20 ns;
           
           
           
        end process;
           
           
    end behavioural;