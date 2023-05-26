library ieee;
use ieee.std_logic_1164.all;

entity reg8 is
    port(
        din:in std_logic_vector(7 downto 0);
        clk,rst,enable:in std_logic;
        dout:out std_logic_vector(7 downto 0)
    );
end entity reg8;
architecture regbeh of reg8 is
    begin
        process(clk)
        variable regval:std_logic_vector(7 downto 0);
        begin
            if clk'event and clk='1' then
                if rst='1' then
                    regval:= (others=>'0');
                elsif enable='1' then
                    regval:=din;
                end if;
            end if;
            dout<=regval;
        end process;
end architecture regbeh;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity BCD2dig is
    generic(n:std_logic_vector(7 downto 0):="00100101");
    port(
        clk,rst,enable:in std_logic;
        izlaz:out std_logic_vector(7 downto 0)
    );
end entity BCD2dig;
architecture BCDbeh of BCD2dig is
    begin
        process(clk)
        variable msd,lsd:std_logic_vector(3 downto 0);
        begin
            if clk'event and clk='1' then
                if rst='1' then
                    msd:="0000";
                    lsd:="0000";
                elsif enable='1' then
                    if msd&lsd=n then
                        msd:="0000";
                        lsd:="0000";
                    else
                        if lsd="1001" then
                            lsd:="0000";
                            msd:=msd+"0001";
                        else
                            lsd:=lsd+"0001";
                        end if;
                    end if;
                end if;
            end if;
            izlaz<=msd&lsd;
        end process;
end architecture BCDbeh;

--radi ovo savrseno ispod je testbench samo za ovo
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity dec is
    generic (n:integer:=25);
    port(
        clk,rst,enable:in std_logic;
        ulaz:in std_logic_vector(7 downto 0);
        izlaz: out std_logic_vector(n-1 downto 0)
    );
end entity;
architecture decbeh of dec is
    begin
        process(clk)
        variable dekodiraniint:integer;
        begin
            if clk'event and clk='1' then
                if rst='1' then
                    dekodiraniint:=0;
                    izlaz<=(others=>'0');
                elsif enable='1' then
                    dekodiraniint:=10*to_integer(unsigned(ulaz(7 downto 4)))+to_integer(unsigned(ulaz(3 downto 0)));
                    for i in izlaz'range loop
                        if i+1=dekodiraniint then
                            izlaz(i)<='1';
                        else
                            izlaz(I)<='0';
                        end if;
                    end loop;
                else
                    izlaz<=(others=>'0');
                end if;
            end if;
        end process;
end architecture decbeh;


LIBRARY IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity kolo is
    generic(n:integer :=4);
    port (
        clk,rst,enable:in std_logic;
        din:in std_logic_vector(7 downto 0);
        dout:out std_logic_vector(7 downto 0);
        doutparallel:out std_logic_vector(0 to 8*n-1)
    );
end entity kolo;
architecture beh of kolo is
    signal dectoreg:std_logic_vector(n-1 downto 0);
    signal bcdtodec:std_logic_vector(7 downto 0);
    begin
        cnt:entity work.BCD2dig(BCDbeh)
        generic map(n=>std_logic_vector(to_unsigned(n/10,4)&to_unsigned(n mod 10,4)))
        port map(
            clk=>clk,enable=>enable,rst=>rst,izlaz=>bcdtodec
        );
        dek:entity work.dec(decbeh)
        generic map(n=>n)
        port map(
            clk=>clk,rst=>rst,enable=>enable,ulaz=>bcdtodec,izlaz=>dectoreg
        );
        regs:for i in 0 to n-1 generate
        begin
            regg:entity work.reg8(regbeh)
            port map(
                din=>din,clk=>clk,rst=>rst,enable=>dectoreg(i),dout=>doutparallel(i*8 to i*8+7)
            );
        end generate;
        dout<=bcdtodec;
end architecture beh;



library IEEE;
use IEEE.std_logic_1164.all;
entity testbench is
end entity testbench;
architecture testbench of testbench is
    signal clk,rst,enable: std_logic;
    signal din,dout: std_logic_vector(7 downto 0);
    signal doutparallel: std_logic_vector(0 to 87);--11 brojeva
    begin
        uut:entity work.kolo(beh)
        generic map(n=>11)
        port map(clk=>clk,rst=>rst,enable=>enable,din=>din,dout=>dout,doutparallel=>doutparallel);
        process
        begin
            clk<='1';
            wait for 10 ns;
            clk<='0';
            wait for 10 ns;
        end process;
        process
        begin
        	rst<='1';
            wait for 20ns;
            rst<='0';
            enable<='1';
            din<="00000111";
            wait for 20.5ns;
            din<="10011000";
            wait for 20.5ns;
            din<="01110111";
            wait for 20.5ns;
            din<="01010101";
            wait for 20.5ns;
            din<="00010001";
            wait for 20.5ns;
            din<="00110000";
            wait for 20.5ns;
            din<="01100101";
            wait for 20.5ns;
            din<="01010111";
            wait for 20.5ns;
            din<="10001000";
            wait for 20.5ns;
            din<="10000001";
            wait for 20.5ns;
            din<="00111000";
            wait for 20.5ns;
            din<="01001001";
            wait for 20.5ns;
            din<="00111000";
            wait for 20.5ns;
            din<="01001001";
            wait for 20.5ns;
        end process;
    end architecture testbench;






-- Code your testbench here
--OVO JE TESTBENCH SAMO ZA DEKODER JER JE ZAGULJEN I RAAAAADIIIII
library IEEE;
use IEEE.std_logic_1164.all;
entity testbench is
end entity testbench;
architecture testbench of testbench is
    signal clk,rst,enable: std_logic;
    signal ulaz: std_logic_vector(7 downto 0);
    signal izlaz: std_logic_vector(24 downto 0);
    begin
        uut:entity work.dec(decbeh)
        generic map(n=>25)
        port map(clk=>clk,rst=>rst,enable=>enable,ulaz=>ulaz,izlaz=>izlaz);
        process
        begin
            clk<='1';
            wait for 10 ns;
            clk<='0';
            wait for 10 ns;
        end process;
        process
        begin
        	rst<='1';
            wait for 20ns;
            rst<='0';
            enable<='1';
            ulaz<="00000111";
            wait for 50ns;
        end process;
    end architecture testbench;