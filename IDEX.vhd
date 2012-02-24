library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity IDEX is
	port(
		clk, reset:in std_logic;
		WB:in std_logic_vector(1 downto 0);
		M:in std_logic_vector(2 downto 0);
		EX:  in std_logic_vector(3 downto 0);
		sum_in,dato_1,dato_2,ext_sig: in std_logic_vector(31 downto 0);
		inst2016,inst1511,inst2521: in std_logic_vector (4 downto 0);
		WB_out:out std_logic_vector(1 downto 0);
		M_out:out std_logic_vector(2 downto 0);
		EX_out:out std_logic_vector(3 downto 0);
		sum_out,dato_1_out,dato_2_out,ext_sig_out: out std_logic_vector(31 downto 0);
		inst2016_out,inst1511_out,inst2521_out:out std_logic_vector (4 downto 0)
	);	  
end IDEX;

architecture Behavioral of IDEX is

begin

process (clk, reset, wb, m, ex, sum_in, dato_1, dato_2, ext_sig) is
begin
	if (reset='1') then
		--salidas a cero
		WB_out <= "00";
		M_out <= "000";
		EX_out <= "0000";
		sum_out <= x"00000000";
		dato_1_out <= x"00000000";
		dato_2_out <= x"00000000";
		ext_sig_out <= x"00000000";
		inst2016_out <= "00000";
		inst1511_out <= "00000";
	elsif (clk'event and clk = '1') then
		WB_out<=WB;
		M_out<=M;
		EX_out<=EX;
		sum_out<=sum_in;
		dato_1_out<=dato_1;
		dato_2_out<=dato_2;
		ext_sig_out<=ext_sig;
		inst2016_out<=inst2016;
		inst1511_out<=inst1511;
		inst2521_out<=inst2521;
	end if;
end process;

end Behavioral;