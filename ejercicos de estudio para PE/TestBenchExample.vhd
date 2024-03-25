--Claro, para realizar un test bench del contador genérico que hemos diseñado, necesitamos simular el comportamiento del contador bajo diferentes condiciones de entrada. Esto incluirá simular el reloj, el reset, la habilitación, la entrada de datos y verificar la salida del contador y la señal de que se alcanzó el valor máximo.
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Generic_Counter_tb is
end Generic_Counter_tb;

architecture Behavioral of Generic_Counter_tb is
    -- Component declaration for the unit under test (UUT)
    component Generic_Counter
        Generic (
            WIDTH : integer := 8
        );
        Port (
            clk : in STD_LOGIC;
            reset : in STD_LOGIC;
            enable : in STD_LOGIC;
            data_in : in STD_LOGIC_VECTOR (WIDTH-1 downto 0);
            count : out STD_LOGIC_VECTOR (WIDTH-1 downto 0);
            max_value_reached : out STD_LOGIC
        );
    end component;

    -- Inputs
    signal clk : STD_LOGIC := '0';
    signal reset : STD_LOGIC := '0';
    signal enable : STD_LOGIC := '0';
    signal data_in : STD_LOGIC_VECTOR (7 downto 0) := (others => '0');

    -- Outputs
    signal count : STD_LOGIC_VECTOR (7 downto 0);
    signal max_value_reached : STD_LOGIC;

    -- Clock period definitions
    constant clk_period : time := 10 ns;
begin

    -- Instantiate the unit under test (UUT)
    uut: Generic_Counter
        generic map (
            WIDTH => 8
        )
        port map (
            clk => clk,
            reset => reset,
            enable => enable,
            data_in => data_in,
            count => count,
            max_value_reached => max_value_reached
        );

    -- Clock process definitions
    clk_process :process
    begin
        clk <= '0';
        wait for clk_period/2;
        clk <= '1';
        wait for clk_period/2;
    end process;

    -- Stimulus process
    stim_proc: process
    begin
        -- hold reset state for 100 ns.
        reset <= '1';
        wait for 100 ns;
        reset <= '0';

        -- Enable the counter and let it count
        enable <= '1';
        data_in <= "00000001"; -- Increment by 1
        wait for clk_period*10; -- Wait for 10 clock cycles

        -- Check if max value reached
        assert max_value_reached = '1' report "Max value not reached" severity error;

        -- Disable the counter
        enable <= '0';
        wait for clk_period*10; -- Wait for 10 more clock cycles

        -- Stop the simulation
        assert false report "Simulation finished" severity note;
        wait;
    end process;

end Behavioral;
--Este test bench simula el comportamiento del contador genérico bajo diferentes condiciones. Primero, se resetea el contador durante 100 ns. Luego, se habilita el contador y se le permite contar, incrementando su valor en 1 en cada ciclo de reloj. Después de 10 ciclos de reloj, se verifica si el contador ha alcanzado su valor máximo. Finalmente, se deshabilita el contador y se detiene la simulación.
