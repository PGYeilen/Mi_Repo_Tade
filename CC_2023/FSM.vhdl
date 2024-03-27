library ieee ;
    use ieee.std_logic_1164.all ;
    use ieee.numeric_std.all ;

entity FSM is
  port (
    clk: in std_logic;
    rst: in std_logic;
    din: in std_logic_vector(3 downto 0);
    enblink: in std_logic;
    dout: out std_logic_vector(7 downto 0)
  ) ;
end FSM ; 

architecture ArchFSM of FSM is
type state_type is (inicio,multiplicar,alternar);
signal d_bus,q_bus: state_type;
signal cambio_alternador: std_logic;
signal modo: std_logic;
begin
----clk init----
process( clk, rst )
begin
  if( rst = '1' ) then
    q_bus <=inicio;
 elsif( rising_edge(clk) ) then
    q_bus<=d_bus;
	 cambio_alternador <= not( cambio_alternador);
 end if ;
end process;

----- enblink-----
process(enblink)
begin
if (rising_edge(enblink)) then
modo<= not(modo);
end if;
end process;

----next state----
 process (enblink, q_bus)
begin
    case( q_bus ) is
	 when inicio =>
			D_bus <= multiplicar;
	      when alternar =>
        if modo ='0' then
            d_bus <= multiplicar;
         else
            d_bus <= alternar;
            end if;
            when multiplicar =>
           if modo='1' then
                d_bus <= alternar;
             else
                d_bus<= multiplicar;
                end if;
    end case ;
    end process;
---- present state---
dout(3 downto 0) <= (others=> '0') when q_bus = inicio or( q_bus =alternar and cambio_alternador ='0')else
							din;
dout(7 downto 4) <= (others=> '0') when q_bus = inicio or( q_bus =alternar and cambio_alternador ='1')else
							din;				     
end ArchFSM ;