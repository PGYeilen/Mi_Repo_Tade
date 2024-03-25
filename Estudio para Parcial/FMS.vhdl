library ieee ;
    use ieee.std_logic_1164.all ;
    use ieee.numeric_std.all ;

entity  Maquina_estado is
  port (
    i_clk: IN STD_LOGIC;
    i_rst: IN STD_LOGIC;
    i_L: IN STD_LOGIC;
    o_P: OUT STD_LOGIC
  ) ;
end  Maquina_estado ; 

architecture ArchMaquina of  Maquina_estado is
signal d_bus,q_bus: state_type := inicio;
type state_type is( inicio,s1,s0,sp);
begin
    
    clk_init : process( i_clk, i_rst )
    begin
      if( i_rst = '1' ) then
        q_bus <= inicio;
      elsif( rising_edge(i_clk) ) then
        q_bus <= d_bus;
      end if ;
    end process; -- clk_init

    ---next state-----
   next_state : process( q_bus,i_L)
   case( q_bus ) is
   
       when inicio =>
           if i_L = '1' then 
           q_bus <= s1;
           else 
           q_bus <= s0;
           end if;
           when s1 =>
           if i_L = '1' then 
           q_bus <= s1;
           else 
           q_bus <= s0;
           end if; 
           when s0 =>
           if i_L = '1' then 
           q_bus <= sp;
           else 
           q_bus <= s0;
           end if; 
           when sp =>
           if i_L = '1' then 
           q_bus <= s1;
           else 
           q_bus <= s0;
           end if; 
   
       when others =>
         q_bus<= inicio;
   end case ;
   begin
       
   end process ; -- next_state

   ------present state------
    o_p <= '1' when q_bus = sp else
        '0'; 
        
   

end ArchMaquina;