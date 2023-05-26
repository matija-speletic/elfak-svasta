library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity bcd2cif is
  port (
    clk,rst,en:in std_logic;
    count : out std_logic_vector(7 downto 0)
  ) ;
end bcd2cif;
architecture bcdbeh of bcd2cif is
    signal msd,lsd:unsigned(3 downto 0);
begin
    brojanje : process( clk, rst )
    begin
        if rst='1' then
            msd<="0000";
            lsd<="0000";
        elsif clk'event and clk='1' then
            if en='1' then
                if lsd="1001" then
                    if msd="1001" then
                        lsd<="0000";
                        msd<="0000";
                    else
                        lsd<="0000";
                        msd<=msd+"0001";
                    end if;
                else
                    lsd<=lsd+"0001";
                end if;
            end if;
        end if;
        count<=std_logic_vector(msd&lsd);
    end process ; -- brojanje
end bcdbeh ; -- bcdbeh


library ieee;
use ieee.std_logic_1164.all;
entity pomreg is
  generic(n:integer:=4);
  port (
    clk,sin,rst:in std_logic;
    sout:out std_logic;
    pout:out std_logic_vector(n-1 downto 0)
  ) ;
end pomreg;
architecture prbeh of pomreg is
    signal stanje:std_logic_vector(n-1 downto 0);
begin
    pout<=stanje;
    sout<=stanje(0);
    pomeranje : process( clk,rst )
    begin
        if rst='1' then
            stanje<=(others=>'0');
        elsif clk'event and clk='1' then
            stanje(n-2 downto 0)<=stanje(n-1 downto 1);
            stanje(n-1)<=sin;
        end if;
    end process ; -- pomeranje
end prbeh ; -- prbeh


library ieee;
use ieee.std_logic_1164.all;
entity kxor is
  generic(k:integer := 4);
  port (
    x:in std_logic_vector(k-1 downto 0);
    y:out std_logic
  ) ;
end kxor;
architecture xorbeh of kxor is
    signal pass:std_logic_vector(k-1 downto 0);
begin
    pass(0)<=x(0);
    y<=pass(k-1);
    xorarr : for i in 1 to k-1 generate
    begin
        pass(i)<=pass(i-1) xor x(i);
    end generate ; -- xorarr
end xorbeh ; -- xorbeh

library ieee;
use ieee.std_logic_1164.all;
entity kolo is
  generic(
    n:integer:=12;
    k:integer:=4
  );
  port (
    clk,rst,ulaz:in std_logic;
    izlaz:out std_logic_vector(n/k-1 downto 0);
    cnt:out std_logic_vector(7 downto 0)
  ) ;
end kolo;
architecture beh of kolo is
    signal regout:std_logic_vector(n-1 downto 0);
    signal bcden:std_logic;
begin
    pr:entity work.pomreg(prbeh)
    generic map(n=>n)
    port map(
        clk=>clk,rst=>rst,sin=>ulaz,sout=>bcden,pout=>regout
    );
    br:entity work.bcd2cif(bcdbeh)
    port map(
        clk=>clk,en=>bcden,rst=>rst,count=>cnt
    );
    xorniz : for i in n/k-1 downto 0 generate
    begin
        jedanxor:entity work.kxor(xorbeh)
        generic map(k=>k)
        port map(
            x=>regout(i*k+k-1 downto i*k),y=>izlaz(i)
        );
    end generate ; -- xorniz
end beh ; -- beh



library ieee;
use ieee.std_logic_1164.all;
entity testbench is
    generic(
    n:integer:=12;
    k:integer:=4
  );
end testbench;
architecture testbench of testbench is
    signal clk,rst,ulaz:std_logic;
    signal izlaz:std_logic_vector(n/k-1 downto 0);
    signal cnt: std_logic_vector(7 downto 0);
begin
    uut:entity work.kolo(beh)
    generic map(n=>n,k=>k)
    port map(clk=>clk,rst=>rst,ulaz=>ulaz,izlaz=>izlaz,cnt=>cnt);
    clkgen : process
    begin
        clk<='0';
        wait for 10ns;
        clk<='1';
        wait for 10ns;
    end process ; -- clkgen
    testiranje : process
    begin
        rst<='1';
        wait for 20ns;
        rst<='0';
        ulaz<='1';
        wait for 60ns;
        ulaz<='0';
        wait for 60ns;
        ulaz<='1';
        wait for 60ns;
        ulaz<='0';
        wait for 60ns;
        ulaz<='1';
        wait for 60ns;
        ulaz<='0';
        wait for 60ns;
        ulaz<='1';
        wait for 60ns;
        ulaz<='0';
        wait for 60ns;
    end process ; -- testiranje
end testbench ; -- arch