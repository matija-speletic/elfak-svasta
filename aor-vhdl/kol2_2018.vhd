library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity brojac is
    generic(n:integer:=4);
    port(
        clk,rst,dir:in std_logic;--dir=0 - navise, dir=1-nanize
        izlaz:out std_logic_vector(n-1 downto 0)
    );
end entity brojac;
architecture brbeh of brojac is
    begin
        process(clk)
        variable stanje:unsigned(n-1 downto 0);
        begin
            if clk'event and clk='1' then
                if rst='1' then
                    stanje:=(others=>'0');
                else
                    if dir='0' then
                        stanje:=stanje+to_unsigned(1,n);
                    elsif dir='1' then
                        stanje:=stanje-to_unsigned(1,n);
                    end if;
                end if;
            end if;
            izlaz<=std_logic_vector(stanje);
        end process;
end architecture brbeh;

library ieee;
use ieee.std_logic_1164.all;
entity Dff is
    port(
        d,clk:in std_logic;
        q:out std_logic
    );
end entity Dff;
architecture ffbeh of Dff is
    begin
        process(clk)
        begin
            if clk'event and clk='1' then
                q<=d;
            end if;
        end process;
end architecture ffbeh;

library ieee;
use ieee.std_logic_1164.all;
entity kolo is
    generic(n:integer:=4);
    port(
        clk,rst,dir:in std_logic;
        izlaz:out std_logic_vector(n-1 downto 0)
    );
end entity kolo;
architecture beh of kolo is
    signal msbtoff:std_logic_vector(n-1 downto 0);
    begin
        cnt:entity work.brojac(brbeh)
        generic map(n=>n)
        port map(clk=>clk,rst=>rst,dir=>dir,izlaz=>msbtoff);
        ff:entity work.Dff(ffbeh)
        port map(d=>msbtoff(n-1),clk=>clk,q=>izlaz(n-1));
        izlaz(n-2 downto 0)<=msbtoff(n-2 downto 0);
end architecture beh;




library ieee;
use ieee.std_logic_1164.all;
entity testbench is
end entity testbench;
architecture testbench of testbench is
    signal clk,rst,dir:std_logic;
    signal izlaz:std_logic_vector(7 downto 0);
    begin
        clk_gen:process
        begin
            clk<='1';
            wait for 100 ns;
            clk<='0';
            wait for 100 ns;
        end process;
        uut:entity work.kolo(beh)
        generic map(n=>8)
        port map(clk=>clk,rst=>rst,dir=>dir,izlaz=>izlaz);
        testiranje:process
        begin
            rst<='1';
            wait for 201 ns;
            rst<='0';
            dir<='0';
            wait for 250000 ns;
            dir<='1';
            wait for 250000 ns;
        end process;
    end architecture;

