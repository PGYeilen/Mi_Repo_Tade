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
begin
----clk init----
process( clk, rst )
begin
  if( rst = '1' ) then
    q_bus <=inicio;
 elsif( rising_edge(clk) ) then
    q_bus<=d_bus;
	 cambio_alternador <= not (cambio_alternador);
 end if ;
end process;

----next state----
process (enblink, q_bus)
begin
    case( q_bus ) is
             when alternar=>
        if rising_edge(enBlink) then
            d_bus <= multiplicar;
         else
            d_bus<= alternar;
            end if;
            when multiplicar=>
           if rising_edge(enBlink) then
                d_bus <= alternar;
             else
                d_bus<= multiplicar;
                end if;
				when others=>
				d_bus<= d_bus;
    end case ;
    end process;
---- present state---
process (din, q_bus)
begin
    if q_bus = inicio then
	 dout<="00000000";
	 elsif q_bus = multiplicar then
        dout(3)<= din(3);
        dout(2)<= din(2);
        dout(1)<= din(1);
        dout(0)<= din(0);
        dout(7)<= din(3);
        dout(6)<= din(2);
        dout(5)<= din(1);
        dout(4)<= din(0);
	else
	if cambio_alternador= '0' then
	 dout <= "00000000";
	   else
     dout(3)<= din(3);
     dout(2)<= din(2);
     dout(1)<= din(1);
     dout(0)<= din(0);
     dout(7)<= din(3);
     dout(6)<= din(2);
     dout(5)<= din(1);
     dout(4)<= din(0);	 	  
	  end if;
	  end if;
        end process;
end ArchFSM ;