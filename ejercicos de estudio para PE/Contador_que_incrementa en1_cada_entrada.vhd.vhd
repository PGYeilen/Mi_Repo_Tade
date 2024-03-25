library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Generic_Counter is
    Generic (
        n : integer := 8 -- Define el ancho del contador
    );
    Port (
        clk : in STD_LOGIC; -- Entrada de reloj
        reset : in STD_LOGIC; -- Entrada de reset
        enable : in STD_LOGIC; -- Entrada de habilitación
        data_in : in STD_LOGIC_VECTOR (n-1 downto 0); -- Entrada de datos con la misma cantidad de bits que la salida
        count : out STD_LOGIC_VECTOR (n-1 downto 0); -- Salida del contador
        max_value_reached : out STD_LOGIC -- Salida que indica si se alcanzó el valor máximo
    );
end Generic_Counter;

architecture Behavioral of Generic_Counter is
    signal temp_count : unsigned (n-1 downto 0) := (others => '0'); -- Contador temporal
    constant MAX_VALUE : unsigned (n-1 downto 0) := (others => '1'); -- Valor máximo del contador que usare para comparar
begin
    process(clk, reset)
    begin
        if reset = '1' then
            temp_count <= (others => '0'); -- Resetea el contador
            max_value_reached <= '0'; -- Desactiva la señal de valor máximo alcanzado
        elsif rising_edge(clk) then   -- si el reloj realiza un frente de subida
            if enable = '1' then
                -- Suma uno a cada bit de data_in y asigna el resultado a temp_count
                temp_count <= unsigned(data_in) + 1;
                if temp_count = MAX_VALUE then
                    max_value_reached <= '1'; -- Activa la señal de valor máximo alcanzado
                else
                    max_value_reached <= '0'; -- Desactiva la señal de valor máximo alcanzado
                end if;
            end if;
        end if;
    end process;

    count <= std_logic_vector(temp_count); -- Convierte el contador a STD_LOGIC_VECTOR
end Behavioral;


