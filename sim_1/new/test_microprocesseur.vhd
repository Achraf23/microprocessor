----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/14/2024 08:28:09 AM
-- Design Name: 
-- Module Name: test_microprocesseur - Behavioral
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

entity test_microprocesseur is
--  Port ( );
end test_microprocesseur;

architecture Behavioral of test_microprocesseur is

component microprocesseur is
    Port ( RST : in STD_LOGIC;
           CLK : in STD_LOGIC;
           QA : out STD_LOGIC_VECTOR (7 downto 0);
           QB : out STD_LOGIC_VECTOR (7 downto 0));
end component;

signal sim_RST : std_logic;
signal sim_CLK : std_logic := '0';
signal sim_QA, sim_QB : STD_LOGIC_VECTOR (7 downto 0);



begin
    test_microprocesseur : microprocesseur PORT MAP(
    RST => sim_RST,
    CLK => sim_CLK,
    QA => sim_QA,
    QB => sim_QB
    );

    sim_RST <= '1', '0' after 10 ns;
    sim_CLK <= not sim_CLK after 10 ns;
    

end Behavioral;
