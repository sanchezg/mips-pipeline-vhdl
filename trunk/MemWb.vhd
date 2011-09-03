library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity MemWb is
	port(
		clk, reset: in std_logic;
		WB:in std_logic_vector(1 downto 0);
		dato_leido, AluResult: in std_logic_vector(31 downto 0);
		EscrDato: in std_logic_vector(4 downto 0);
		WB_out:out std_logic_vector(1 downto 0);
		dato_leido_out, AluResult_out: out std_logic_vector(31 downto 0);
		EscrDato_out: out std_logic_vector(4 downto 0)
	);
end MemWb;

architecture Behavioral of MemWb is

begin
process (clk, reset, wb, dato_leido, aluresult, escrdato) is
begin
	if (reset='1') then
		WB_out<="00";
		dato_leido_out<=x"0000";
		AluResult_out<=x"0000";
		EscrDato_out<="00000";
	elsif (clk'event and clk = '1') then
		WB_out<=WB;
		dato_leido_out<=dato_leido;
		AluResult_out<=AluResult;
		EscrDato_out<=EscrDato;
	end if;
end process;

end Behavioral;