library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity instruction_decode is
	port(
		clk,reset, EscrReg: in std_logic;
		Escr_reg: in std_logic_vector(4 downto 0);
		IDEXLeerMem: in std_logic;
		IDEX_RT: in std_logic_vector(4 downto 0);
		Escr_IFID,Escr_PC: out std_logic;
		instruccion, Escr_data, sumador_in: in std_logic_vector(31 downto 0);
		dato_1,dato_2,ext_sign, sumador: out std_logic_vector(31 downto 0);
		inst20_16,inst15_11, inst25_21: out std_logic_vector(4 downto 0);
		EX: out std_logic_vector(3 downto 0);
		M: out std_logic_vector(2 downto 0);
		WB: out std_logic_vector(1 downto 0)
		);
end instruction_decode;

architecture Behavioral of instruction_decode is

--Banco de registros
component reg_file is
	port (
		clk, reset, wr_en: in std_logic;
		wr_addr, r_addr1, r_addr2: in std_logic_vector (4 downto  0);
		wr_data: in std_logic_vector(31 downto  0);
		r_data1, r_data2 : out std_logic_vector(31 downto  0)
	);
end component;

--Control Principal
Component Control_Principal is
	port (
       control_out : out std_logic_vector (8 downto 0);
		--control_out(0) -> AluOp (0) 
		--control_out(1) -> AluOp (1)
		--control_out(2) -> SaltoCond 
		--control_out(3) -> EscMem
		--control_out(4) -> LeerMem 
		--control_out(5) -> EscReg
		--control_out(6) -> MemaReg 
		--control_out(7) -> Fuente Alu
		--control_out(8) -> RegDest		
		 instr : in std_logic_vector (5 downto 0)
		 );
end component;


--Unidad de deteccion de riesgos
component Unidad_Deteccion_Riesgos is
	port(Rt_IFID,Rs_IFID, Rt_IDEX: in std_logic_vector(4 downto 0);
		  LeerMem: in std_logic;
		  EscrPc,EscrIFID, Salida_mux: out std_logic	
		);
end component Unidad_Deteccion_Riesgos;



--Multiplexor
component mux_2x9 is
	port(
		x,y: in std_logic_vector(8 downto 0);
		sel: in std_logic;
		salida: out std_logic_vector(8 downto 0)
	);
end component mux_2x9;

--señales auxiliares
signal mux_out,cont_out: std_logic_vector(8 downto 0);
signal mux_sel: std_logic;
begin

banco_reg:	reg_file  port map (clk=>clk,
										  reset=>reset,
										  wr_en=>EscrReg,
										  r_data1=>dato_1,
										  r_data2=>dato_2,
										  r_addr1=>instruccion(25 downto 21),
										  r_addr2=>instruccion(20 downto 16),
										  wr_addr=>Escr_reg,
										  wr_data=>Escr_data);


control:		Control_Principal port map (instr=> instruccion (31 downto 26),
													control_out=>cont_out);
										
													
mux:		mux_2x9 port map (x=>cont_out,
									y=>"000000000",
									sel=>mux_sel, 	
									salida(1 downto 0)=>EX(1 downto 0),
									salida(8)=>EX(2),
									salida(7)=>EX(3),
									salida(3)=>M(0),
									salida(4)=>M(1),
									salida(2)=>M(2),
									salida(5)=>WB(0),
									salida(6)=>WB(1));

unidad_detec:	Unidad_Deteccion_Riesgos port map (Rt_IFID=>instruccion(20 downto 16),
																  Rs_IFID=>instruccion(25 downto 21),
																  Rt_IDEX=>IDEX_RT,
																  LeerMem=>IDEXLeerMem,
																  EscrPc=>Escr_PC,
																  EscrIFID=>Escr_IFID,
																  Salida_mux=>mux_sel);									
		
ext_sign<= x"FFFF" & instruccion(15 downto 0) when instruccion(15)='1' else x"0000" & instruccion(15 downto 0);			 
inst20_16<= instruccion(20 downto 16);			 
inst15_11<= instruccion(15 downto 11);
inst25_21<= instruccion(25 downto 21);
sumador<=sumador_in;

end Behavioral;

