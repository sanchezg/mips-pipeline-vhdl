library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity execution is
	port(
		dato1,dato2,ext_sig,sumador: in std_logic_vector(31 downto 0);
		inst1511, inst2016 : in std_logic_vector(4 downto 0);
		EX: in std_logic_vector(3 downto 0);
		M: in std_logic_vector(2 downto 0);
		WB: in std_logic_vector(1 downto 0);
		M_out:out std_logic_vector(2 downto 0);
		WB_out:out std_logic_vector(1 downto 0);
		alu_result,alusalto_result,dato2_out: out std_logic_vector(31 downto 0);
		cero:out std_logic;
		EscrDatos: out std_logic_vector(4 downto 0)
	);
end execution;

architecture Behavioral of execution is

component alu_32b is
	Port(
		x, y : in  STD_LOGIC_VECTOR (31 downto 0);
		op : in  STD_LOGIC_VECTOR (2 downto 0);
		result : out  STD_LOGIC_VECTOR (31 downto 0);
		carry, zero: out std_logic 
	);
end component alu_32b;

component Control_Alu is
	port (
		func: in std_logic_vector (5 downto 0);
		Aluop : in std_logic_vector (1 downto 0);
		alu_op : out std_logic_vector (2 downto 0)
	);
end component Control_ALU;

component mux_2x32 is
	port(
		x,y : in std_logic_vector(31 downto 0);
		sel : in std_logic;
		salida : out std_logic_vector(31 downto 0)
	);
end component mux_2x32;

component mux_2x5 is
	port(
		x,y: in std_logic_vector(4 downto 0);
		sel: in std_logic;
		salida: out std_logic_vector(4 downto 0)
	);
end component mux_2x5;

signal mux0_aux, desplazam: std_logic_vector(31 downto 0);
signal aluop_aux: std_logic_vector(2 downto 0);

begin

desplazam <= ext_sig(29 downto 0) & "00";

alu:			alu_32b	port map(x=>dato1, y=>mux0_aux, op=>aluop_aux, result=>alu_result, carry=>open, zero=>cero );
alu_salto:	alu_32b	port map(x=>sumador, y=>desplazam, op=>"010", result=>alusalto_result, carry=>open, zero=>open );
mux0:			mux_2x32	port map(x=>dato2, y=>ext_sig, sel=>EX(3), salida=>mux0_aux );
alu_cont:	Control_ALU	port map(func=>ext_sig(5 downto 0), aluop=>EX(1 downto 0), alu_op=>aluop_aux );
mux1:			mux_2x5	port map (x=>inst2016, y=>inst1511, sel=>EX(2), salida=>EscrDatos);

end Behavioral;

