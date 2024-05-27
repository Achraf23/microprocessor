----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/24/2024 11:24:05 AM
-- Design Name: 
-- Module Name: alea_file - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity alea_file is
 Port (li_di_a : in STD_LOGIC_VECTOR (7 downto 0);
       li_di_b : in STD_LOGIC_VECTOR (7 downto 0);
       li_di_c : in STD_LOGIC_VECTOR (7 downto 0);
       di_ex_a : in STD_LOGIC_VECTOR (7 downto 0);
       ex_mem_a : in STD_LOGIC_VECTOR (7 downto 0);
       mem_re_a : in STD_LOGIC_VECTOR (7 downto 0);
       li_di_op : in STD_LOGIC_VECTOR (7 downto 0);
       di_ex_op : in STD_LOGIC_VECTOR (7 downto 0);
       ex_mem_op : in STD_LOGIC_VECTOR (7 downto 0);
       mem_re_op : in STD_LOGIC_VECTOR (7 downto 0);
       alea_out : out std_logic);

end alea_file;


architecture Behavioral of alea_file is

begin
     alea_out <= '1' when 
     
     --- alea afc then cop
    (di_ex_a = li_di_b and (li_di_op=x"05" and di_ex_op=x"06")) or 
    (ex_mem_a = li_di_b and (li_di_op=x"05" and ex_mem_op=x"06")) or
    (mem_re_a = li_di_b and (li_di_op=x"05" and mem_re_op=x"06")) or
    
    --- alea afc then add / sub / mul
    ((di_ex_a = li_di_b or di_ex_a = li_di_c) and ((li_di_op=x"01" or li_di_op=x"02" or li_di_op=x"03") and di_ex_op=x"06")) or 
    ((ex_mem_a = li_di_b or ex_mem_a = li_di_c) and ((li_di_op=x"01" or li_di_op=x"02" or li_di_op=x"03") and ex_mem_op=x"06")) or
    ((mem_re_a = li_di_b or mem_re_a = li_di_c) and ((li_di_op=x"01" or li_di_op=x"02" or li_di_op=x"03") and mem_re_op=x"06")) or
    
    --- alea cop then add / sub / mul
    ((di_ex_a = li_di_b or di_ex_a = li_di_c) and ((li_di_op=x"01" or li_di_op=x"02" or li_di_op=x"03") and di_ex_op=x"05")) or 
    ((di_ex_a = li_di_b or di_ex_a = li_di_c) and ((li_di_op=x"01" or li_di_op=x"02" or li_di_op=x"03") and ex_mem_op=x"05")) or 
    ((di_ex_a = li_di_b or di_ex_a = li_di_c) and ((li_di_op=x"01" or li_di_op=x"02" or li_di_op=x"03") and mem_re_op=x"05")) or
    
    --- alea add / sub / mul then cop
    ((di_ex_a = li_di_b or di_ex_a = li_di_c) and (li_di_op=x"05" and (di_ex_op=x"01" or di_ex_op=x"02" or di_ex_op=x"03" ))) or 
    ((di_ex_a = li_di_b or di_ex_a = li_di_c) and (li_di_op=x"05" and (ex_mem_op=x"01" or ex_mem_op=x"02" or ex_mem_op=x"03" ))) or 
    ((di_ex_a = li_di_b or di_ex_a = li_di_c) and (li_di_op=x"05" and (mem_re_op=x"01" or mem_re_op=x"02" or mem_re_op=x"03" ))) or
    
    --- alea afc then store
    (di_ex_a = li_di_b and (li_di_op=x"08" and di_ex_op=x"06")) or 
    (ex_mem_a = li_di_b and (li_di_op=x"08" and ex_mem_op=x"06")) or
    (mem_re_a = li_di_b and (li_di_op=x"08" and mem_re_op=x"06")) or
    
    --- alea load then cop
    (di_ex_a = li_di_b and (li_di_op=x"05" and di_ex_op=x"07")) or 
    (ex_mem_a = li_di_b and (li_di_op=x"05" and ex_mem_op=x"07")) or
    (mem_re_a = li_di_b and (li_di_op=x"05" and mem_re_op=x"07")) or
    
    --- alea load then add/sub/mul
    (di_ex_a = li_di_b and ((li_di_op=x"01" or li_di_op=x"02" or li_di_op=x"03") and di_ex_op=x"07")) or 
    (ex_mem_a = li_di_b and ((li_di_op=x"01" or li_di_op=x"02" or li_di_op=x"03") and ex_mem_op=x"07")) or
    (mem_re_a = li_di_b and ((li_di_op=x"01" or li_di_op=x"02" or li_di_op=x"03") and mem_re_op=x"07")) or
    
    ---alea load then store
    (di_ex_a = li_di_b and (li_di_op=x"08" and di_ex_op=x"07")) or 
    (ex_mem_a = li_di_b and (li_di_op=x"08" and ex_mem_op=x"07")) or
    (mem_re_a = li_di_b and (li_di_op=x"08" and mem_re_op=x"07"))
   
    
    else '0'; 
    
end Behavioral;
