library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.std_logic_unsigned.all;


entity timed_counter is
    generic (
    clk_period : time;
    count_time : time);
    port (
    clk : in std_ulogic;
    enable : in boolean;
    done : out boolean);
end entity timed_counter;

architecture timed_counter_arch of timed_counter is

    constant COUNTER_LIMIT : natural := (count_time/clk_period);

    signal count : natural range 0 to 15;

    begin  
    
        process(clk)
        begin
	if rising_edge(clk) then
        done <= false;
            if(enable = true) then
                    if(count < COUNTER_LIMIT) then
                        count <= count + 1;
			
                    elsif (count = COUNTER_LIMIT) then
			count <= count + 1;
                        done <= true;	
			count <= 0;
                    end if;
		
            else
                count <= 0;
            end if;
    end if;

        end process;



end architecture timed_counter_arch;