library ieee;
use ieee.std_logic_1164.all;
entity bcd1dig is
    port(
        clk,rst:in std_logic;
        done:out std_logic;
        count:out std_logic_vector(3 downto 0)
    );
end entity bcd1dig;
architecture bcd1beh of bcd1dig is
begin
    counting : process( clk, rst )
    variable val:std_logic_vector(3 downto 0);
    begin
        if rst='1' then
            val:="0000";
            done<='0';
        elsif clk'event and clk='1' then
            case val is
                when "0000"=>val:="0001"; done<='0';
                when "0001"=>val:="0010";
                when "0010"=>val:="0011";
                when "0011"=>val:="0100";
                when "0100"=>val:="0101";
                when "0101"=>val:="0110";
                when "0110"=>val:="0111";
                when "0111"=>val:="1000";
                when "1000"=>val:="1001";
                when "1001"=>val:="0000"; done<='1';
                when others=>val:="0000"; done<='0';
            end case;
        end if;
        count<=val;
    end process ; -- counting
end bcd1beh ; -- bcd1beh

library ieee;
use ieee.std_logic_1164.all;
entity bcdndig is
    generic(n:integer:=4);
    port(
        clk,rst:in std_logic;
        value:out std_logic_vector(4*n-1 downto 0)
    );
end entity bcdndig;
architecture bcdnbeh of bcdndig is
    signal clocks:std_logic_vector(0 to n);
begin
    clocks(0)<=clk;
    counters : for i in 0 to n-1 generate
    begin
        bcd:entity work.bcd1dig(bcd1beh)
        port map(clk=>clocks(i),rst=>rst,count=>value(4*i+3 downto 4*i),done=>clocks(i+1));    
    end generate ; -- counters
end bcdnbeh ; -- bcdnbeh



library ieee;
use ieee.std_logic_1164.all;
entity testbench is
    generic (n:integer := 3);
end entity testbench;
architecture testbench of testbench is
    signal clk,rst:std_logic;
    signal value:std_logic_vector(4*n-1 downto 0);
begin
    clkgen : process
    begin
        clk<='0';
        wait for 1ns;
        clk<='1';
        wait for 1ns;
    end process ; -- clkgen
    uut:entity work.bcdndig(bcdnbeh)
    generic map(n=>n)
    port map(clk=>clk,rst=>rst,value=>value);
    testiranje : process
    begin
        rst<='1';
        wait for 3ns;
        rst<='0';
        wait for 20500ns;
    end process ; -- testiranje
end testbench ; -- testbench