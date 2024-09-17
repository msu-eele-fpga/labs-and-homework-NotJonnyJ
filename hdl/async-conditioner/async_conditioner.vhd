library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.std_logic_unsigned.all;

entity async_conditioner is
    port (
    clk : in std_ulogic;
    rst : in std_ulogic;
    async : in std_ulogic;
    sync : out std_ulogic);
end entity async_conditioner;

architecture async_conditioner_arch of async_conditioner is

    --This block diagram describes the functionallity
    -- This idea is --> Synchronizer --> debouncer --> one_pulse -->

    component synchronizer is
        port (
            clk     : in std_ulogic;
            async   : in std_ulogic;
            sync    : out std_ulogic);
    end component synchronizer;
   
    component debouncer is
        generic (
            clk_period : time := 20 ns;
            debounce_time : time := 60 ns);
        port (
            clk : in std_ulogic;
            rst : in std_ulogic;
            input : in std_ulogic;
            debounced : out std_ulogic);
    end component debouncer;

    component one_pulse is
        port (
        clk : in std_ulogic;
        rst : in std_ulogic;
        input : in std_ulogic;
        pulse : out std_ulogic);
    end component one_pulse;  

    signal sync_output          : std_ulogic;
    signal debounced_output     : std_ulogic;
    signal expected             : std_ulogic;

    constant DEBOUNCE_TIME : time := 80 ns;
    constant CLK_PERIOD    : time := 10 ns;

begin

    synchronizer_1 : synchronizer 
        port map(
            clk =>  clk,
            async => async,
            sync => sync_output);

    debouncer_1 : debouncer
        generic map (
            clk_period => CLK_PERIOD,
            debounce_time => DEBOUNCE_TIME)
        port map (
            clk => clk,
            rst => rst,
            input => sync_output,
            debounced => debounced_output);

    one_pulse_1 : one_pulse
        port map (
            clk => clk,
            rst => rst,
            input => debounced_output, 
            pulse => sync);

        


end architecture ;

