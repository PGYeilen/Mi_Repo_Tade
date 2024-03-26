library ieee ;
    use ieee.std_logic_1164.all ;
    use ieee.numeric_std.all ;

entity Counter is
    generic(
        g_dataSize: integer := 8  ---- para que el contador sea generico
    );
  port (   ---- caja negra con entradas y salidas
    i_clk: in std_logic;
    i_rst: in std_logic;
    i_data: in std_logic_vector (g_dataSize-1 downto 0);
    i_en: in std_logic;
    o_data: out std_logic_vector (g_dataSize-1 downto 0);
    o_end: out std_logic
  ) ;
end Counter ; 

architecture ArchCounter of Counter is
signal q_bus, d_bus: std_logic_vector (g_dataSize-1 downto 0); ---- senales intermedias de mi maquina de estados
begin
    ------- clk init-------
    process( i_clk, i_rst) ------ inicio el reloj y el reset para que me inicie con el flanco de subida despues de desactivar rst
    begin
      if( i_rst = '1' ) then
          q_bus <= (others=>'0');
      elsif( rising_edge(i_clk) ) then
        q_bus <= d_bus;
      end if ;
    end process ;
    -------- next state-----
      process( i_en, d_bus, q_bus )
    begin
        if i_en => '0'      ----desactivo e; contador
        d_bus <= q_bus;
        elsif i_en => '1' and q_bus = i_data then       -----reinicio el contador
            d_bus <= (others=>'0');
        else
           d_bus <= std_logic_vector (unsigned (q_bus)+1);  ----activo el contador
     end process ;
   --------present state----
        o_data <= q_bus;        -----asigno las salidas
        o_end <= '1' when q_bus = i_data else
                 '0';
end ArchCounter ;