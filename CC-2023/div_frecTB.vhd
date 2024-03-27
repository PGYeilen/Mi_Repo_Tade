
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY div_frecTB IS
END div_frecTB;
 
ARCHITECTURE behavior OF div_frecTB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT div_frec
	 generic(
        N: integer:= 25000000      ----para que me cumpla la placa con 2Hz;
    );
    PORT(
         clk : IN  std_logic;
         rst : IN  std_logic;
         rco : OUT  std_logic;
         en : IN  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal rst : std_logic := '0';
   signal en : std_logic := '0';

 	--Outputs
   signal rco : std_logic;

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: div_frec 
	GENERIC MAP(
	N=>25000000
	)
	PORT MAP (
          clk => clk,
          rst => rst,
          rco => rco,
          en => en
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
     rst<= '1';
	  wait for clk_period;
	  rst<='0';
	  en<='0';
	  wait for clk_period;
	  en<='1';
	  wait for clk_period*2;
	  en<='0';
	  wait for clk_period;
	  en<='1';
	  wait;

   end process;

 END;
