library ieee ;
    use ieee.std_logic_1164.all ;
    use ieee.numeric_std.all ;

entity div_frec is
    generic(
        N: integer:= 25000000      ----para que me cumpla la placa con 2Hz;
    );
  port (
    clk: in std_logic;
    rst: in std_logic;
    rco: out std_logic;
    en: in std_logic
  ) ;
end div_frec ; 


architecture ArchDiv_frec of div_frec is
signal cout: integer :=0;
signal otro_rso: std_logic :='0';
begin
 process (clk) is
	begin
	if clk'event and clk='1' then
	if rst='1' then
	cout<=0;
	otro_rso<='0';
	elsif en='1' and cout=N then
	cout<=0;
	otro_rso<= not(otro_rso);
	else
	cout<= cout+1;
	otro_rso<= otro_rso;
	end if;
	end if;
	end process;
	rco<=otro_rso;
	
	
end ArchDiv_frec ;