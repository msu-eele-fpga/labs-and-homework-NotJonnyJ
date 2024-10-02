library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.std_logic_unsigned.all;
use ieee.math_real.all;

entity state0_tb is           
end entity state0_tb;


--Flashes at base rate
architecture testbench of state0_tb is


    component state0 is
        port(
            clk                  : in std_ulogic;    -- this will trigger every second coming from clock gen
            rst                  : in std_ulogic;
            leds                 : out std_ulogic_vector(6 downto 0)); -- Output led 
    end component state0;

    signal clk_tb               : std_ulogic := '0';
    signal rst_tb               : std_ulogic := '0';
    signal leds_tb              : std_ulogic_vector(6 downto 0);
    signal leds_expected        : std_ulogic_vector(6 downto 0);
    

    constant CLK_PERIOD : time := 100 ns;

    begin 


        dut : component state0
            port map(
                clk => clk_tb,
                rst => rst_tb,
                leds => leds_tb
            );

        clk_gen : process is
                begin
                clk_tb <= not clk_tb;
                wait for CLK_PERIOD / 2;
                  
        end process clk_gen;


        pattern_stim : process is 
            begin
                wait for 2 * CLK_PERIOD;
                rst_tb <= '1';
                wait for CLK_PERIOD;
                rst_tb <= '0';
                wait;
                
        end process pattern_stim;

        expected_out : process is
            begin
                leds_expected <= "0000001";
                wait;
        end process expected_out;


        check_output : process is
            variable failed : boolean := false;
        begin

            if (leds_expected /= leds_tb) then
                failed := true;        
            end if;
        end process check_output;



end architecture testbench;
