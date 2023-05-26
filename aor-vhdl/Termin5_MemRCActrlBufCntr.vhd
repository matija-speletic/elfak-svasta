
 --ripple carry adder
 LIBRARY IEEE;
 USE IEEE.STD_LOGIC_1164.ALL;
 USE ieee.numeric_std.ALL;
 entity RCA is
     generic (n:integer:=4);
     port(
         a,b:in std_logic_vector(n-1 downto 0);
         cin:in std_logic;
         s:out std_logic_vector(n-1 downto 0);
         cout:out std_logic
     );
 end entity RCA;
 architecture RCA_beh of RCA is 
 signal carry:std_logic_vector(n downto 0);
 begin
     carry(0)<=cin;
     adders:for i in 0 to n-1 generate
     begin
         s(i)<=a(i) xor b(i) xor carry(i);
         carry(i+1)<=(a(i) and b(i)) or (a(i) and carry(i)) or (b(i) and carry(i));
     end generate;
     cout<=carry(n);
 end architecture RCA_beh;
 
 
 --D flip-flop
 LIBRARY IEEE;
 USE IEEE.STD_LOGIC_1164.ALL;
 USE ieee.numeric_std.ALL;
 entity Dff is
     port(
         d,clk:in std_logic;
         q:out std_logic
     );
 end entity Dff;
 architecture Dff_beh of Dff is
     begin
         state_change:process(clk)
         begin
             if (clk'event and clk='1') then
                 q<=d;
             end if;
         end process;
 end architecture Dff_beh;
 
 
 --trostaticki bafer
 LIBRARY IEEE;
 USE IEEE.STD_LOGIC_1164.ALL;
 USE ieee.numeric_std.ALL;
 entity tristate_buffer is
     port(
         a, en:in std_logic;
         y:out std_logic
     );
 end entity tristate_buffer;
 architecture ts_buf_beh of tristate_buffer is
     begin
         y<=a when en='1' else 'Z';
 end architecture ts_buf_beh;
 
 
 --prihvatni registri
 LIBRARY IEEE;
 USE IEEE.STD_LOGIC_1164.ALL;
 USE ieee.numeric_std.ALL;
 entity buffer_ts is
     generic(n:integer:=4);
     port(
         clk, en:in std_logic;
         data_in:in std_logic_vector(n-1 downto 0);
         data_out:out std_logic_vector(n-1 downto 0)
     );
 end entity buffer_ts;
 architecture buffer_beh of buffer_ts is
 begin
     registers:for i in data_in'range generate
     signal data_unbuf:std_logic;
     begin
         single_reg:entity work.Dff(Dff_beh)
         port map(
             d=>data_in(i),
             clk=>clk,
             q=>data_unbuf
         );
         reg_buffer:entity work.tristate_buffer(ts_buf_beh)
         port map(
             a=>data_unbuf,
             en=>en,
             y=>data_out(i)
         );
     end generate registers;
 end architecture buffer_beh;
 
 
 --memorija
 LIBRARY IEEE;
 USE IEEE.STD_LOGIC_1164.ALL;
 USE ieee.numeric_std.ALL;
 entity Memory is
     generic(
         n:integer:=8;--malo varijacija, n je sirina adrese
         m:integer:=8 --sirina memorijske reci
     );
     port(
         clk, we:in std_logic;
         addr:in std_logic_vector(n-1 downto 0);
         data_in:in std_logic_vector(m-1 downto 0);
         data_out:out std_logic_vector(m-1 downto 0)
     );
 end entity Memory;
 architecture mem_beh of Memory is
     type mem_type is array (2**n-1 downto 0) of std_logic_vector(m-1 downto 0);
     signal ram_mem:mem_type;
     begin
         process(clk)
         variable addr_temp:integer ;
         begin
             if (clk'event and clk='1') then
                 addr_temp:=to_integer(unsigned(addr));
                 if we='1' then
                     ram_mem(addr_temp)<=data_in;
                 end if;
                 data_out<=ram_mem(addr_temp);
             end if;
         end process;
 end architecture mem_beh;
 
 
 --n-bitni brojac
 LIBRARY IEEE;
 USE IEEE.STD_LOGIC_1164.ALL;
 USE ieee.numeric_std.ALL;
 entity counter is
     generic (n:integer:=8); --koliko bitova ima 
     port(
         clk,rst,ce,ld,dir:in std_logic;
         din:in integer ;
         count :out integer 
     );
 end entity counter;
 architecture counter_beh of counter is
     begin
         process(clk)
         variable cnt:integer ;
         begin
             if rst='0' then 
                 cnt:=0; 
             elsif clk'event and clk='1' then
                 if ld='1' then 
                     cnt:=din;
                 else 
                     if ce='1' then
                         if dir ='1' then
                             cnt:=(cnt+1) mod 2**n;
                         else 
                             cnt:=(cnt-1) mod 2**n;
                         end if;
                     end if;
                 end if;
             end if;
             count<=cnt;
         end process;
 end architecture counter_beh;
 
 
 --kontrolna jedinica
 LIBRARY IEEE;
 USE IEEE.STD_LOGIC_1164.ALL;
 USE ieee.numeric_std.ALL;
 entity control_unit is
     port(
         clk,we,reset:in std_logic;
         --addr:in std_logic_vector(7 downto 0);
         rstAddr:out std_logic;
         upis1:out std_logic;
         upis2:out std_logic
     );
 end entity control_unit;
 architecture cu_beh of control_unit is
     type states is (sWrite, sRead1, sRead2, sStart);
     signal current_state, next_state:states;
     signal upis1_cn, upis2_cn:std_logic;
     begin
         stateChange:process(clk, reset)
         begin
             if reset='1' then
                 current_state<=sStart;
             elsif clk'event and clk='1' then
                 upis1<=upis1_cn;
                 upis2<=upis2_cn;
                 current_state<=next_state;
             end if;
         end  process;
         OutputAndStateCalculation:process(we,current_state)
         begin
             case current_state is
                 when sStart=>
                     rstAddr<='1';
                     upis1_cn<='0';
                     upis2_cn<='0';
                     if we='1' then 
                         next_state<=sWrite;
                     elsif we='0' then
                         next_state<=sRead1;
                     end if;
                 when sWrite=>
                     rstAddr<='0';
                     upis1_cn<='0';
                     upis2_cn<='0';
                     if we='1' then
                         next_state<=sWrite;
                     elsif we='0' then
                         next_state<=sStart;
                     end if;
                 when sRead1=>
                     rstAddr<='0';
                     upis1_cn<='1';
                     upis2_cn<='0';
                     if we='0' then
                         next_state<=sRead2;
                     elsif we='1' then
                         next_state<=sStart;
                     end if;
                 when sRead2=>
                     rstAddr<='0';
                     upis1_cn<='0';
                     upis2_cn<='1';
                     if we='0' then
                         next_state<=sRead1;
                     elsif we='1' then
                         next_state<=sStart;
                     end if;
             end case;
         end process;
 end architecture cu_beh;
 
 
 LIBRARY IEEE;
 USE IEEE.STD_LOGIC_1164.ALL;
 USE ieee.numeric_std.ALL;
 --KONACNO sama komponenta
 entity sistem is
     generic(
         sirina_reci:integer:=8;
         mem_kap:integer:=10 --1024
     );
     port (
         we, clk, rst:std_logic;
         din:in std_logic_vector(sirina_reci-1 downto 0);
         dout:out std_logic_vector(sirina_reci downto 0)
     );
 end entity sistem;
 architecture beh of sistem is
     signal addr:std_logic_vector(mem_kap-1 downto 0);
     signal data_int,op1,op2:std_logic_vector(sirina_reci-1 downto 0);
     signal addrInt:integer;
     signal rstAddr,upis1,upis2:std_logic;
     begin
         cu:entity work.control_unit(cu_beh)
         port map(
             clk=>clk,
             rstAddr=>rstAddr,
             upis1=>upis1,
             upis2=>upis2,
             we=>we,
             reset=>rst
         );
         cnt:entity work.counter(counter_beh)
         generic map(
             n=>mem_kap
         )
         port map(
             clk=>clk,
             rst=>rstAddr,
             ce=>'1',
             ld=>'0',
             dir=>'1',
             din=> 0,
             count=>addrInt
         );
         addr<=std_logic_vector(to_unsigned(addrInt,mem_kap));
         mem:entity work.Memory(mem_beh)
         generic map(
             n=>mem_kap,
             m=>sirina_reci
         )
         port map(
             clk=>clk,
             we=>we,
             data_in=>din,
             data_out=>data_int,
             addr=>addr
         );
         buff1:entity work.buffer_ts(buffer_beh)
         generic map(n=>sirina_reci)
         port map(
             clk=>upis1,
             en=>'1',
             data_in=>data_int,
             data_out=>op1
         );
         buff2:entity work.buffer_ts(buffer_beh)
         generic map(n=>sirina_reci)
         port map(
             clk=>upis2,
             en=>'1',
             data_in=>data_int,
             data_out=>op2
         );
         sabirac:entity work.RCA(RCA_beh)
         generic map(n=>sirina_reci)
         port map(
             a=>op1,
             b=>op2,
             cin=>'0',
             s=>dout(sirina_reci-1 downto 0),
             cout=>dout(sirina_reci)
         );
 end architecture beh;

 




 LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE ieee.numeric_std.ALL;

--testbench
entity testbench is
    end entity testbench;
    
    architecture testbench of testbench is
        signal we,rst:std_logic;
        signal din:std_logic_vector(7 downto 0);
        signal dout:std_logic_vector(8 downto 0);
        signal clock:std_logic := '0';
        constant T:time:=1ns;
        begin
            uut1:entity work.sistem(beh)
            generic map(
                sirina_reci=>8,
                mem_kap=>10
            )
            port map(
                we=>we,
                clk=>clock,
                din=>din,
                dout=>dout,
                rst=>rst
            );
            clk_gen:process is
                begin
                    clock<='0';
                    wait for T;
                    clock<='1';
                    wait for T;
            end process clk_gen;
            pobuda:process is
                begin
                    rst<='1';
                    wait for 3ns;
                    rst<='0';
                    we<='1';
                    din<="00000000";
                    wait for 2.2ns;
                    din<="00000101";
                    wait for 2.2ns;
                    din<="10100000";
                    wait for 2.2ns;
                    din<="10100101";
                    wait for 2.2ns;
                    we<='0';
                    wait for 15ns;
            end process pobuda;
        end architecture testbench;
    