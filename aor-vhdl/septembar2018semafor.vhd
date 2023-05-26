library ieee;
use ieee.std_logic_1164.all;
entity brojac is
    generic (n:integer := 32);
    port(
        clk,rst,en:in std_logic;
        count:out integer range 0 to n-1
    );
end entity brojac;
architecture brbeh of brojac is
begin
    brojanje : process( clk )
    variable val:integer range 0 to n-1;
    begin
        if clk'event and clk='1' then
            if rst='1' then
                val:=0;
            elsif en='1' then
                if val<n-1 then
                    val:=val+1;
                end if;
            end if;
        end if;
        count <= val;
    end process ; -- brojanje
end brbeh ; -- brbeh

library ieee;
use ieee.std_logic_1164.all;
entity cu is
    generic(
        nc:integer:=4;
        nz:integer:=4
    );
    port(
        clk,rst:in std_logic;
        cnt1:in integer range 0 to nc-1;
        cnt2:in integer range 0 to nz-1;
        en1,en2,rst1,rst2:out std_logic;
        s:out std_logic
    );
end entity cu;
architecture cubeh of cu is
    type states is (crveno,zeleno);
    signal current_state,next_state:states;
    signal en1a,en2a,rst1a,rst2a,sa:std_logic;
begin
    stateChange : process( clk )
    begin
        if clk'event and clk='1' then
            if rst='1' then
                current_state<=crveno;
            else
                current_state<=next_state;
                en1<=en1a;
                en2<=en2a;
                rst1<=rst1a;
                rst2<=rst2a;
                s<=sa;
            end if;
        end if;
    end process ; -- stateChange
    calculation : process( current_state,cnt1,cnt2 )
    begin
        case current_state is 
            when crveno=>
                en1a<='1';
                rst1a<='0';
                rst2a<='1';
                sa<='0';
                if cnt1=nc-1 then
                    next_state<=zeleno;
                end if;
            when zeleno=>
                en2a<='1';
                rst2a<='0';
                rst1a<='1';
                sa<='1';
                if cnt2=nz-1 then
                    next_state<=crveno;
                end if;
        end case;           
    end process ; -- calculation
end cubeh ; -- cubeh

library ieee;
use ieee.std_logic_1164.all;
entity semafor is
    generic(
        nc:integer:=4;
        nz:integer:=4
    );
    port(
        clk,rst:in std_logic;
        svetlo:out std_logic
    );
end entity semafor;
architecture  sembeh of semafor is
    signal count1, count2:integer;
    signal rst1,rst2,en1,en2:std_logic;
begin
    br1:entity work.brojac(brbeh)
    generic map(n=>nc)
    port map(
        clk=>clk,rst=>rst1,en=>en1,count=>count1
    );
    br2:entity work.brojac(brbeh)
    generic map(n=>nz)
    port map(
        clk=>clk,rst=>rst2,en=>en2,count=>count2
    );
    cunit:entity work.cu(cubeh)
    generic map(
        nc=>nc,nz=>nz
    )
    port map(
        clk=>clk,rst=>rst,cnt1=>count1,cnt2=>count2,
        rst1=>rst1,rst2=>rst2,en1=>en1,en2=>en2,s=>svetlo
    );
end architecture sembeh;



library ieee;
use ieee.std_logic_1164.all;
entity testbench is
    generic(
        nc:integer:=3;
        nz:integer:=2
    );
end entity testbench;
architecture testbench of testbench is
    signal clk,rst: std_logic;
    signal svetlo: std_logic;
begin
    clk_gen:process
    begin
        clk<='1';
        wait for 100ns;
        clk<='0';
        wait for 100ns;
    end process;

    uut:entity work.semafor(sembeh)
    generic map(nc=>nc,nz=>nz)
    port map(clk=>clk,rst=>rst,svetlo=>svetlo);

    process
    begin
        rst<='1';
        wait for 300ns;
        rst<='0';
        wait for 7000ns;

    end process;
end testbench ; 