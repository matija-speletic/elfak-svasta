library ieee;
use ieee.std_logic_1164.all;
entity pomreg is
    generic(n:integer:=4);
    port (
        clk,din,inenable,clr:in std_logic;
        dout: out std_logic
    ) ;
end pomreg;
architecture prbeh of pomreg is
begin
    pomeranje : process( clk,clr )
    variable value:std_logic_vector(n-1 downto 0);
    begin
        if clr='1' then
            value:=(others=>'0');
        else
            if clk'event and clk='1' then
                if inenable='1' then
                    value:=din&value(n-1 downto 1);
                else
                    value:='0'&value(n-1 downto 1);
                end if;
            end if;
        end if;
        dout<=value(0);
    end process ; -- pomeranje
end prbeh ; -- prbeh

library ieee;
use ieee.std_logic_1164.all;
entity kolo is
    generic (
        m:integer:=4;
        n:integer:=8
    );
    port (
        clk,clr,wr:in std_logic;
        din:in std_logic_vector(m-1 downto 0);
        dout:out std_logic_vector(m-1 downto 0)
    ) ;
end kolo;
architecture beh of kolo is
begin
    registri : for i in din'range generate
    begin
        reg:entity work.pomreg(prbeh)
        generic map(n=>n)
        port map(clk=>clk,inenable=>wr,din=>din(i),dout=>dout(i),clr=>clr);        
    end generate ; -- registri
end beh ; -- beh



-- Code your testbench here
library IEEE;
use IEEE.std_logic_1164.all;
entity testbench is
    generic (
        m:integer:=8;
        n:integer:=4
    );
end testbench;
architecture testbech of testbench is
    signal clk,clr,wr: std_logic;
    signal din: std_logic_vector(m-1 downto 0);
    signal dout: std_logic_vector(m-1 downto 0);
begin
    clkgen : process
    begin
        clk<='0';
        wait for 10ns;
        clk<='1';
        wait for 10ns;
    end process ; -- clkgen
    kolkas:entity work.kolo(beh)
    generic map(n=>n,m=>m)
    port map(clk=>clk,clr=>clr,wr=>wr,din=>din,dout=>dout);
    testiranje : process
    begin
        clr<='1';
        wait for 30ns;
        wr<='1';
        clr<='0';
        din<="01010101";
        wait for 20ns;
        din<="11001100";
        wait for 20ns;
        wr<='0';
        wait for 200ns;
    end process ; -- testiranje
end testbech ; -- testbech