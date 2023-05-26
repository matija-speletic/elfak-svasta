library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity alu is
    generic(n:integer:=4);
  port (
    clk,enable,rst:in std_logic;
    brojA,brojB:in std_logic_vector(n-1 downto 0);
    operacija:in std_logic_vector(1 downto 0);
    brojC:out std_logic_vector(n-1 downto 0)
  ) ;
end alu;
architecture alubeh of alu is
begin
    racunanje : process( clk )
    variable a,b,c : integer range -2**(n-1) to 2**(n-1)-1;
    begin
        if clk'event and clk='1' then
            if rst='1' then
                a:=0;
                b:=0;
                c:=0;
            elsif enable='1' then
            	a:=to_integer(signed(brojA));
                b:=to_integer(signed(brojB));
                if operacija="00" then
                    c:=a+b;
                elsif operacija="01" then
                    c:=a-b;
                elsif operacija="10" then
                    c:=a*b;
                elsif b/=0 then
                    c:=a/b;
                end if;
            end if;
        end if;
        brojC<=std_logic_vector(to_signed(c,n));        
    end process ; -- racunanje
end alubeh ; -- alubeh


library ieee;
use ieee.std_logic_1164.all;
entity kolo is
    generic(
        n:integer:=8;
        k:integer:=4
    );
  port (
    clk,rst,enable:in std_logic;
    brojevi:in std_logic_vector(k*n-1 downto 0);
    noperacija:in std_logic_vector((k-1)*2-1 downto 0);
    result:out std_logic_vector(n-1 downto 0)
  ) ;
end kolo;
architecture beh of kolo is
    type op_fields is array (k-1 downto 0) of std_logic_vector(n-1 downto 0);
    signal operandi:op_fields;
begin
    operandi(k-1)<=brojevi(k*n-1 downto (k-1)*n);
    operacije : for i in k-2 downto 0 generate
    begin
        kolce:entity work.alu(alubeh)
        generic map(n=>n)
        port map(
            clk=>clk,enable=>enable,rst=>rst,
            brojA=>operandi(i+1),
            brojB=>brojevi((i+1)*n-1 downto i*n),
            brojC=>operandi(i),
            operacija=>noperacija(i*2+1 downto i*2)
        );
        
    end generate ; -- operacije
    result<=operandi(0);

end beh ; -- beh




library ieee;
use ieee.std_logic_1164.all;
entity testbench is
    generic(
        n:integer:=8;
        k:integer:=4
    );
end testbench;
architecture testbench of testbench is
    signal clk,rst,enable: std_logic;
    signal brojevi: std_logic_vector(k*n-1 downto 0);
    signal noperacija: std_logic_vector((k-1)*2-1 downto 0);
    signal result: std_logic_vector(n-1 downto 0);
    begin
        clk_gen:process
    begin
        clk<='1';
        wait for 10ns;
        clk<='0';
        wait for 10ns;
    end process;

    uut:entity work.kolo(beh)
    generic map(n=>n,k=>k)
    port map(
        clk=>clk,enable=>enable,rst=>rst,
        brojevi=>brojevi,noperacija=>noperacija,result=>result
    );

    process
    begin
        rst<='1';
        wait for 30ns;
        rst<='0';
        enable<='1';
        --(4*4+5)-3
        brojevi<="00000100000001000000010100000011";
        noperacija<="100011";
        wait for 200ns;
        rst<='1';
        wait for 30ns;
        rst<='0';
        enable<='1';
        --4-3+7+0
        brojevi<="00000100000000110000011100000000";
        noperacija<="010000";
        wait for 200ns;
end process;
end testbench ; -- testbench