----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/30/2024 11:50:25 AM
-- Design Name: 
-- Module Name: test_memoire_donnees - Behavioral
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

entity test_memoire_donnees is
--  Port ( );
end test_memoire_donnees;

architecture Behavioral of test_memoire_donnees is

component memoire_donnees is 
    PORT(
       input : in STD_LOGIC_VECTOR (7 downto 0);
       addr : in STD_LOGIC_VECTOR (7 downto 0);
       RW : in STD_LOGIC;
       RST : in STD_LOGIC;
       CLK : in STD_LOGIC;
       output : out STD_LOGIC_VECTOR (7 downto 0));
 END component;
 
 signal sim_in, sim_addr, sim_out : STD_LOGIC_VECTOR (7 downto 0);
 signal sim_RST,sim_RW : std_logic; 
 signal sim_CLK : std_logic := '0';

begin
    test_memoire_donnees : memoire_donnees PORT MAP (
    input => sim_in,
    addr => sim_addr,
    RW => sim_RW,
    RST => sim_RST,
    CLK => sim_CLK,
    output => sim_out 
    );
    
    
    sim_CLK <= not sim_CLK after 10 ns;
    sim_RST <= '0', '1' after 10 ns;
    sim_RW <='1', '0' after 20ns, '1' after 80 ns;
    sim_addr <= X"00",  x"01" after 40 ns, x"02" after 60 ns, x"03" after 100 ns, x"01" after 140 ns;
    sim_in <= x"01", x"0A" after 40 ns, x"04" after 60 ns, x"0f" after 80 ns;

end Behavioral;
