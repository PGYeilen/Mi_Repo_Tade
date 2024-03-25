library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity FMS_RAM is
port(
clk: in std_logic;
rst: in std_logic;
stp: in std_logic;
en: in std_logic; 
lab_btn: in std_logic;
salida: out std_logic_vector (2 downto 0)
);
end FMS_RAM;

architecture ArchFMS_Ram of FMS_RAM is
type state_type is (wr, rd, nada);
signal q_bus, d_bus: state_type;
begin
------ iniciar rst y clk---------
 process (clk,rst)
begin  
   if rst = '1' then
      q_bus<= nada;
   elsif (clk'event and clk = '1') then
        q_bus <= d_bus;
   end if;
end process;
-------next state--------
process (q_bus,stp,en,lab_btn)
   begin
     case (q_bus) is
         when nada =>
            if lab_btn = '1' and en= '1' then
             d_bus <= wr;
				 elsif lab_btn ='1' and stp='1' then
				d_bus <=rd;
					else 
					d_bus <= nada;
            end if;
         when wr =>
            if lab_btn = '1' and en= '1' then
              d_bus <= wr;
				  elsif lab_btn='1' and stp='1' then
				  d_bus<= rd;
				  else
				  d_bus<= nada;
            end if;
				 when rd =>
            if lab_btn = '1' and en= '1' then
              d_bus <= wr;
				  elsif lab_btn='1' and stp='1' then
				  d_bus<= rd;
				  else
				  d_bus<= nada;
            end if;
         when others =>
            d_bus <= nada;
      end case;      
   end process;
------present state-----
 salida <= "101" when q_bus= rd else
			  "110" when q_bus=wr else
			  "000";
end ArchFMS_Ram;

