library IEEE;
 use IEEE.STD_LOGIC_1164.ALL;
 use IEEE.STD_LOGIC_ARITH.ALL;
 
 entity memory_512x16 is    -- use unsigned for memory address
     Port (address : in unsigned (15 downto 0);
           write_data : in std_logic_vector(15 downto 0);
           MemWrite : in std_logic;
           read_data : out std_logic_vector(15 downto 0));
 end memory_512x16;
 
 architecture behavioural of memory_512x16 is 
     type mem_array is array (0 to 511) of std_logic_vector(15 downto 0);
     begin
         mem_process: process(address, write_data, MemWrite)
         variable data_mem : mem_array := ( X"0049",
                                            X"0849", 
                                            X"0648", 
                                            X"0648", 
                                            X"0097", 
                                            X"0097", 
                                            X"0097", 
                                            X"0097",
                                            X"0250", 
                                            X"0690", 
                                            X"0ACB", 
                                            X"06D8", 
                                            X"0848", 
                                            X"0ACB", 
                                            X"0413", 
                                            X"0120",
                                            X"0C04",
                                            X"0000",
                                            X"0000",
                                            X"0000",
                                            X"0000",
                                            X"0FC2",
                                            others => X"0000");
         variable addr : integer;
             
         begin 
             addr := conv_integer(address(8 downto 0));
             read_data <= data_mem(addr);
             if MemWrite = '1' then data_mem(addr) := write_data;
             end if;
         end process;
     end behavioural;