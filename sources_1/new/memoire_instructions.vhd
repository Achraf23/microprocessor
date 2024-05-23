----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/30/2024 11:29:44 AM
-- Design Name: 
-- Module Name: memoire_instructions - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity memoire_instructions is
    Port (addr : in STD_LOGIC_VECTOR (7 downto 0);
           CLK_ins : in STD_LOGIC;
           output : out STD_LOGIC_VECTOR (31 downto 0));
end memoire_instructions;

architecture Behavioral of memoire_instructions is
type ttab is array(0 to 255) of std_logic_vector(31 downto 0);
signal instructions: ttab;

begin
    instructions <= (x"99999999", x"06010533", x"05000100", x"00000000", x"06020100"
    ,x"07010133"
    , x"00000000", x"00000000", x"00000000", x"00000000", x"00000000",x"08020100", others => x"00000000");
--    process(CLK_ins) begin
--        if CLK_ins ='1' then
--            output <= instructions(TO_INTEGER(unsigned(addr)));
--        end if;
--    end process;
    
    
    output <= instructions(TO_INTEGER(unsigned(addr)));

    
end Behavioral;
