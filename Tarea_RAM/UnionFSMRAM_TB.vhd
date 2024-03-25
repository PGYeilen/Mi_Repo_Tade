LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY UnionFSMRAM_TB IS
END UnionFSMRAM_TB;
 

ARCHITECTURE behavior OF UnionFSMRAM_TB IS 
 
  COMPONENT UnionFSMRAM
    PORT(
         din : IN  std_logic_vector(31 downto 0);
         addr : IN  std_logic_vector(7 downto 0);
         clk : IN  std_logic;
         rst : IN  std_logic;
         en : IN  std_logic;
         stp : IN  std_logic;
         lab_btn : IN  std_logic;
         dout : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal din : std_logic_vector(31 downto 0) := (others => '0');
   signal addr : std_logic_vector(7 downto 0) := (others => '0');
   signal clk : std_logic := '0';
   signal rst : std_logic := '0';
   signal en : std_logic := '0';
   signal stp : std_logic := '0';
   signal lab_btn : std_logic := '0';

 	--Outputs
   signal dout : std_logic_vector(31 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: UnionFSMRAM PORT MAP (
          din => din,
          addr => addr,
          clk => clk,
          rst => rst,
          en => en,
          stp => stp,
          lab_btn => lab_btn,
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
      rst<= '1';
		WAIT FOR 1 NS;
		wait for clk_period/2;
		rst<='0';
		lab_btn<='0';
		en<='1';
		stp<='0';
		addr<="00000001";
		din<= x"00000011";
		wait for 30 ns;
		lab_btn<= '1';
		wait for clk_period;
		lab_btn<= '0';
		
		wait for clk_period/2;
		rst<='0';
		lab_btn<='0';
		en<='1';
		stp<='0';
		addr<="00000010";
		din<= x"00000111";
		wait for 30 ns;
		lab_btn<= '1';
		wait for clk_period;
		lab_btn<= '0';
		
		wait for clk_period/2;
		rst<='0';
		en<='0';
		stp<='1';
		addr<="00000001";
		wait for 30 ns;
		lab_btn<= '1';
		wait for clk_period;
		lab_btn<= '0';
		
		wait for clk_period/2;
		rst<='0';
		en<='0';
		stp<='1';
		addr<="00000010";
		wait for 30 ns;
		lab_btn<= '1';
		wait for clk_period;
		lab_btn<= '0';
		 wait;
   end process;
	
report_proc: process
begin
 wait for 20 ns;
  wait on dout;
  assert dout<= "00000011" report "hay algo mal" severity error;
  wait for 20 ns;
  wait on dout;
  assert dout<= "00000111" report "nada bien" severity error;
  wait;
  end process;

END;
