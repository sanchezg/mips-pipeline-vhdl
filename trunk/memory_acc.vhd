library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity memory_acc is
	port(
		rst:in std_logic;
		clk:in std_logic;
		M: in std_logic_vector(2 downto 0);
		WB: in std_logic_vector(1 downto 0);
		AluResult, AluSalto, dato2: in std_logic_vector(31 downto 0);
		cero: in std_logic;
		EscrDato:in std_logic_vector(4 downto 0);
		Dato_leido, AluResult_out: out std_logic_vector(31 downto 0);
		EscrDato_out:out std_logic_vector(4 downto 0);
		WB_out: out std_logic_vector(1 downto 0);
		FuentePc: out std_logic
	);
end memory_acc;

architecture Behavioral of memory_acc is

component memoria is
  port(
    rst      : in  std_logic;
    clk      : in  std_logic;
    rd       : in  std_logic;
    wr       : in  std_logic;
    addr     : in  std_logic_vector (31 downto 0);
    in_data  : in  std_logic_vector (31 downto 0);
    out_data : out std_logic_vector (31 downto 0));
end component memoria;


begin

FuentePC<= M(2) and cero;
WB_out<=WB;
EscrDato_out<=EscrDato;
AluResult_out<=AluSalto; --Esta señal estaba faltando

mem: memoria port map(rst=>rst, clk=>clk, rd=>M(1), wr=>M(0), addr=>AluResult, in_data=>dato2, out_data=>Dato_leido);

end Behavioral;