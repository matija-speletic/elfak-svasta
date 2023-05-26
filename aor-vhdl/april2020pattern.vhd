--radi al broji duplo jer poklapanje izaziva dva odbrojavanja, jbg
library ieee;
use ieee.std_logic_1164.all;
entity pomreg is
    generic(n:integer:=8);
    port(
        din:in std_logic_vector(n-1 downto 0);
        clk,in_enable:std_logic;
        dout:out std_logic_vector(n-1 downto 0)
    );
end entity pomreg;
architecture prbeh of pomreg is
    signal stanje:std_logic_vector(n-1 downto 0);
begin
    dout<=stanje;
    pomeranje : process( clk )
    begin
        if clk'event and clk='1' then
            if in_enable='1' then
                stanje<=din;
            else
                stanje(n-1 downto 1)<=stanje(n-2 downto 0);
            end if;
        end if;
    end process ; -- pomeranje
end prbeh ; -- prbeh

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity nbitcounter is
  generic(n:integer:=4);
  port (
    clk,rst:in std_logic;
    value:out std_logic_vector(n-1 downto 0)
  ) ;
end nbitcounter;
architecture cntbeh of nbitcounter is
begin
    brojanje : process( clk, rst )
    variable count:integer range 0 to 2**n-1;
    begin
    	if rst='1' then
                count:=0;
        elsif clk'event and clk='1' then
            if count = 2**n-1 then
              count:=0;
            else
              count:=count+1;
        	end if;
        end if;
        value<=std_logic_vector(to_unsigned(count,n));
    end process ; -- brojanje
end cntbeh ; -- cntbeh

library ieee;
use ieee.std_logic_1164.all;
entity kolo is
  generic(pattern:std_logic_vector(1 downto 0):="00");
  port (
    clk,start:in std_logic;
    ready:out std_logic;
    data:in std_logic_vector(31 downto 0);
    count: out std_logic_vector(4 downto 0)
  ) ;
end kolo;
architecture beh of kolo is
    signal pr_izlaz:std_logic_vector(31 downto 0);
    signal upis:std_logic;
    signal poklapanje:std_logic;
begin
    pr:entity work.pomreg(prbeh)
    generic map(n=>32)
    port map(
        clk=>clk,in_enable=>upis,din=>data,dout=>pr_izlaz
    );
    cnt:entity work.nbitcounter(cntbeh)
    generic map(n=>5)
    port map(
        clk=>clk and poklapanje,
        rst=>upis,value=>count
    );
    funkcionisanje : process
    begin
        wait until start'event and start='1';
        ready<='0';
        upis<='1';
        wait until clk'event and clk='1';
        upis<='0';
        wait until clk'event and clk='1';
        for i in 0 to 31 loop
            wait until clk'event and clk='1';
                if pr_izlaz(31 downto 30)=pattern then
                    poklapanje<='1';
                else 
                    poklapanje<='0';
                end if;
            
        end loop;
        ready<='1';
        --wait until clk'event and clk='1';
    end process ; -- funkcionisanje
end beh ; -- beh







library ieee;
use ieee.std_logic_1164.all;
entity testbench is
end entity testbench;
architecture testbench of testbench is
    signal clk,start: std_logic;
    signal ready: std_logic;
    signal data: std_logic_vector(31 downto 0);
    signal count:  std_logic_vector(4 downto 0);
begin
    clk_gen:process
    begin
        clk<='1';
        wait for 10ns;
        clk<='0';
        wait for 10ns;
    end process;
    uut:entity work.kolo(beh)
    generic map(pattern=>"01")
    port map(clk=>clk,start=>start,ready=>ready,data=>data,count=>count);

    process
    begin
        data<="00000101111100110000111100000001";
        start<='0';
        wait for 100ns;
        start<='1';
        wait for 2000ns;
    end process;
    end architecture testbench;


