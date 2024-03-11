library ieee ;
    use ieee.std_logic_1164.all ;
    use ieee.numeric_std.all ;
    use ieee.std_logic_unsigned.all;

entity cronometro is
  port (
  init_pause: in std_logic;
  stop_: in std_logic;
    clk: in std_logic;
    rst: in std_logic;
    q: out std_logic_vector (1 downto 0)
  ) ;
end cronometro ; 

architecture archcronometro of cronometro is
type state_type is (initial, pause, active);
signal state, next_state: state_type;
begin
  : process( cllk,rst)
    begin
        if rst= '1' then state<= initial;
        elsif clk'event and clk='1', then 
        state<= next_state;
        end if
    end process ; -- cronometer
     process( state, init_pause, stop_ )
    begin
     case (state) is
         when initial =>
    if init_pause ='1' then
        next_state <= active ;
        else
            next_state <= initial;
            end if;
        when active =>
         if  init_pause= '1' then 
         next_state <= pause;
         elsif stop='1' then
            next_state<= initial;
            else
                next_state<= active;
                end if;
        when pause=>
    if init_pause ='1' then
        next_state <= active;
        elsif stop ='1' then
            next_state <= initial;
            else
                next_state <= pause;
                end if;
                when others =>
                next_state <= initial;
                end case;
                end process;
                q(0)<= '1' when state= active else '0';
                q(1)<= '1' when state= pause else '0';
                end archcronometro;