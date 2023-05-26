library ieee;
use ieee.std_logic_1164.all;
entity automat is
    port(
        clk,rst,x:in std_logic;
        z:out std_logic
    );
end entity automat;
architecture beh of automat is
    type states is (s0,s1,s2,s3);
    signal current_state,next_state:states;
    --signal z_async:std_logic;
begin
    stateChange : process( rst, clk )
    begin
        if rst='1' then
            current_state<=s0;
        elsif clk'event and clk='1' then
            --z<=z_async;
            current_state<=next_state;
        end if;
    end process ; -- stateChange
    outStateCalc : process( x, current_state )
    begin
        case current_state is
            when s0 =>
                if x='0' then
                    z<='0';
                    next_state<=s0;
                elsif x='1' then
                    z<='0';
                    next_state<=s1;
                end if;
            when s1 =>
                if x='0' then
                    z<='0';
                    next_state<=s2;
                elsif x='1' then
                    z<='0';
                    next_state<=s1;
                end if;
            when s2 =>
                if x='0' then
                    z<='0';
                    next_state<=s0;
                elsif x='1' then
                    z<='0';
                    next_state<=s3;
                end if;
            when s3 =>
                if x='0' then
                    z<='0';
                    next_state<=s2;
                elsif x='1' then
                    z<='1';
                    next_state<=s1;
                end if;
        end case;
    end process ; -- outStateCalc
end beh ; -- beh

library ieee;
use ieee.std_logic_1164.all;
entity testbench is
end entity testbench;
architecture testbench of testbench is
    signal clk,rst,z,x:std_logic;
begin
    clk_gen:process
    begin
        clk<='1';
        wait for 5ns;
        clk<='0';
        wait for 5ns;
    end process;

    uut:entity work.automat(beh)
    port map(clk=>clk,rst=>rst,x=>x,z=>z);

    process
    begin
        rst<='1';
        wait for 35ns;
        rst<='0';
        x<='0';
        wait for 10ns;
        x<='1';
        wait for 30ns;
        x<='0';
        wait for 10ns;
        x<='1';
        wait for 30ns;
        x<='0';
        wait for 10ns;
        x<='1';
        wait for 10ns;
        x<='0';
        wait for 30ns;

        
    end process;
end testbench ; 