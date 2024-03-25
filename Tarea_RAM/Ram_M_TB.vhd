LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY Ram_M_TB IS
END Ram_M_TB;
 
ARCHITECTURE behavior OF Ram_M_TB IS 
 
 COMPONENT Ram_M is
generic(
 ADDR_WIDTH : integer := 8;
 DATA_WIDTH : integer := 32 
);
port(
 clk,rst: in std_logic;
 en,wr,rd: IN STD_LOGIC;
din: in std_logic_vector (data_width-1 downto 0);
addr: in std_logic_vector (addr_width-1 downto 0);
dout: out std_logic_vector (data_width-1 downto 0)
);
end COMPONENT;

   --Inputs
   signal clk : std_logic := '0';
   signal rst : std_logic := '0';
   signal en : std_logic := '0';
   signal wr : std_logic := '0';
   signal rd : std_logic := '0';
   signal din : std_logic_vector(31 downto 0) := (others => '0');
   signal addr : std_logic_vector(7 downto 0) := (others => '0');

 	--Outputs
   signal dout : std_logic_vector(31 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Ram_M 
	GENERIC MAP(
	ADDR_WIDTH=> 8,
	DATA_WIDTH=> 32
	)
	PORT MAP (
          clk => clk,
          rst => rst,
          en => en,
          wr => wr,
          rd => rd,
          din => din,
          addr => addr,
          dout => dout
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
      RST<= '1';
		WAIT FOR clk_period/2;
		rst<='0';
		en<='1';
		wr<='1';
		rd<='0';
		addr<= "00000001";
		din<=x"00000001";
		
		wait for 50 ns ;
		wr<='1';
		rd<='0';
		addr<= "00000010";
		din<=x"00000011";
		
		wait for 50 ns ;
		wr<='0';
		rd<='1';
		addr<= "00000001";
		
		wait for 50 ns ;
		wr<='0';
		rd<='1';
		addr<= "00000010";
      wait;
   end process;
	
report_process: process
 begin 
 wait for 50 ns;
 wait on dout;
 wait for 1 ns;
 assert dout= x"00000001" report " no paso la prueba" severity error;
 wait on dout;
 wait for 1 ns;
 assert dout= x"00000011" report " no paso la otra prueba" severity error;
 wait;
 end process;
 
END;
