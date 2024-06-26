----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/21/2024 11:51:12 AM
-- Design Name: 
-- Module Name: banc_registre - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity microprocesseur is
    Port ( RST : in STD_LOGIC;
           CLK : in STD_LOGIC;
           QA : out STD_LOGIC_VECTOR (7 downto 0);
           QB : out STD_LOGIC_VECTOR (7 downto 0));
end microprocesseur;

architecture Behavioral of microprocesseur is

COMPONENT td_alu is
    Port ( A : in STD_LOGIC_VECTOR (7 downto 0);
           B : in STD_LOGIC_VECTOR (7 downto 0);
           S : out STD_LOGIC_VECTOR (7 downto 0);
           Operation : in STD_LOGIC_VECTOR (2 downto 0);
           C : out STD_LOGIC;
           O : out STD_LOGIC;
           N : out STD_LOGIC);
end COMPONENT;

COMPONENT compteur_8bits is
    Port ( CLK_cpt : in STD_LOGIC;
           RST : in STD_LOGIC;
           LOAD : in STD_LOGIC;
           SENS : in STD_LOGIC;
           EN : in STD_LOGIC;
           Din : in STD_LOGIC_VECTOR (7 downto 0);
           Dout : out STD_LOGIC_VECTOR (7 downto 0));
    end COMPONENT;

COMPONENT banc_registre is
    Port ( A : in STD_LOGIC_VECTOR (3 downto 0);
           B : in STD_LOGIC_VECTOR (3 downto 0);
           addrW : in STD_LOGIC_VECTOR (3 downto 0);
           DATA : in STD_LOGIC_VECTOR (7 downto 0);
           RST_br : in STD_LOGIC;
           CLK_br : in STD_LOGIC;
           QA : out STD_LOGIC_VECTOR (7 downto 0);
           QB : out STD_LOGIC_VECTOR (7 downto 0);
           W : in STD_LOGIC);
   END component;

component memoire_donnees is 
    PORT(
       input : in STD_LOGIC_VECTOR (7 downto 0);
       addr : in STD_LOGIC_VECTOR (7 downto 0);
       RW : in STD_LOGIC;
       RST_mem : in STD_LOGIC;
       CLK_mem : in STD_LOGIC;
       output : out STD_LOGIC_VECTOR (7 downto 0));
 END component;


component memoire_instructions is
    Port (addr : in STD_LOGIC_VECTOR (7 downto 0);
           CLK_ins : in STD_LOGIC;
           output : out STD_LOGIC_VECTOR (31 downto 0));
end component;

component buffer_pipeline is
    Port (A : inout STD_LOGIC_VECTOR (7 downto 0);
          B : inout STD_LOGIC_VECTOR (7 downto 0);
          C : inout STD_LOGIC_VECTOR (7 downto 0);
          Op: inout STD_LOGIC_VECTOR (7 downto 0));
end component;


component alea_file is
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

end component;

signal sim_cpt_load :std_logic := '0';
signal sim_RST, sim_br_W, sim_cpt_sens, sim_cpt_en: std_logic; 
signal sim_br_A, sim_br_B, sim_addrW : STD_LOGIC_VECTOR (3 downto 0);
signal sim_br_data, sim_mi_addr, sim_cpt_din, sim_cpt_dout , sim_alu_s, sim_mem_out : STD_LOGIC_VECTOR (7 downto 0);
signal OP_LI_DI, A_LI_DI, B_LI_DI, C_LI_DI: STD_LOGIC_VECTOR (7 downto 0);
signal OP_DI_EX, A_DI_EX, B_DI_EX, C_DI_EX: STD_LOGIC_VECTOR (7 downto 0);              
signal OP_EX_MEM, A_EX_MEM, B_EX_MEM, C_EX_MEM: STD_LOGIC_VECTOR (7 downto 0);
signal OP_MEM_RE, A_MEM_RE, B_MEM_RE, C_MEM_RE: STD_LOGIC_VECTOR (7 downto 0);
signal sim_br_QA, sim_br_QB, sim_alu_A, sim_alu_B: STD_LOGIC_VECTOR (7 downto 0);
signal sim_mi_output : STD_LOGIC_VECTOR (31 downto 0);
signal sim_alu_op : STD_LOGIC_VECTOR (2 downto 0);
signal sim_rw : std_logic;
signal sim_addr_mem: STD_LOGIC_VECTOR (7 downto 0);
   
-- ALEA --
signal alea : std_logic;
signal test : std_logic :='0';
begin
  
    ip : compteur_8bits PORT MAP (
    CLK_cpt => CLK,
    RST => sim_RST,
    LOAD => sim_cpt_load,
    SENS => sim_cpt_sens,
    EN => sim_cpt_en,
    Din =>sim_cpt_din,
    Dout => sim_cpt_dout
    );

    my_mi : memoire_instructions PORT MAP (
    addr => sim_cpt_dout,
    CLK_ins => CLK,
    output => sim_mi_output
    );


    my_br : banc_registre PORT MAP ( 
    A => B_LI_DI (3 downto 0),
    B => C_LI_DI (3 downto 0),
    addrW => sim_addrW, 
    CLK_br => CLK,
    RST_br => sim_RST,
    DATA => sim_br_data,
    QA => sim_br_QA,
    QB => sim_br_QB,
    W => sim_br_W
    );
    
    my_alu: td_alu PORT MAP(
    A => B_DI_EX,
    B => C_DI_EX,
    S => sim_alu_s,
    Operation => OP_DI_EX(2 downto 0),
    C => open,
    O => open,
    N => open 
    ); 
    
    mem: memoire_donnees PORT MAP(
    input => B_EX_MEM,
    addr => sim_addr_mem ,
    RW => sim_rw ,
    RST_mem => RST ,
    CLK_mem => CLK ,
    output => sim_mem_out
    );
    
    alea_ent : alea_file PORT MAP(
    li_di_a => A_LI_DI,
    li_di_b => B_LI_DI,
    li_di_c => C_LI_DI,
    di_ex_a => A_DI_EX,
    ex_mem_a => A_EX_MEM,
    mem_re_a => A_MEM_RE,
    li_di_op => OP_LI_DI,
    di_ex_op => OP_DI_EX, 
    ex_mem_op => OP_EX_MEM, 
    mem_re_op => OP_MEM_RE, 
    alea_out => alea
    );
    
    sim_cpt_load <= '1' when OP_LI_DI=x"09" or (OP_DI_EX=x"0a" and B_DI_EX=x"00") else '0';
    sim_cpt_en <= '1' when alea='0' else '0';
    sim_cpt_sens <= '1';
    sim_RST <= RST;
    
    --- 1er etage
    sim_mi_addr <= sim_cpt_dout when alea = '0';
    C_LI_DI <=  sim_mi_output (7 downto 0) when alea = '0';
    B_LI_DI <=  sim_mi_output (15 downto 8) when alea = '0';
    A_LI_DI <=  sim_mi_output (23 downto 16) when alea = '0';
    OP_LI_DI <=  sim_mi_output (31 downto 24) when alea = '0';
    
    --- handle jmp and jmf
    sim_cpt_din <= A_LI_DI when OP_LI_DI=x"09" else
                    A_DI_EX when OP_DI_EX=x"0a" and B_DI_EX=x"00";
    
    -- 2eme niveau de pipeline
    process(CLK) begin
        if CLK ='1' then
            --sim_cpt_load <= '0';
            if alea = '0' then
            -- Pour COP, ADD, SOUS, MUL et STORE on link notre 2eme buffer de pipeline aux sorties du banc de registre
                if OP_LI_DI = x"05" or OP_LI_DI = x"01" or OP_LI_DI = x"02" or OP_LI_DI = x"03" or OP_LI_DI = x"08" or OP_LI_DI=x"0a" then                
                    A_DI_EX <= A_LI_DI;
                    OP_DI_EX <= OP_LI_DI;
                    B_DI_EX <= sim_br_QA;
                    C_DI_EX <= sim_br_QB;             
                else
                    A_DI_EX <= A_LI_DI;
                    OP_DI_EX <= OP_LI_DI;
                    B_DI_EX <= B_LI_DI;
                end if;    
             else
                A_DI_EX <= x"00";
                OP_DI_EX <= x"00";
                B_DI_EX <= x"00";
                C_DI_EX <= x"00";
             end if;
        end if;
    end process;
    
    -- 3eme niveau de pipeline
    
    process (CLK) begin
        if CLK ='1' then
            if OP_DI_EX = x"01" or OP_DI_EX = x"02" or OP_DI_EX = x"03" then
                A_EX_MEM <= A_DI_EX;
                OP_EX_MEM <= OP_DI_EX; 
                B_EX_MEM <= sim_alu_s;
             else 
                A_EX_MEM<=A_DI_EX;
                OP_EX_MEM <= OP_DI_EX; 
                B_EX_MEM<=B_DI_EX;
             end if;                
        end if;    
    end process;
    
    -- 4eme niveau de pipeline
    sim_rw <= '0' when OP_EX_MEM=x"08" else '1';
    sim_addr_mem <= B_EX_MEM when OP_EX_MEM=x"07" else A_EX_MEM; 
    process (CLK) begin
        if CLK ='1' then
            if OP_EX_MEM = x"01" or OP_EX_MEM = x"02" or OP_EX_MEM = x"03" then
                A_MEM_RE<=A_EX_MEM;
                OP_MEM_RE<=OP_EX_MEM;
                B_MEM_RE <= B_EX_MEM;
            elsif OP_EX_MEM = x"07" then
                A_MEM_RE<=A_EX_MEM;
                OP_MEM_RE<=OP_EX_MEM;
                B_MEM_RE <= sim_mem_out;
             else 
                A_MEM_RE<=A_EX_MEM;
                OP_MEM_RE<=OP_EX_MEM;
                B_MEM_RE<=B_EX_MEM;
            end if;
        end if;    
    end process;    
                
    --5eme niveau de pipeline
    process (CLK) begin 
        if CLK ='1' then

            sim_addrW<=A_MEM_RE (3 downto 0);
            if OP_MEM_RE = x"06" or OP_MEM_RE=x"05" or OP_MEM_RE=x"01" or OP_MEM_RE=x"02" or OP_MEM_RE=x"03" or OP_MEM_RE=x"07" then
                sim_br_w <= '1';
                sim_br_data<=B_MEM_RE;
            else 
                    sim_br_w<='0';
             end if;                
        end if;       
    end process;
    

end Behavioral;
