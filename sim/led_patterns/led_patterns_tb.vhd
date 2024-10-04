library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;
use IEEE.std_logic_unsigned.all;

entity led_patterns_tb is
end entity led_patterns_tb;

architecture testbench of led_patterns_tb is

  component led_patterns is
    generic
    (
      SYSTEM_CLOCK_PERIOD : time := 20 ns);
    port
    (
      clk             : in std_ulogic; -- system clock
      rst             : in std_ulogic; -- system reset (assume active high, change at top level if needed)
      push_button     : in std_ulogic; -- Pushbutton to change state (assume active high, change at top level if needed)
      switches        : in std_ulogic_vector(3 downto 0); -- Switches that determine the next state to be selected
      hps_led_control : in boolean; -- Software is in control when asserted (=1)
      base_period     : in unsigned(7 downto 0); -- base transition period in seconds , fixed -point data type (W=8, F=4).
      led_reg         : in std_ulogic_vector(7 downto 0); -- LED register
      led             : out std_ulogic_vector(7 downto 0) -- LEDs on the DE10-Nano board
    );
  end component led_patterns;

  constant CLK_PERIOD : time := 20 ns;

  signal clk_tb             : std_ulogic := '0';
  signal rst_tb             : std_ulogic := '0';
  signal push_button_tb     : std_ulogic := '0';
  signal switches_tb        : std_ulogic_vector(3 downto 0);
  signal hps_led_control_tb : boolean;
  signal base_period_tb     : unsigned(7 downto 0) := "00000010";
  signal led_reg_tb         : std_ulogic_vector(7 downto 0);
  signal led_tb             : std_ulogic_vector(7 downto 0);

begin

    

  dut : component led_patterns
    port map
    (
      clk             => clk_tb,
      rst             => rst_tb,
      push_button     => push_button_tb,
      switches        => switches_tb,
      hps_led_control => hps_led_control_tb,
      base_period     => base_period_tb,
      led_reg         => led_reg_tb,
      led             => led_tb
    );

    clock_gen : process is
    begin
      clk_tb <= not clk_tb;
      wait for CLK_PERIOD / 2;

    end process clock_gen;

    led_patterns_stim : process is
    begin
      switches_tb <= "0000";
      rst_tb <= '1';
      wait for CLK_PERIOD;
      rst_tb <= '0';
      wait for 45 * CLK_PERIOD;
      switches_tb <= "0001";
      wait for 30 * CLK_PERIOD;
      push_button_tb <= '1';
      wait for CLK_PERIOD;
      push_button_tb <= '0';
      wait for 20 * CLK_PERIOD;
      switches_tb <= "0000";
      wait for 10 * CLK_PERIOD;
      push_button_tb <= '1';
      wait for 4 * CLK_PERIOD;
      push_button_tb <= '0';
      wait for 30 * CLK_PERIOD;
      switches_tb <= "0100";
      wait for 22 * CLK_PERIOD;
      push_button_tb <= '1';
      wait for CLK_PERIOD;
      push_button_tb <= '0';

      switches_tb <= "0100";
      wait for 10 * CLK_PERIOD;
      push_button_tb <= '1';
      wait for 4 * CLK_PERIOD;
      push_button_tb <= '0';
      wait for 30 * CLK_PERIOD;
      switches_tb <= "1000";
      wait for 22 * CLK_PERIOD;
      push_button_tb <= '1';
      wait for CLK_PERIOD;
      push_button_tb <= '0';

      wait;

    end process led_patterns_stim;

  end architecture testbench;