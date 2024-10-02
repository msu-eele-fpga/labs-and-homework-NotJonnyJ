library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.std_logic_unsigned.all;

entity one_pulse is
    port (
    clk : in std_ulogic;
    rst : in std_ulogic;
    input : in std_ulogic;
    pulse : out std_ulogic);
end entity one_pulse;   

architecture one_pulse_arch of one_pulse is

    type state_type is (off, on_state, waiting);
    signal state : state_type;

    begin

        state_logic : process(clk, rst, input)
            begin
            if rst = '1' then
                state <= off;
            elsif rising_edge(clk) then
                case state is

                when off =>
                    if input = '1' then
                        state <= on_state;
                    else
                        state <= off;
                    end if;
                when on_state =>
                    state <= waiting;
                when waiting =>
                    if input = '1' then
                        state <= waiting;
                    else
                        state <= off;
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
                    pulse <= '0';
                when on_state => 
                    pulse <= '1';
                when waiting =>
                    pulse <= '0';
                when others =>
                    pulse <= '0';
            end case;
        end process output_logic;

end architecture;