library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity flash_controller is
    Port (
        clk : in STD_LOGIC;
        reset : in STD_LOGIC;
        cs : in STD_LOGIC; -- Chip select
        rd : in STD_LOGIC; -- Read enable
        wr : in STD_LOGIC; -- Write enable
        addr : in STD_LOGIC_VECTOR(15 downto 0); -- Address bus
        data_in : in STD_LOGIC_VECTOR(7 downto 0); -- Data input bus
        data_out : out STD_LOGIC_VECTOR(7 downto 0) -- Data output bus
    );
end flash_controller;

architecture Behavioral of flash_controller is

    type state_type is (idle, read, write);
    signal state : state_type := idle;
    
    signal memory_array: std_logic_vector(2**16*8-1 downto 0);
    
begin

    process(clk, reset)
    begin
        if reset = '1' then
            state <= idle;
            data_out <= (others => 'Z');
            
        elsif rising_edge(clk) then
            
            case state is
                
                when idle =>
                    if cs = '0' then
                        if rd = '0' then
                            state <= read;
                        elsif wr = '0' then
                            state <= write;
                        end if;
                    end if;

                when read =>
                    data_out <= memory_array(to_integer(unsigned(addr)));
                    state <= idle;

                when write =>
                    memory_array(to_integer(unsigned(addr))) <= data_in;
                    state <= idle;

            end case;

        end if;

    end process;

end Behavioral;
