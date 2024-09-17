library ieee;
use ieee.std_logic_1164.all;

entity async_conditioner_tb is
end entity async_conditioner_tb;

architecture testbench of async_conditioner_tb is

  constant CLK_PERIOD : time := 20 ns;

  component async_conditioner is
    port (
        clk : in std_ulogic;
        rst : in std_ulogic;
        async : in std_ulogic;
        sync : out std_ulogic);
  end component async_conditioner;

  signal clk_tb        : std_ulogic := '0';
  signal rst_tb        : std_ulogic := '0';
  signal async_tb      : std_ulogic := '0';
  signal sync_tb       : std_ulogic := '0';
  signal expected : std_ulogic;

begin

  dut : component async_conditioner
    port map (
      clk   => clk_tb,
      rst => rst_tb,
      async => async_tb,
      sync => sync_tb
    );

  clk_gen : process is
  begin

    clk_tb <= not clk_tb;
    wait for CLK_PERIOD / 2;

  end process clk_gen;

  -- Create the one pulse signal
  async_conditioner_stim : process is
  begin
    --Reset for 2 clock periods
    
    async_tb <= '0';
    wait for 2 * CLK_PERIOD;

    async_tb <= '1';
    wait for 0.5 * CLK_PERIOD;

    async_tb <= '0';
    wait for 0.5 * CLK_PERIOD;

    async_tb <= '1';
    wait for 0.3 * CLK_PERIOD;

    async_tb <= '0';
    wait for 0.7 * CLK_PERIOD;

    async_tb <= '1';
    wait for 1 * CLK_PERIOD;

    async_tb <= '0';
    wait for 0.9 * CLK_PERIOD;

    async_tb <= '1';
    wait for 0.5 * CLK_PERIOD;

    async_tb <= '0';
    wait for 1 * CLK_PERIOD;

    async_tb <= '1';
    wait for 0.5 * CLK_PERIOD;

    async_tb <= '0';
    wait for 0.5 * CLK_PERIOD;
    
    async_tb <= '1';
    wait for 0.9 * CLK_PERIOD;

    async_tb <= '0';
    wait for 10 * CLK_PERIOD;

    async_tb <= '1';
    wait for 2 * CLK_PERIOD;

    async_tb <= '0';
    wait for 16 * CLK_PERIOD;

    async_tb <= '1';
    wait for 6 * CLK_PERIOD;

    async_tb <= '0';
    wait for 10 * CLK_PERIOD;

    



    wait;

  end process async_conditioner_stim;

  -- Create the expected one pulse output waveform
  expected_conditioner_stim : process is
  begin

    --Reset state
    expected <= '0';
    wait for 5 * CLK_PERIOD;

    -- Nothing until async input 
    expected <= '1';
    wait for 1 * CLK_PERIOD;

    -- Off forever
    expected <= '0';
    wait for 17 * CLK_PERIOD;

    expected <= '1';
    wait for 1 * CLK_PERIOD;

    -- Off forever
    expected <= '0';
    wait for 17 * CLK_PERIOD;

    expected <= '1';
    wait for 1 * CLK_PERIOD;

    -- Off forever
    expected <= '0';
    wait for 1 * CLK_PERIOD;


    wait;

  end process expected_conditioner_stim;

  check_output : process is

    variable failed : boolean := false;

  begin

    for i in 0 to 9 loop

      assert expected = sync_tb
        report "Error for clock cycle " & to_string(i) & ":" & LF & "output = " & to_string(sync_tb) & " expected output  = " & to_string(expected)
        severity warning;

      if expected /= sync_tb then
        failed := true;
      end if;

      wait for CLK_PERIOD;

    end loop;

    if failed then
     report "tests failed!"
        severity failure;
    else
      report "all tests passed!";
    end if;

    std.env.finish;

  end process check_output;

end architecture testbench;
