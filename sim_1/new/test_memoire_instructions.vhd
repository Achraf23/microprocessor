library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity test_memoire_instructions is
--  Port ( );
end test_memoire_instructions;

architecture Behavioral of test_memoire_instructions is

component memoire_instructions is
    Port (addr : in STD_LOGIC_VECTOR (7 downto 0);
           CLK_ins : in STD_LOGIC;
           output : out STD_LOGIC_VECTOR (31 downto 0));
end component;

signal sim_addr : STD_LOGIC_VECTOR (7 downto 0);
signal sim_out : STD_LOGIC_VECTOR (31 downto 0);
signal sim_CLK : std_logic := '0';


begin
    test_memoire_instructions : memoire_instructions PORT MAP (
    addr => sim_addr,
    CLK_ins => sim_CLK,
    output => sim_out 
    );


sim_CLK <= not sim_CLK after 10 ns;
 sim_addr <= X"00",  x"01" after 40 ns, x"02" after 60 ns, x"03" after 100 ns, x"01" after 140 ns;




end Behavioral;