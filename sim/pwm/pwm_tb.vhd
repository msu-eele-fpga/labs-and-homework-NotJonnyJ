library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.std_logic_unsigned.all;
use ieee.math_real.all;

entity pwm_tb is
end entity pwm_tb;

architecture testbench of pwm_tb is

    constant CLK_PERIOD : time := 20 ns;

    component pwm_controller is
        generic (
            CLK_PERIOD   : time := 20 ns
        );
        port (
            clk : in std_logic;
            rst : in std_logic;
            -- PWM repetition period in milliseconds;
            -- datatype (W.F) is individually assigned
            period : in unsigned(31 - 1 downto 0);
            -- PWM duty cycle between [0 1]; out-of-range values are hard-limited
            -- datatype (W.F) is individually assigned
            duty_cycle : in std_logic_vector(18 - 1 downto 0);
            output : out std_logic
        );
    end component;

    signal clk_tb           : std_ulogic := '0';
    signal rst_tb           : std_ulogic := '0';
    signal period_tb        : unsigned(30 downto 0) := "0000010000000000000000000000000"; -- 1 ms     fixed pt 31.25 
    signal duty_cycle_tb    : std_logic_vector(17 downto 0) := "000011001100110011";      -- 10% (0.1)  fixed pt 18.17
    signal output_tb        : std_logic := '0';


    begin

        dut : component pwm_controller
         generic map(
            CLK_PERIOD => CLK_PERIOD
        )
         port map(
            clk => clk_tb,
            rst => rst_tb,
            period => period_tb,
            duty_cycle => duty_cycle_tb,
            output => output_tb
        );

        clock_gen : process is
            begin
              clk_tb <= not clk_tb;
              wait for CLK_PERIOD / 2;
        
        end process clock_gen;


          


end architecture testbench;