library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.std_logic_unsigned.all;
use ieee.math_real.all;

entity clock_gen_tb is           
end entity clock_gen_tb;


--Flashes at base rate
architecture testbench of clock_gen_tb is

    constant CLK_PERIOD : time := 20 ns;

    component clk_gen is
        generic(
            NUM_OF_BITS             : natural := 3);
        port(
                clk                  : in std_ulogic;
                rst                  : in std_ulogic;
                cnt                  : in unsigned(NUM_OF_BITS downto 0);
                base_clock           : out std_ulogic;
                half_base_clock      : out std_ulogic;
                quarter_base_clock   : out std_ulogic;
                eigth_base_clock     : out std_ulogic;
                twice_base_clock     : out std_ulogic);
    end component clk_gen;

    signal clk_tb                   : std_ulogic := '0';
    signal rst_tb                   : std_ulogic := '0';
    signal cnt_tb                   : unsigned(3 downto 0) := "1110";
    signal base_clock_tb            : std_ulogic := '0';
    signal half_base_clock_tb       : std_ulogic := '0';
    signal quarter_base_clock_tb    : std_ulogic := '0';
    signal eigth_base_clock_tb      : std_ulogic := '0';
    signal twice_base_clock_tb      : std_ulogic := '0';
    signal num_bits_tb              : natural;   
    

    

    begin 


        dut : component clk_gen
            generic map(
                NUM_OF_BITS => 3
            )
            port map(
                    clk => clk_tb,                
                    rst => rst_tb,                 
                    cnt => cnt_tb,                 
                    base_clock => base_clock_tb,          
                    half_base_clock => half_base_clock_tb,     
                    quarter_base_clock => quarter_base_clock_tb,  
                    eigth_base_clock => eigth_base_clock_tb,    
                    twice_base_clock => twice_base_clock_tb     
                    );
            

        clock_gen : process is
                begin
                clk_tb <= not clk_tb;
                wait for CLK_PERIOD / 2;
                  
        end process clock_gen;


        stim : process is
            begin
                rst_tb <= '1';
                wait for CLK_PERIOD;
                rst_tb <= '0';
                wait for 100 * CLK_PERIOD;
                
        end process stim;



end architecture testbench;
