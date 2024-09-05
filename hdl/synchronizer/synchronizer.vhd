library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.std_logic_unsigned.all;

entity synchronizer is
port (
    clk     : in std_ulogic;
    async   : in std_ulogic;
    sync    : out std_ulogic
);
end entity synchronizer;


architecture synchronizer_arch of synchronizer is

    signal temp	: std_ulogic;

	begin
        
        process(clk)
        begin
            if rising_edge(clk) then
                temp <= async;
            end if;
        end process;
        
        process(clk)
        begin
            if rising_edge(clk) then
                sync <= temp;
            end if;
        end process;
	
end architecture;





