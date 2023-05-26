package my_types_pkg is
    type nizbrojeva is array (natural range <>) of integer range 0 to 255;
  end package;
  
  library ieee;
  use ieee.std_logic_1164.all;
  entity spec_reg is
      port(
          din:in integer range 0 to 255;
          clk,rst,enable:in std_logic;
          dout,valueout:out integer range 0 to 255;
          enablenext:out std_logic
      );
  end entity spec_reg;
  architecture regbeh of spec_reg is
      begin
          process(clk)
          variable regval,prevval:integer range 0 to 255;
          begin
              if(clk'event and clk='1') then
                  if(rst='1') then
                      regval:=0;
                      prevval:=0;
                      enablenext<='0';
                  elsif(enable ='1') then
                      if(regval=0) then
                          regval:=din;
                          enablenext<='0';
                      elsif (din>regval) then
                          prevval:=regval;
                          regval:=din;
                          dout<=prevval;
                          enablenext<='1';
                      else
                          dout<=din;
                          enablenext<='1';
                      end if;
                  else 
                      enablenext<='0';
                  end if;
              end if;
              valueout<=regval;
          end process;
  end architecture regbeh;
  
  library ieee;
  use ieee.std_logic_1164.all;
  entity brojac is
      generic(gornja_granica:integer := 127);
      port (
          en,clk,rst:in std_logic;
          overflow:out std_logic
          --outval:out integer
      );
  end entity brojac;
  architecture brbeh of brojac is
      begin
          process(clk)
          variable value:integer range 0 to gornja_granica;
          begin
              if clk'event and clk='1' then
                  if rst='1' then
                      value:=0;
                      overflow<='0';
                  elsif en='1' then
                      if value=gornja_granica then
                          overflow<='1';
                      else
                          value:=value+1;
                          overflow<='0';
                      end if;
                  end if;
              end if;
          end process;
  end architecture brbeh;
  
  library ieee;
  use ieee.std_logic_1164.all;
  use work.my_types_pkg.all;
  entity uredjivac is
      generic (n:integer:=8);
      port(
          clk,rst,enable:in std_logic;
          din:in integer range 0 to 255;
          doutparallel:out nizbrojeva(n-1 downto 0);
          dout:out integer range 0 to 255
      );
  end entity uredjivac;
  architecture sortbeh of uredjivac is 
  signal medjuveze:nizbrojeva(n-1 downto 0);
  signal medjuvezenext:std_logic_vector(n-1 downto 0);
  signal overflow:std_logic;
  begin
      medjuveze(n-1)<=din;
      --medjuvezenext(n-1)<=enable;
      doutparallel(0)<=medjuveze(0);
      
      sortkolo:for i in n-2 downto 0 generate
      begin
          sreg:entity work.spec_reg(regbeh)
          port map(
              din=>medjuveze(i+1),
              clk=>clk,
              rst=>rst,
              enable=>medjuvezenext(i+1),
              dout=>medjuveze(i),
              enablenext=>medjuvezenext(i),
              valueout=>doutparallel(i+1)
          );
      end generate;
  
      cnt:entity work.brojac(brbeh)
      generic map(gornja_granica=>n)
      port map(
          en=>enable,
          clk=>clk,
          rst=>rst,
          overflow=>overflow
      );
  
      process(clk,overflow)
      begin
          if(overflow='1') then
              medjuvezenext(n-1)<='0';
              dout<=din;
          else
              medjuvezenext(n-1)<=enable;
          end if;
      end process;
  
  end architecture sortbeh;

  

  -- Code your testbench here
library IEEE;
use IEEE.std_logic_1164.all;
use work.my_types_pkg.all;
entity testbench is
end entity testbench;
architecture testbench of testbench is
    signal clk,rst,enable: std_logic;
    signal din: integer range 0 to 255;
    signal doutparallel: nizbrojeva(7 downto 0);
    signal dout: integer range 0 to 255;
    begin
        uut:entity work.uredjivac(sortbeh)
        generic map(n=>8)
        port map(
            clk=>clk,rst=>rst,enable=>enable,
            din=>din,dout=>dout,
            doutparallel=>doutparallel
        );

        process
        begin
            clk<='1';
            wait for 10 ns;
            clk<='0';
            wait for 10 ns;
        end process;

        process
        begin
            rst<='1';
            wait for 30 ns;
            rst<='0';
            enable<='1';
            din<=4;
            wait for 21ns;
            din<=8;
            wait for 21ns;
            din<=1;
            wait for 21ns;
            din<=23;
            wait for 21ns;
            din<=7;
            wait for 21ns;
            din<=5;
            wait for 21ns;
            din<=59;
            wait for 21ns;
            din<=9;
            wait for 21ns;
            din<=5;
            wait for 21ns;
            din<=59;
            wait for 21ns;
            din<=9;
            wait for 21ns;
        end process;
    end architecture testbench;
