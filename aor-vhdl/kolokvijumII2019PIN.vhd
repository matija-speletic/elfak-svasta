library ieee;
use ieee.std_logic_1164.all;
entity andor is
    generic(ao:std_logic:='0');
  port (
    x1,x2:in std_logic;
    y:out std_logic
  ) ;
end andor;
architecture aobeh of andor is
begin
    y<=x1 and x2 when ao='1' else x1 or x2;
end aobeh ; -- aobeh

library ieee;
use ieee.std_logic_1164.all;
entity cmp1bit is
  port (
    a,b:in std_logic;
    eq:out std_logic
  ) ;
end cmp1bit;
architecture cmpbeh of cmp1bit is
begin
    eq<='1' when a=b else '0';
end architecture cmpbeh;

library ieee;
use ieee.std_logic_1164.all;
entity nbitcmp is
    generic(n:integer:=4);
    port(
        a,b:in std_logic_vector(n-1 downto 0);
        eq:out std_logic
    );
end entity nbitcmp;
architecture ncmpbeh of nbitcmp is
    signal sigeq,cmpout:std_logic_vector(n-1 downto 0);
begin
	sigeq(sigeq'left)<=cmpout(cmpout'left);
    cmps : for i in n-1 downto 0 generate
    begin
        onecmp:entity work.cmp1bit(cmpbeh)
        port map(a=>a(i),b=>b(i),eq=>cmpout(i));
        oneand:if i/=n-1 generate
        begin
            oneandcirc:entity work.andor(aobeh)
            generic map(ao=>'1')
            port map(x1=>cmpout(i),x2=>sigeq(i+1),y=>sigeq(i));
        end generate;
        eq<=sigeq(0);        
    end generate ; -- cmps
end ncmpbeh ; -- arch

library ieee;
use ieee.std_logic_1164.all;
entity pinkolo is
    generic(n:integer:=4);
    port(
        s:in std_logic;
        pinin:in std_logic_vector(n-1 downto 0);
        good:out std_logic
    );
end entity pinkolo;
architecture pinbeh of pinkolo is
    signal cmpval:std_logic_vector(n-1 downto 0);
begin
    ncmp:entity work.nbitcmp(ncmpbeh)
    generic map(n=>n)
    port map(a=>cmpval,b=>pinin,eq=>good);
    funkc:process(s,pinin)
    variable val:std_logic_vector(n-1 downto 0);
    begin
        if s='1' then
            val:=pinin;
        end if;
        cmpval<=val;
    end process;
end architecture pinbeh;



library ieee;
use ieee.std_logic_1164.all;
entity testbench is
    generic(n:integer:=8);
end entity testbench;
architecture testbench of testbench is
    signal s: std_logic;
    signal pinin: std_logic_vector(n-1 downto 0);
    signal good: std_logic;
begin
    uut:entity work.pinkolo(pinbeh)
    generic map(n=>n)
    port map(s=>s,pinin=>pinin,good=>good);

    testiranje : process
    begin
        pinin<="10100011";
        s<='1';
        wait for 10ns;
        s<='0';
        pinin<="10100011";
        wait for 10ns;
        pinin<="10100010";
        wait for 10ns;
        pinin<="10100011";
        wait for 10ns;
        pinin<="00100011";
        wait for 10ns;
        pinin<="11110000";
        wait for 10ns;
        pinin<="10100011";
        s<='1';
        wait for 10ns;
        s<='0';
        pinin<="11111111";
        wait for 10ns;
        pinin<="00000000";
        wait for 10ns;
        pinin<="11111111";
        wait for 10ns;
    end process ; -- testiranje
end testbench ; -- testbench
