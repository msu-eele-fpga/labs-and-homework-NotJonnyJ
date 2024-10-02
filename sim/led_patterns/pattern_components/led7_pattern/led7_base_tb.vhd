library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.std_logic_unsigned.all;
use ieee.math_real.all;

entity led7_base_tb is           
end entity led7_base_tb;


--Flashes at base rate
architecture testbench of led7_base_tb is


    component led7_base is
        port(
                clk                  : in std_ulogic;    -- this will trigger every second coming from clock gen
                rst                  : in std_ulogic;
                enable               : in boolean;       -- Tells the component its on
                led7                 : out std_ulogic); -- Output led 
    end component led7_base;

    signal clk_tb               : std_ulogic := '0';
    signal rst_tb               : std_ulogic := '0';
    signal enable_tb            : boolean := false;
    signal led7_tb              : std_ulogic;
    signal led7_expected        : std_ulogic := '0';
    

    constant CLK_PERIOD : time := 100 ns;

    begin 


        dut : component led7_base
            port map(
                clk => clk_tb,
                rst => rst_tb,
                enable => enable_tb,
                led7 => led7_tb

            );

        clk_gen : process is
                begin
                clk_tb <= not clk_tb;
                wait for CLK_PERIOD / 2;
                  
        end process clk_gen;


        pattern_stim : process is 
            begin
                wait for 5 * CLK_PERIOD;
                enable_tb <= true;
                wait for 10 * CLK_PERIOD;
                enable_tb <= false;
                wait for 20 * CLK_PERIOD;

                enable_tb <= true;
                wait for 3 * CLK_PERIOD;
                enable_tb <= false;
                wait for 10 * CLK_PERIOD;
                enable_tb <= true;
                wait for 10 * CLK_PERIOD;
                enable_tb <= false;
                wait for 10 * CLK_PERIOD;



        end process pattern_stim;

        expected_out : process is
            begin
                led7_expected <= '0';
                wait for 5 * CLK_PERIOD;
                led7_expected <= '1';
                wait for 10 * CLK_PERIOD;
        end process expected_out;


        check_output : process is
            variable failed : boolean := false;
        begin

            if (led7_expected /= led7_tb) then
                failed := true;        
            end if;
        end process check_output;



end architecture testbench;
