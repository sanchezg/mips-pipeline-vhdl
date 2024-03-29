-- Memoria 256x32bit
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_ARITH.all;
use IEEE.std_logic_unsigned.all;
--
--entity memoria is
--  port( rst, clk, rd, wr : in  std_logic;
--    addr, in_data  : in  std_logic_vector (31 downto 0);
--    out_data : out std_logic_vector (31 downto 0));
--end memoria;

entity memoria is
  port(
    rst      : in  std_logic;
    clk      : in  std_logic;
    rd       : in  std_logic;
    wr       : in  std_logic;
    addr     : in  std_logic_vector (31 downto 0);
    in_data  : in  std_logic_vector (31 downto 0);
    out_data : out std_logic_vector (31 downto 0));
end memoria;


architecture bhv of memoria is
  type MEM_TYPE is array (0 to 255) of std_logic_vector (31 downto 0);
  signal MEMORY : MEM_TYPE;
  
begin
  process( clk, rst )
  begin
    if ( rst = '1') then
      for i in 0 to 255 loop
        MEMORY(i) <= "00000000000000000000000000000000";
      end loop;

--		MEMORY(0) <= "10001100000010100000000000000000";     -- lw r10, 0(r0)
--		MEMORY(1) <= "10001100000010110000000000000100";     -- lw r11, 32(r0)    
--		MEMORY(2) <= "00000001010010110101100000100000";     -- add r11, r11, r10 // r11=r11+r10
--		--MEMORY(3) <= "101011"		--sw r12, r11(0) // r12=memoria(r11+0)

--	  lw $10,0($1)
--   lw $11,0($2)
--	  and $12,$4,$5
--	  sub $12,$10,$11

--	  or	$13,$6,$7
--	  add $14,$8,$9
--   jmp (0)
		--										e
		MEMORY(0) <= "10001100000010100000000000000000";--
		MEMORY(1) <= "10001100000010110000000000000100";--
		--MEMORY(2) <= "10001100000011000000000000001000";--
		
		
		MEMORY(2) <= "00000100010010110110100000100000";--and
		--MEMORY(2) <= "00000100010000010111000000100101";--or
		
		MEMORY(3) <= "00000101101011100111100000100000";--add
		
		--MEMORY(5) <= "00000001101001000111100000100100";--and
		--MEMORY(6) <= "00000001101011100111100000100010";--resta
		
		
		
		--MEMORY(5) <= "00000001000010010111000000100000";
		--MEMORY(5) <= "00001000000000000000000000000000";
		
		
    elsif (clk'event and clk = '1') then
      if (conv_integer("00" & addr (7 downto 2)) < 255) then
        if (wr = '1') then
          MEMORY(conv_integer("00" & addr (7 downto 2))) <= in_data;
        end if;
      end if;
    end if;    
  end process;

  process (rst, rd, addr)
  begin
    if (rst = '1') then
      out_data <= "00000000000000000000000000000000";
    elsif (rd = '1' and conv_integer("00" & addr (7 downto 2)) < 255) then
      out_data <= MEMORY(conv_integer("00" & addr (7 downto 2)));
    end if;
  end process;
  
end bhv;