library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity UnionFSMRAM is
PORT(
din: in std_logic_vector (31 downto 0);
addr: in std_logic_vector (7 downto 0);
clk: in std_logic;
rst: in std_logic;
en: in std_logic;
stp: in std_logic;
lab_btn: in std_logic;
dout: out std_logic_vector (31 downto 0)
);
end UnionFSMRAM;

architecture ArchUnion of UnionFSMRAM is
component Ram_M
	generic(
 ADDR_WIDTH : integer := 8;
 DATA_WIDTH : integer := 32 
);
	port (
clk,rst: in std_logic;
en,wr,rd: IN STD_LOGIC;
din: in std_logic_vector (data_width-1 downto 0);
addr: in std_logic_vector (addr_width-1 downto 0);
dout: out std_logic_vector (data_width-1 downto 0)
); 
	end component;
	component FMS_RAM
	port(
 clk: in std_logic;
 rst: in std_logic;
 stp: in std_logic;
 en: in std_logic; 
 lab_btn: in std_logic;
 salida: out std_logic_vector (2 downto 0)
);
	end component;

signal intermedio: std_logic_vector (2 downto 0):="000";
begin
FMS_C: FMS_RAM
 port map(
clk=> clk,
rst=> rst,
stp=> stp,
en => en,
lab_btn=> lab_btn,
salida=> intermedio
);
RAM_C: RAM_M
generic map( 
ADDR_WIDTH => 8,
 DATA_WIDTH => 32
)
port map(
clk=>clk,
rst=>rst,
en=> intermedio(2),
wr=> intermedio(1),
rd=> intermedio(0),
din=> din,
addr=> addr,
dout=> dout 
);



end ArchUnion;

