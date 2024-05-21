----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/30/2024 11:29:44 AM
-- Design Name: 
-- Module Name: memoire_donnees - Behavioral
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

entity memoire_donnees is
    Port ( input : in STD_LOGIC_VECTOR (7 downto 0);
           addr : in STD_LOGIC_VECTOR (7 downto 0);
           RW : in STD_LOGIC;
           RST_mem : in STD_LOGIC;
           CLK_mem : in STD_LOGIC;
           output : out STD_LOGIC_VECTOR (7 downto 0));
end memoire_donnees;

architecture Behavioral of memoire_donnees is
type ttab is array(0 to 255) of std_logic_vector(7 downto 0);
signal mem: ttab;

    signal index : INTEGER := 1;
begin
    
    process(CLK_mem) 
            variable str : string(1 to 8); -- Variable to hold string representation
    begin
         -- Convert the array element to a string
        
        if CLK_mem ='0' then
            if RST_mem ='0' then
                mem <= (x"00", x"09", others => X"00");
            end if;
            if RW='1' then
                for i in 0 to 7 loop
                    if mem(index)(i) = '1' then
                        str(i + 1) := '1';
                    else
                        str(i + 1) := '0';
                    end if;
                end loop;
                --report "testTTTTTTTTTTTTTTEAWWWWWWW";
                --report "MESSAGE: " & str;
                output <= mem(to_integer(unsigned(addr)));
            else
                mem(to_integer(unsigned(addr))) <= input;                
            end if;  
         end if;          
    end process;
end Behavioral;