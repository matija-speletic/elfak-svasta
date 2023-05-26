library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity nbitcounter is
  generic(n:integer:=4);
  port (
    clk,rst,en:in std_logic;
    value:out std_logic_vector(n-1 downto 0)
  ) ;
end nbitcounter;
architecture cntbeh of nbitcounter is
begin
    brojanje : process( clk )
    variable count:integer range 0 to 2**n-1;
    begin
        if clk'event and clk='1' then
            if rst='1' then
                count:=0;
            elsif en='1' then
                if count = 2**n-1 then
                    count:=0;
                else
                    count:=count+1;
                end if;
            end if;
        end if;
        value<=std_logic_vector(to_unsigned(count,n));
    end process ; -- brojanje
end cntbeh ; -- cntbeh



library ieee;
use ieee.std_logic_1164.all;
entity testbench is
end entity testbench;
architecture testbench of testbench is
    signal clk,en,rst:std_logic;
    signal count:std_logic_vector(7 downto 0);

begin
    clk_gen:process
    begin
        clk<='1';
        wait for 5ns;
        clk<='0';
        wait for 5ns;
    end process;

    bro:entity work.nbitcounter(cntbeh)
    generic map(n=>8)
    port map(
        clk=>clk,rst=>rst,en=>en,value=>count
    );

    process
    begin
        rst<='1';
        wait for 30ns;
        rst<='0';
        en<='1';
        wait for 3100ns;
        en<='0';
        wait for 50ns;
        rst<='1';
        en<='1';
        wait for 30ns;
        rst<='0';
        wait for 200ns;
    end process;
end testbench ; 