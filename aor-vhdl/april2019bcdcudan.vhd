library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity bcd is
  port (
    clk,en:in std_logic;
    din:in std_logic_vector(3 downto 0);
    val : out std_logic_vector(3 downto 0)
  ) ;
end bcd;
architecture bcdbeh of bcd is
begin
    counting : process( clk )
    variable count:unsigned(3 downto 0);
    variable dir:std_logic;
    begin
        if clk'event and clk='1' then
            if en='1' then
                if unsigned(din)>"1001" then
                    count:="0000";
                else
                    count:=unsigned(din);
                end if;
                dir:='0';
            else
                if count="1001" then
                    dir:='1';
                elsif count="0000" then
                    dir:='0';
                end if;
                if dir='0' then
                    count := count + "0001";
                else
                    count := count - "0001";
                end if;
            end if;
            val<=std_logic_vector(count);
        end if;
    end process ; -- counting
end bcdbeh ; -- bcdbeh

library IEEE;
use IEEE.std_logic_1164.all;
entity bcdmodif is
  port (
    clk,rst:in std_logic;
    val:out std_logic_vector(3 downto 0)
  ) ;
end bcdmodif;
architecture bcdmodifbeh of bcdmodif is
    signal rc:std_logic;
begin
    rc<= not rst;--reset complement
    cnt:entity work.bcd(bcdbeh)
    port map(
        clk=>clk,en=>rst,din=>rc&rc&rc&rc,val=>val
    );
end bcdmodifbeh ; -- bcdmodifbeh




-- Code your testbench here
library IEEE;
use IEEE.std_logic_1164.all;
entity testbench is
end entity testbench;
architecture testbench of testbench is

    signal clk,rst:std_logic;
    signal count:std_logic_vector(3 downto 0);

begin
    clk_gen:process
    begin
        clk<='1';
        wait for 10ns;
        clk<='0';
        wait for 10ns;
    end process;

    bro:entity work.bcdmodif(bcdmodifbeh)
    port map(
        clk=>clk,rst=>rst,val=>count
    );

    process
    begin
        rst<='1';
        wait for 30ns;
        rst<='0';
        wait for 780ns;
    end process;

end testbench ; -- testbench

library IEEE;
use IEEE.std_logic_1164.all;
architecture testbench2 of testbench is

    signal clk,en:std_logic;
    signal count,din:std_logic_vector(3 downto 0);

begin
    clk_gen:process
    begin
        clk<='1';
        wait for 10ns;
        clk<='0';
        wait for 10ns;
    end process;

    bro:entity work.bcd(bcdbeh)
    port map(
        clk=>clk,en=>en,val=>count,din=>din
    );

    process
    begin
        din<="0000";
        en<='1';
        wait for 30ns;
        en<='0';
        wait for 700ns;
        din<="0101";
        en<='1';
        wait for 30ns;
        en<='0';
        wait for 700ns;
        din<="1001";
        en<='1';
        wait for 30ns;
        en<='0';
        wait for 700ns;
        din<="1101";
        en<='1';
        wait for 30ns;
        en<='0';
        wait for 700ns;
    end process;

end testbench2 ; -- testbench2
