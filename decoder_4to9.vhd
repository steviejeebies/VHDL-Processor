--------------------------------------------------------------------------------
-- Company: Trinity College
-- Engineer: Stephen Rowe (Student ID 14319662)
--
-- 4-to-9 Decoder (If A3 set, ouput QA, else normal decoder)
--------------------------------------------------------------------------------

-- This decoder is specifically for the Destination Register of the Register File. 
-- If A3 is set, then we must return the Address Register bit as set.
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity decoder_4to9 is
	Port (A0 : in std_logic;
		  A1 : in std_logic;
		  A2 : in std_logic;
		  A3 : in std_logic;
		  Q0 : out std_logic;
		  Q1 : out std_logic;
		  Q2 : out std_logic;
		  Q3 : out std_logic;
		  Q4 : out std_logic;
		  Q5 : out std_logic;
		  Q6 : out std_logic;
		  Q7 : out std_logic;
		  QA : out std_logic);
	end decoder_4to9;
	
architecture Behavioural of decoder_4to9 is
	begin
		Q0 <= ((not A3) and (not A2) and (not A1) and (not A0)) after 1 ns;
		Q1 <= ((not A3) and (not A2) and (not A1) and A0) after 1 ns;
		Q2 <= ((not A3) and (not A2) and A1 and (not A0)) after 1 ns;
		Q3 <= ((not A3) and (not A2) and A1 and A0) after 1 ns;
		Q4 <= ((not A3) and A2 and (not A1) and (not A0)) after 1 ns;
		Q5 <= ((not A3) and A2 and (not A1) and A0) after 1 ns;
		Q6 <= ((not A3) and A2 and A1 and (not A0)) after 1 ns;
		Q7 <= ((not A3) and A2 and A1 and A0) after 1 ns;
		QA <= A3 after 1 ns;
	end Behavioural;
	