library ieee ;
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;
    use ieee.std_logic_unsigned;

entity Generador_de_senal is
  port (
    clk: in std_logic;
    rst: in std_logic;
    d: in std_logic;
    q: out std_logic
  ) ;
end Generador_de_senal ; 
signal contador: integer (0 to 49999999):=0; --cuenta hasta 25M
signal sq: std_logic:='0';
architecture Generador_de_senalArch of Generador_de_senal is
begin
process( clk,rst )
begin
    if rst = '1' then
        sq <= '0';
    elsif clk'event clk='1' then
        if contador = 49999999 then
            sq <= not sq;
            contador <= 0;
        else
            contadot <= contador + 1;
    else
        sq <= '0';
end process ;
q <= sq;
end Generador_de_senalArch ;