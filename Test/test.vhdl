library ieee ;
    use ieee.std_logic_1164.all ;
    use ieee.numeric_std.all ;

entity ent is
  port (
    a: in std_logic;

    b: in std_logic;

    c: out std_logic

  ) ;
end ent ; 

architecture arch of ent is

begin
 c <= a or b
end architecture ;