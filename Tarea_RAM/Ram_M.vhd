library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_unsigned.all;

entity Ram_M is
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
end Ram_M;

architecture ArchRam of Ram_M is
type tipo_ram is array ( 2**addr_width-1 downto 0) of std_logic_vector (DATA_WIDTH-1 downto 0);
signal signal_ram: tipo_ram;
begin
process (clk,rst)
begin
if (rst='1') then
	dout<= (others=>'0');
   elsif (clk'event and clk = '1') then
      if ( en='1' and wr= '1' and rd ='0') then
            signal_ram(conv_integer(addr)) <= din ;
         elsif( en= '1' and wr='0' and rd='1') then
           dout <= signal_ram(conv_integer(addr));
			  else
			  dout <=(others=> '0');
         end if;
   end if;
end process;

end ArchRam;

