LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY noise_suppressor_TB IS
END noise_suppressor_TB;
 
ARCHITECTURE behavior OF noise_suppressor_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT noise_suppressor
	 generic(
        g_nClkIgnore : integer := 20 
    );
    PORT(
         i_clk : IN  std_logic;
         i_rst : IN  std_logic;
         i_data : IN  std_logic;
         o_data : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal i_clk : std_logic := '0';
   signal i_rst : std_logic := '0';
   signal i_data : std_logic := '0';

 	--Outputs
   signal o_data : std_logic;

   -- Clock period definitions
   constant i_clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: noise_suppressor 
	generic map(
        g_nClkIgnore=>20
    )
	 PORT MAP (
          i_clk => i_clk,
          i_rst => i_rst,
          i_data => i_data,
          o_data => o_data
        );

   -- Clock process definitions
   i_clk_process :process
   begin
		i_clk <= '0';
		wait for i_clk_period/2;
		i_clk <= '1';
		wait for i_clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
	  i_rst<= '1';
	  wait for i_clk_period;
	  i_rst <='0';
	  i_data <= '1';
	  wait for i_clk_period/2;
	  i_data<='0';
	  wait for i_clk_period*3;
	   i_data <= '1';
	   wait for i_clk_period*2;
	  i_data <='0';
	  wait for i_clk_period;
	  i_data <= '1';
	   wait for i_clk_period*10;
		if o_data='1' then
		report "biennnn";
		else
		report "no se estabiliza";
		end if;
	  i_data<='0';
	  wait for i_clk_period;
	  i_data <= '1';
	   wait for i_clk_period;
	  i_data <= '1';
	   wait for i_clk_period;
	  i_data <='0';
	  wait for i_clk_period*2;
	  i_data <= '1';
	   wait;
   end process;

END;
