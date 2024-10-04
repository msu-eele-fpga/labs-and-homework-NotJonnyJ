library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.std_logic_unsigned.all;
use ieee.math_real.all;

entity state0 is
    port(
            clk                  : in std_ulogic;    -- this will trigger every second coming from clock gen
            rst                  : in std_ulogic;
            leds                 : out std_ulogic_vector(6 downto 0)); -- Output led 
    
end entity state0;


--Flashes at base rate
architecture state0_arch of state0 is

    signal leds_last_state      : unsigned(6 downto 0);
    begin 


        -- generate the base clock speed of 1 second
        shift_left : process(clk, rst)
            begin
                if rst = '1' then
                    leds <= "0000001";
                    leds_last_state <= "0000001";
                elsif rising_edge(clk) then
                    leds_last_state <= leds_last_state ror 1;
                    leds <= std_ulogic_vector(leds_last_state);
                end if;
        end process shift_left;

end architecture state0_arch;
