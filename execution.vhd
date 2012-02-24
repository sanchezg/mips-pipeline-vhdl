library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity execution is
	port(
		dato1,dato2,ext_sig,sumador, res_anticipado1, res_anticipado2: in std_logic_vector(31 downto 0);
		inst1511, inst2016, inst2521, ExMemRd, MemWbRd : in std_logic_vector(4 downto 0);
		EX: in std_logic_vector(3 downto 0);
		M: in std_logic_vector(2 downto 0);
		WB: in std_logic_vector(1 downto 0);
		clk,reset,EscrReg_ExMem_in, EscrReg_MemWb_in: in std_logic;
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


component mux_3x32 is
	port(x,y,z : in std_logic_vector(31 downto 0);
	     sel : in std_logic_vector(1 downto 0);
	     salida : out std_logic_vector(31 downto 0)
   );	  
end component mux_3x32;

component ANTICIPACION is
port(Rt,Rs : in std_logic_vector(4 downto 0);
	  EX_MEM_Rd,MEM_WB_Rd : in std_logic_vector(4 downto 0);
	  EscrReg_ExMem, EscrReg_MemWb: in std_logic;
	  Out_A, Out_B : out std_logic_vector(1 downto 0)
);	  
end component ANTICIPACION;


signal mux0_aux, desplazam,alu_in_A, alu_in_B: std_logic_vector(31 downto 0);
signal aluop_aux: std_logic_vector(2 downto 0);
signal ant_A, ant_B: std_logic_vector(1 downto 0);

begin

desplazam <= ext_sig(29 downto 0) & "00";

alu:			alu_32b	port map(x=>alu_in_A, y=>alu_in_B, op=>aluop_aux, result=>alu_result, carry=>open, zero=>cero );--Modificado
alu_salto:	alu_32b	port map(x=>sumador, y=>desplazam, op=>"010", result=>alusalto_result, carry=>open, zero=>open );--Hay q sacarla
mux0:			mux_2x32	port map(x=>dato2, y=>ext_sig, sel=>EX(3), salida=>mux0_aux );--sacar
alu_cont:	Control_ALU	port map(func=>ext_sig(5 downto 0), aluop=>EX(1 downto 0), alu_op=>aluop_aux );
mux1:			mux_2x5	port map (x=>inst2016, y=>inst1511, sel=>EX(2), salida=>EscrDatos);
mux_AntA:	mux_3x32 port map(x=>dato1, y=>res_anticipado1, z=>res_anticipado2, salida=>alu_in_A, sel=>ant_A);
mux_AntB:	mux_3x32 port map (x=>mux0_aux, y=>res_anticipado1, z=>res_anticipado2, salida=>alu_in_B, sel=>ant_B);
--mux2:			mux_2x32 port map (x=>dato2);
unid_ant:	ANTICIPACION port map (Out_A=>ant_A,
											  Out_B=>ant_B,
											  Rt=>inst2016,
											  Rs=>inst2521,
											  EX_MEM_Rd=>ExMemRd,
											  MEM_WB_Rd=>MemWbRd,
											  EscrReg_ExMem=>EscrReg_ExMem_in,
											  EscrReg_MemWb=>EscrReg_MemWb_in);



--señales directas
WB_out <= WB;
m_out <= m;
dato2_out <= dato2;

end Behavioral;

