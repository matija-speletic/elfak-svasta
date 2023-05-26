library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity brojac is
    generic(n:integer:=4);
  port (
    clk,en,dir:in std_logic;
    din:in std_logic_vector(n-1 downto 0);
    dout:out std_logic_vector(n-1 downto 0)
  ) ;
end brojac;
architecture brbeh of brojac is
begin
    brojanje : process( clk )
    variable count:integer range 0 to 2**n-1;
    begin
        if clk'event and clk='1' then
            if en='1' then
                count:=to_integer(unsigned(din));
            else
                if dir='1' then
                    if count=2**n-1 then
                        count:=0;
                    else
                        count:=count+1;
                    end if;
                elsif dir='0' then
                    if count=0 then
                        count:=2**n-1;
                    else
                        count:=count-1;
                    end if;
                end if;
            end if;
        end if;
        dout<=std_logic_vector(to_unsigned(count,n));
    end process ; -- brojanje
end brbeh ; -- arch
library ieee;
use ieee.std_logic_1164.all;
entity reg is
    generic(n:integer:=4);
  port (
    clk,en:in std_logic;
    din:in std_logic_vector(n-1 downto 0);
    dout:out std_logic_vector(n-1 downto 0)
  ) ;
end reg ;
architecture regbeh of reg is
begin
    regproces : process( clk )
    variable state:std_logic_vector(n-1 downto 0);
    begin
        if clk'event and clk='1' then
            if en='1' then
                state:=din;
            end if;
        end if;
        dout<=state;
    end process ; -- regproces
end architecture ; -- regbeh
library ieee;
use ieee.std_logic_1164.all;
entity kolo is
    generic(n:integer:=4);
  port (
    clk,en:in std_logic;
    din:in std_logic_vector(n-1 downto 0);
    c:out std_logic
  ) ;
end kolo;
architecture beh of kolo is
    signal cntval:std_logic_vector(n-1 downto 0);
    signal refval:std_logic_vector(n-1 downto 0);
begin
    br:entity work.brojac(brbeh)
    generic map(n=>n)
    port map(
        clk=>clk,en=>en,dir=>'1',din=>(others=>'0'),dout=>cntval
    );
    rg:entity work.reg(regbeh)
    generic map(n=>n)
    port map(
        clk=>clk,en=>en,din=>din,dout=>refval
    );
    funkc : process( cntval,refval )
    begin
        if cntval=refval then
            c<='1';
        else 
            c<='0';
        end if;
    end process ; -- funkc
end beh ; -- beh



library ieee;
use ieee.std_logic_1164.all;
entity testbench is
end entity testbench;
architecture testbench of testbench is
    signal clk,en,c:std_logic;
    signal din:std_logic_vector(7 downto 0);
begin
    clk_gen:process
    begin
        clk<='1';
        wait for 100ns;
        clk<='0';
        wait for 100ns;
    end process;

    uut:entity work.kolo(beh)
    generic map(n=>8)
    port map(clk=>clk,en=>en,c=>c,din=>din);

    process
    begin
        en<='1';
        din<="00010000";
        wait for 300ns;
        en<='0';
        wait for 1ms;

    end process;
end testbench ; 