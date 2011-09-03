library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity writeback is
	port(
		WB:in std_logic_vector(1 downto 0);
		Dato_leido, AluResult: in std_logic_vector(31 downto 0);
		EscDato: in std_logic_vector(4 downto 0);
		EscDato_out:out std_logic_vector(4 downto 0);
		Mux_out: out std_logic_vector(31 downto 0);
		EscrReg:out std_logic
	);
end writeback;

architecture Behavioral of writeback is

component mux_2x32 is
	port(
		x,y : in std_logic_vector(31 downto 0);
		sel : in std_logic;
		salida : out std_logic_vector(31 downto 0)
	);	  
end component mux_2x32;

begin

EscDato_out<=EscDato;
EscrReg<=WB(0);

mux: mux_2x32 port map(x=>Dato_leido, y=>AluResult, sel=>WB(1), salida=>Mux_out);

end Behavioral;