library ieee ;
    use ieee.std_logic_1164.all ;
    use ieee.numeric_std.all ;

entity sumador8bits is
    generic( N: integer:= 8);
  port ( 
      a,b: in STD_LOGIC_VECTOR( N downto 0);
      cin: in std_logic;
      suma: out std_logic_vector (n downto 0);
      cout: out std_logic
) ;
end sumador8bits ; 

architecture arch of sumador8bits is
 signal acarreo_intermedio: std_logic_vector (n downto 0)
begin
    acarreo_intermedio(0)<= cin;
    cout<= acarreo_intermedio(n);
    
Sum_generate: for i in 0 to n generate
    suma (i)<= a(i) xor b(i) xor acarreo_intermedio(i);
    acarreo_intermedio(i) <= (a(i-1) and b(i-1)) or (a(i-1) and acarreo_intermedio(i-1))) or (b(i-1) and acarreo_intermedio(i-1));
end generate;
end architecture ;