library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity TopModule is
    port (
    clk, rst: in std_logic;
    Dout: out std_logic_vector (7 downto 0)
    ) ;
   end TopModule ;
   
   architecture arch of TopModule is
    component genBinCounter
     generic(n: integer := 8);
     port (
     clk, rst, enc: in std_logic;
     dataIn: in std_logic_vector (N-1 downto 0);
     dataOut: out std_logic_vector (N-1 downto 0)
     );
    end component;
    component genDiv
generic(
 MaxCount: integer := 50000000
);
port (
 clk, rst: in std_logic;
 pulse: out std_logic
);
end component;
signal pulse: std_logic;
begin
    begin
        Div0: genDiv
        generic map(
       MaxCount => 50000000
        ) 
        port map(
        clk => clk,
        rst => rst,
        pulse => pulse
        );
        Counter0: genBinCounter
        generic map(
       B => 8
        )
        port map(
        clk => clk,
        rst => rst,
        enc => pulse,
       dataIn => "00000000",
       dataOut=> data
        );
       end architecture arch;
       