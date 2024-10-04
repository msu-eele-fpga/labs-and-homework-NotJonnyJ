library ieee;
use ieee.std_logic_1164.all;
use work.print_pkg.all;
use work.assert_pkg.all;
use work.tb_pkg.all;

entity timed_counter_tb is
end entity timed_counter_tb;

architecture testbench of timed_counter_tb is

    component timed_counter is
        generic (
            clk_period : time;
            count_time : time
        );
        port (
            clk : in std_ulogic;
            enable : in boolean;
            done : out boolean
        );
    end component timed_counter;

    signal clk_tb : std_ulogic := '0';

    signal enable_100ns_tb : boolean := false;
    signal done_100ns_tb : boolean;
    signal enable_260ns_tb : boolean := false;
    signal done_260ns_tb : boolean;

    constant HUNDRED_NS : time := 100 ns;
    constant TWO_HUNDRED_SIXTY_NS : time := 260 ns;

    procedure predict_counter_done (
        constant count_time : in time;
        signal enable : in boolean;
        signal done : in boolean;
        constant count_iter : in natural) is

            begin

                if enable then
                    if count_iter < (count_time / CLK_PERIOD) then
                        assert_false(done, "counter not done");
                    else
                        assert_true(done, "counter is done");
                    end if;
                else
                    assert_false(done, "counter not enabled");
                end if;
    end procedure predict_counter_done;

begin

    dut_100ns_counter : component timed_counter
        generic map (
            clk_period => CLK_PERIOD,
            count_time => HUNDRED_NS
        )
        port map (
            clk => clk_tb,
            enable => enable_100ns_tb,
            done => done_100ns_tb
        );
	
	dut_260ns_counter : component timed_counter
        generic map (
            clk_period => CLK_PERIOD,
            count_time => TWO_HUNDRED_SIXTY_NS
        )
        port map (
            clk => clk_tb,
            enable => enable_260ns_tb,
            done => done_260ns_tb
        );

    clk_tb <= not clk_tb after CLK_PERIOD / 2;

    stimuli_and_checker : process is
    begin
	

	--TEST CASE 1 ------------------------------------------------------
        -- test 100 ns timer when it's enabled
        print("TEST 1 : testing 100 ns timer: enabled");
        wait_for_clock_edge(clk_tb);
        enable_100ns_tb <= true;

        -- loop for the number of clock cylces that is equal to the timer's period

        for i in 0 to (HUNDRED_NS / CLK_PERIOD) loop
            wait_for_clock_edge(clk_tb);
            -- test whether the counter's done output is correct or not
            predict_counter_done(HUNDRED_NS, enable_100ns_tb, done_100ns_tb, i);
        end loop;

        -- TEST CASE 2 --------------------------------------------------------

	print("TEST 2 : testing 200 ns timer: disabled");
        wait_for_clock_edge(clk_tb);
        enable_100ns_tb <= false;

        -- loop for the number of clock cylces that is equal to the timer's period
        for i in 0 to ((HUNDRED_NS*2) / CLK_PERIOD) loop
            wait_for_clock_edge(clk_tb);
            -- test whether the counter's done output is correct or not
            predict_counter_done(HUNDRED_NS, enable_100ns_tb, done_100ns_tb, i);
        end loop;

	-- TEST CASE 3 ------------------------------------------------------
	print("TEST 3 : testing 200 ns timer: enabled");
        wait_for_clock_edge(clk_tb);
        enable_100ns_tb <= true;

        -- loop for the number of clock cylces that is equal to the timer's period
	for j in 0 to 1 loop
        for i in 0 to (HUNDRED_NS / CLK_PERIOD) loop
            wait_for_clock_edge(clk_tb);
            -- test whether the counter's done output is correct or not
            predict_counter_done(HUNDRED_NS, enable_100ns_tb, done_100ns_tb, i);
        end loop;
	end loop;

	-- TEST CASE 4 ------------------------------------------------------
	enable_100ns_tb <= false;
	print("TEST 4 : testing 260 ns timer: enabled");
        wait_for_clock_edge(clk_tb);
        enable_260ns_tb <= true;

        -- loop for the number of clock cylces that is equal to the timer's period
        for i in 0 to (TWO_HUNDRED_SIXTY_NS / CLK_PERIOD) loop
            wait_for_clock_edge(clk_tb);
            -- test whether the counter's done output is correct or not
            predict_counter_done(TWO_HUNDRED_SIXTY_NS, enable_260ns_tb, done_260ns_tb, i);
	end loop;
	enable_260ns_tb <= false;

	

	--TEST CASE 5 ------------------------------------------------------
	enable_100ns_tb <= false;
        -- test 100 ns timer when it's enabled
        print("TEST 5 : testing 100 ns timer: enabled");
        wait_for_clock_edge(clk_tb);
        enable_100ns_tb <= true;

        -- loop for the number of clock cylces that is equal to the timer's period

        for i in 0 to (HUNDRED_NS / CLK_PERIOD) loop
            wait_for_clock_edge(clk_tb);
            -- test whether the counter's done output is correct or not
            predict_counter_done(HUNDRED_NS, enable_100ns_tb, done_100ns_tb, i);
        end loop;

        -- TEST CASE 6 --------------------------------------------------------

	print("TEST 6 : testing 200 ns timer: disabled");
        wait_for_clock_edge(clk_tb);
        enable_100ns_tb <= false;

        -- loop for the number of clock cylces that is equal to the timer's period
        for i in 0 to ((HUNDRED_NS*2) / CLK_PERIOD) loop
            wait_for_clock_edge(clk_tb);
            -- test whether the counter's done output is correct or not
            predict_counter_done(HUNDRED_NS, enable_100ns_tb, done_100ns_tb, i);
        end loop;

	-- TEST CASE 7 ------------------------------------------------------
	print("TEST 7 : testing 200 ns timer: enabled");
        wait_for_clock_edge(clk_tb);
        enable_100ns_tb <= true;

        -- loop for the number of clock cylces that is equal to the timer's period
	for j in 0 to 1 loop
        for i in 0 to (HUNDRED_NS / CLK_PERIOD) loop
            wait_for_clock_edge(clk_tb);
            -- test whether the counter's done output is correct or not
            predict_counter_done(HUNDRED_NS, enable_100ns_tb, done_100ns_tb, i);
        end loop;
	end loop;


        -- testbench is done
	print("Passed All Tests!");
        std.env.finish;

    end process stimuli_and_checker;

end architecture testbench;