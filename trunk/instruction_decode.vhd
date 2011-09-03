library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity instruction_decode is
	port(
		clk,reset, EscrReg: in std_logic;
		Escr_reg: in std_logic_vector(4 downto 0);
		instruccion, Escr_data, sumador_in: in std_logic_vector(31 downto 0);
		dato_1,dato_2,ext_sign, sumador: out std_logic_vector(31 downto 0);
		inst20_16,inst15_11: out std_logic_vector(4 downto 0);
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

begin

banco_reg:	reg_file  port map (clk=>clk, reset=>reset, wr_en=>EscrReg, r_data1=>dato_1, r_data2=>dato_2, r_addr1=>instruccion(25 downto 21), r_addr2=>instruccion(20 downto 16), wr_addr=>Escr_reg, wr_data=>Escr_data);
control:		Control_Principal port map (instr=> instruccion (31 downto 26), control_out(1 downto 0)=>EX(1 downto 0), control_out(8)=>EX(2), control_out(7)=>EX(3), control_out(3)=>M(0), control_out(4)=>M(1), control_out(2)=>M(2), control_out(5)=>WB(0), control_out(6)=>WB(1));

ext_sign<= x"FFFF" & instruccion(15 downto 0) when instruccion(15)='1' else x"0000" & instruccion(15 downto 0);			 
inst20_16<= instruccion(20 downto 16);			 
inst15_11<= instruccion(15 downto 11);
sumador<=sumador_in;

end Behavioral;

