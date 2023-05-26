library ieee;
use ieee.std_logic_1164.all;
entity reg is
    port (
        clk,en,rst:in std_logic;
        din:std_logic_vector(7 downto 0);
        dout:out std_logic_vector(7 downto 0)
    ) ;
end reg;
architecture regbeh of reg is
begin
    cuvanje : process( clk )
    variable vrednost:std_logic_vector(7 downto 0);
    begin
        if clk'event and clk='1' then
            if rst='1' then
                vrednost:="00000000";
            elsif en='1' then
                vrednost:=din;
            end if;
        end if;
        dout<=vrednost;
    end process ; -- cuvanje
end regbeh ; -- regbeh

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity brojac is
    generic(n:integer range 0 to 255:=128);
    port (
        clk,rst,en:in std_logic;
        dout:out std_logic_vector(7 downto 0)
    ) ;
end brojac;
architecture brbeh of brojac is
begin
    brojanje : process( clk )
    variable vrednost:integer range 0 to n;
    begin
        if clk'event and clk='1' then
            if rst='1' then
                vrednost:=0;
            elsif en='1' then
                if vrednost=n then
                    vrednost:=0;
                else
                    vrednost:=vrednost+1;
                end if;
            end if;
        end if;
        dout<=std_logic_vector(to_unsigned(vrednost,8));        
    end process ; -- brojanje
end brbeh ; -- brbeh

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity dekoder is
    generic(n:integer:=128);
    port (
        clk,rst,en:in std_logic;
        ulaz:in std_logic_vector(7 downto 0);
        izlaz:out std_logic_vector(n-1 downto 0)
    ) ;
end dekoder;
architecture decbeh of dekoder is
begin
    dekodrianje : process( clk )
    variable vrednost:std_logic_vector(n-1 downto 0);
    begin
        if clk'event and clk='1' then
            if rst='1' then
                vrednost:=(others=>'0');
            elsif en='1' then
                vrednost:=(others=>'0');
                vrednost(to_integer(unsigned(ulaz))):='1';
            end if;
        end if;
        izlaz<=vrednost;
    end process ; -- dekodrianje
end decbeh ; -- decbeh

library ieee;
use ieee.std_logic_1164.all;
entity kolo is
    generic (n:integer:=32);
    port (
        clk,en,rst:in std_logic;
        din:in std_logic_vector(7 downto 0);
        doutpar:out std_logic_vector(8*n-1 downto 0)
    );
end entity kolo;
architecture beh of kolo is
    signal cnttodec:std_logic_vector(7 downto 0);
    signal decout:std_logic_vector(n-1 downto 0);
begin
    cnt:entity work.brojac(brbeh)
    generic map(n=>n)
    port map(clk=>clk,rst=>rst,en=>en,dout=>cnttodec);
    dcd:entity work.dekoder(decbeh)
    generic map(n=>n)
    port map(clk=>clk,rst=>rst,en=>en,ulaz=>cnttodec,izlaz=>decout);
    registri : for i in decout'range generate
    begin
        jedanreg:entity work.reg(regbeh)
        port map(clk=>clk,rst=>rst,en=>decout(i),din=>din,dout=>doutpar(i*8+7 downto i*8));
    end generate ; -- registri
end beh ; -- beh


library ieee;
use ieee.std_logic_1164.all;
entity testbench is
    generic(n:integer:=7);
end entity testbench;
architecture testbench of testbench is
    signal clk,en,rst: std_logic;
    signal din: std_logic_vector(7 downto 0);
    signal doutpar: std_logic_vector(8*n-1 downto 0);
    begin
        clkgen : process
    begin
        clk<='0';
        wait for 10ns;
        clk<='1';
        wait for 10ns;
    end process ; -- clkgen
    kolkas:entity work.kolo(beh)
    generic map(n=>n)
    port map(clk=>clk,rst=>rst,en=>en,din=>din,doutpar=>doutpar);
    testiranje : process
    begin
        rst<='1';
        wait for 30ns;
        rst<='0';
        en<='1';
        din<="01010111";
        wait for 20ns;
        din<="10000011";
        wait for 20ns;
        din<="11111111";
        wait for 20ns;
        din<="00110011";
        wait for 20ns;
        din<="11111110";
        wait for 20ns;
        din<="01000100";
        wait for 20ns;
        din<="01000010";
        wait for 20ns;
        din<="01101001";
        wait for 5000ns;
    end process ; -- testiranje
end testbench ; -- testbench