library ieee;
use ieee.std_logic_1164.all;
entity parityadder is
    generic(n:integer:=4);
  port (
    din:in std_logic_vector(n-1 downto 0);
    dout:out std_logic_vector(n downto 0)
  ) ;
end parityadder;
architecture pbbeh of parityadder is
    signal pbits:std_logic_vector(n-1 downto 0);
begin
    pbits(0)<=din(0);
    genpar : for i in 1 to n-1 generate
        pbits(i)<=pbits(i-1) xor din(i);
    end generate ; -- genpar
    dout<=pbits(n-1)&din;
end pbbeh ; -- pbbeh

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity kolo is
  port (
    a,b:in std_logic_vector(8 downto 0);
    c:out std_logic_vector(7 downto 0);
    good:out std_logic
  ) ;
end kolo;
architecture beh of kolo is
    signal a1,b1:std_logic_vector(8 downto 0);
begin
    c<=std_logic_vector(unsigned(a(7 downto 0))+unsigned(b(7 downto 0)));
    pba:entity work.parityadder(pbbeh)
    generic map(n=>8)
    port map(din=>a(7 downto 0),dout=>a1);
    pbb:entity work.parityadder(pbbeh)
    generic map(n=>8)
    port map(din=>b(7 downto 0),dout=>b1);
    provera : process( a,b,a1,b1 )
    begin
        if a=a1 and b=b1 then good<='1';
        else good<='0';
        end if;
    end process ; -- provera
end beh ; -- beh

-- Code your testbench here
library IEEE;
use IEEE.std_logic_1164.all;
entity testbench is
end entity testbench;
architecture testbench of testbench is

    signal good:std_logic;
    signal a,b:std_logic_vector(8 downto 0);
    signal c:std_logic_vector(7 downto 0);

begin
   

    uut:entity work.kolo(beh)
    port map(
        a=>a,b=>b,c=>c,good=>good
    );

    process
    begin
        a<="101010100";
        b<="000010100";
        wait for 30ns;
        a<="000000001";
        b<="000010100";
        wait for 30ns;
    end process;

end testbench ; -- testbench