library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.std_logic_unsigned.all;

entity debouncer is
    generic (
        clk_period : time;
        debounce_time : time
    );
    port (
        clk : in std_ulogic;
        rst : in std_ulogic;
        input : in std_ulogic;
        debounced : out std_ulogic
    );
end entity debouncer;

architecture debouncer_arch of debouncer is


    constant COUNTER_LIMIT : natural := (debounce_time/clk_period);

    type state_type is (off, button_pressed, debouncing);
    signal state : state_type;


    signal count : natural;

    begin

        state_logic : process(clk, rst, input)
            begin
            if rst = '1' then
                state <= off;
            elsif rising_edge(clk) then
                case state is

                when off =>
                    count <= 0;
                    if input = '1' then
                        state <= button_pressed;
                    else 
                        state <= off;
                    end if;
                when button_pressed =>
                    if(count < COUNTER_LIMIT-1) then
                        count <= count + 1;
                    elsif(count = COUNTER_LIMIT-1) then
                        count <= 0;
                        if input = '0' then
                            state <= debouncing;
                        else 
                            state <= button_pressed;
                        end if;
                    else
                        count <= 0;
                    end if;
                when debouncing =>
                    if(count < COUNTER_LIMIT-1) then
                        count <= count + 1;
                    elsif(count = COUNTER_LIMIT-1) then

                        count <= 0;
                        state <= off;
                    else
                        count <= 0;
                    end if;

                when others =>
                    state <= off;

                end case;
            end if;
        end process state_logic;
        
            -- combinational
        output_logic : process(state)
            begin
            case state is
                when off =>
                    debounced <= '0';
                when button_pressed => 
                    debounced <= '1';
                when debouncing =>
                    debounced <= '0'; 
                when others =>
                    debounced <= '0';
            end case;
        end process output_logic;

end architecture;