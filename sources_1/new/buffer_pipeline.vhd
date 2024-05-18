----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/07/2024 08:55:27 AM
-- Design Name: 
-- Module Name: buffer_pipeline - Behavioral
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

entity buffer_pipeline is
    Port ( A : inout STD_LOGIC_VECTOR (7 downto 0);
           B : inout STD_LOGIC_VECTOR (7 downto 0);
           C : inout STD_LOGIC_VECTOR (7 downto 0);
           Op : inout STD_LOGIC_VECTOR (7 downto 0));
end buffer_pipeline;

architecture Behavioral of buffer_pipeline is

begin
    

end Behavioral;
