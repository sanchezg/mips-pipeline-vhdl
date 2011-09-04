library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Exmem is
	port(
		clk, reset:in std_logic;
		M: in std_logic_vector(2 downto 0);
		WB: in std_logic_vector(1 downto 0);
		AluResult, AluSalto, dato2: in std_logic_vector(31 downto 0);
		cero: in std_logic;
		EscrDato:in std_logic_vector(4 downto 0);
		M_out: out std_logic_vector(2 downto 0);
		WB_out: out std_logic_vector(1 downto 0);
		AluResult_out, AluSalto_out, dato2_out: out std_logic_vector(31 downto 0);
		cero_out: out std_logic;
		EscrDato_out:out std_logic_vector(4 downto 0)
	);
end Exmem;

architecture Behavioral of Exmem is
begin

process (clk, reset, m, wb, aluresult, alusalto, dato2, cero, escrdato) is
begin
	if (reset='1') then
		WB_out<="00";
		M_out<="000";
		dato2_out<=x"00000000";
		AluResult_out<=x"00000000";
		AluSalto_out<=x"00000000";
		cero_out<='0';
		EscrDato_out<="00000";	
	elsif (clk'event and clk = '1') then
		WB_out<=WB;
		M_out<=M;
		dato2_out<=dato2;
		AluResult_out<=AluResult;
		AluSalto_out<=AluSalto;
		cero_out<=cero;
		EscrDato_out<=EscrDato;
	end if;
end process;

end Behavioral;

