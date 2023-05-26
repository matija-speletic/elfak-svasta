library ieee;
use ieee.std_logic_1164.all;
use numeric_std.all;
entity bcd2cif is
  port (
    clk,rst,en:in std_logic;
    count : out std_logic_vector(7 downto 0)
  ) ;
end bcd2cif;
architecture bcdbeh of bcd2cif is
    signal msd,lsd:unsigned(3 downto 0);
begin
    brojanje : process( clk )
    begin
        if clk'event and clk='1' then
            if rst='1' then
                msd<="0000";
                lsd<="0000";
            elsif en='1' then
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

entity testbench is
end entity testbench;
architecture testbench of testbench is

    signal clk,en,rst:std_logic;
    signal count:std_logic_vector(7 downto 0);

begin
    clk_gen:process
    begin
        clk<='1';
        wait for 10ns;
        clk<='0';
        wait for 10ns;
    end process;

    bro:entity work.bcd2cif(bcdbeh)
    port map(
        clk=>clk,rst=>rst,en=>en,count=>count
    );

    process
    begin
        rst<='1';
        wait for 30ns;
        rst<='0';
        en<='1';
        wait for 1100ns;
        en<='0';
        wait for 50ns;
        rst<='1';
        en<='1';
        wait for 30ns;
        rst<='0';
        wait for 200ns;
    end process;

end testbench ; -- testbench