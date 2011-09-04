----------------------------------------------------------------------------------
--Este es el archivo principal
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity mips is
	port (
		clock, reset: in std_logic;
		control_id_ex_gral: out std_logic_vector(8 downto 0);
		salida, instruccion_gral, direccion_gral, alu_salto_gral: out std_logic_vector(31 downto 0)
	);
end mips;


----------------------------------------------------------------------------------
architecture bhv_str of mips is

component instruction_fetch is
	port (
		reset, clk, fuente_pc : in std_logic;
		alu_result :in std_logic_vector (31 downto 0);
		salida : out std_logic_vector(31 downto 0);
		salida_sum: out std_logic_vector(31 downto 0)
	);
end component instruction_fetch;

component IFID is
	port(
		mem_in, sum_in: in std_logic_vector(31 downto 0);
		mem_out, sum_out: out std_logic_vector(31 downto 0);
		clk, reset: in std_logic
	);
end component IFID;

component instruction_decode is
	port(
		clk, reset, EscrReg: in std_logic;
		Escr_reg: in std_logic_vector(4 downto 0);
		instruccion, Escr_data, sumador_in: in std_logic_vector(31 downto 0);
		dato_1,dato_2,ext_sign, sumador: out std_logic_vector(31 downto 0);
		inst20_16,inst15_11: out std_logic_vector(4 downto 0);
		EX: out std_logic_vector(3 downto 0);
		M: out std_logic_vector(2 downto 0);
		WB: out std_logic_vector(1 downto 0)
	);
end component instruction_decode;

component IDEX is
	port(
		clk, reset:in std_logic;
		WB:in std_logic_vector(1 downto 0);
		M:in std_logic_vector(2 downto 0);
		EX:  in std_logic_vector(3 downto 0);
		sum_in,dato_1,dato_2,ext_sig: in std_logic_vector(31 downto 0);
		inst2016,inst1511: in std_logic_vector (4 downto 0);
		WB_out:out std_logic_vector(1 downto 0);
		M_out:out std_logic_vector(2 downto 0);
		EX_out:out std_logic_vector(3 downto 0);
		sum_out,dato_1_out,dato_2_out,ext_sig_out: out std_logic_vector(31 downto 0);
		inst2016_out,inst1511_out:out std_logic_vector (4 downto 0)
	);	  
end component IDEX;

component execution is
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
end component execution;

component Exmem is
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
end component Exmem;

component memory_acc is
	port(
		rst:in std_logic;
		clk:in std_logic;
		M: in std_logic_vector(2 downto 0);
		WB: in std_logic_vector(1 downto 0);
		AluResult, AluSalto, dato2: in std_logic_vector(31 downto 0);
		cero: in std_logic;
		EscrDato:in std_logic_vector(4 downto 0);
		Dato_leido, AluResult_out, alusalto_out: out std_logic_vector(31 downto 0);
		EscrDato_out:out std_logic_vector(4 downto 0);
		WB_out: out std_logic_vector(1 downto 0);
		FuentePc: out std_logic
	);
end component memory_acc;

component MemWb is
	port(
		clk, reset: in std_logic;
		WB:in std_logic_vector(1 downto 0);
		dato_leido, AluResult: in std_logic_vector(31 downto 0);
		EscrDato: in std_logic_vector(4 downto 0);
		WB_out:out std_logic_vector(1 downto 0);
		dato_leido_out, AluResult_out: out std_logic_vector(31 downto 0);
		EscrDato_out: out std_logic_vector(4 downto 0)
	);
end component MemWb;

component writeback is
	port(
		WB:in std_logic_vector(1 downto 0);
		Dato_leido, AluResult: in std_logic_vector(31 downto 0);
		EscDato: in std_logic_vector(4 downto 0);
		EscDato_out:out std_logic_vector(4 downto 0);
		Mux_out: out std_logic_vector(31 downto 0);
		EscrReg:out std_logic
	);
end component writeback;

--seniales auxiliares Etapa1
signal fuente_pc_aux: std_logic;
signal alu_result_aux, salida_aux, salida_sum_aux, mem_out_aux, sum_out_aux: std_logic_vector (31 downto 0);

--seniales auxiliares Etapa2
signal escrreg_aux: std_logic;
signal escr_reg_aux, inst20_16_aux, inst15_11_aux: std_logic_vector(4 downto 0);
signal ex_aux_in, ex_aux_out: std_logic_vector(3 downto 0);
signal m_aux_in, m_aux_out: std_logic_vector(2 downto 0);
signal wb_aux_in, wb_aux_out: std_logic_vector(1 downto 0);
signal escr_data_aux, dato_1_aux, dato_2_aux, ext_sign_aux, sumador_aux: std_logic_vector(31 downto 0);
--seniales que interconectan entre IDEX y E3
signal sum_out_aux2, dato_1_out_aux, dato_2_out_aux, ext_sig_out_aux: std_logic_vector(31 downto 0);
signal inst2016_out_aux, inst1511_out_aux: std_logic_vector(4 downto 0);

--señales auxiliares Etapa3
signal alu_result2_aux, alusalto_result_aux, dato2_out_aux, dato_2_out_aux_ex: std_logic_vector(31 downto 0);
signal AluSalto_out_aux, AluResult_out_aux: std_logic_vector(31 downto 0);
signal EscrDatos_aux, EscrDato_out_aux: std_logic_vector(4 downto 0);
signal ex_aux2: std_logic_vector(3 downto 0);
signal m_aux2_in, m_aux_out_ex: std_logic_vector(2 downto 0);
signal wb_aux2_in, wb_aux_out_ex: std_logic_vector(1 downto 0);
signal cero_aux, cero_out_aux: std_logic;

--señales aux Etapa4
signal Dato_leido_aux, dato_leido_out_aux, AluResult_out_aux2,aluresult_out_aux_mem, alusalto_out_mem, alu_salto_aux: std_logic_vector(31 downto 0);
signal WB_out_aux3: std_logic_vector(1 downto 0);
signal EscrDato_out_aux2: std_logic_vector(4 downto 0);

begin

-- Etapa1->IF/ID
-- Fuente_PC_Aux deberia venir desde MEM
INST_FET: instruction_fetch port map (reset=>reset, clk=>clock, fuente_pc=>fuente_pc_aux, alu_result=>alusalto_out_mem, salida=>salida_aux, salida_sum=>salida_sum_aux);
IF_ID: ifid port map (reset=>reset, clk=>clock, mem_in=>salida_aux, sum_in=>salida_sum_aux, mem_out=>mem_out_aux, sum_out=>sum_out_aux);

-- IF/ID->Etapa2->ID/EX
-- Escr_Reg_aux y escr_data_aux vienen desde WB
INST_DEC: instruction_decode port map (clk=>clock, reset=>reset, EscrReg=>escrreg_aux, Escr_reg=>Escr_Reg_aux, instruccion=>mem_out_aux, Escr_data=>escr_data_aux, sumador_in=>sum_out_aux,
										wb=>wb_aux_in, m=>m_aux_in, ex=>ex_aux_in, dato_1=>dato_1_aux, dato_2=>dato_2_aux, ext_sign=>ext_sign_aux, sumador=>sum_out_aux, inst20_16=>inst20_16_aux, inst15_11=>inst15_11_aux);
ID_EX: idex port map (reset=>reset, clk=>clock, wb=>wb_aux_in, m=>m_aux_in, ex=>ex_aux_in, sum_in=>sum_out_aux, dato_1=>dato_1_aux, dato_2=>dato_2_aux, ext_sig=>ext_sign_aux, inst2016=>inst20_16_aux, inst1511=>inst15_11_aux,
					wb_out=>wb_aux_out, M_out=>m_aux_out, EX_out=>ex_aux_out, sum_out=>sum_out_aux2, dato_1_out=>dato_1_out_aux, dato_2_out=>dato_2_out_aux, ext_sig_out=>ext_sig_out_aux, inst2016_out=>inst2016_out_aux, inst1511_out=>inst1511_out_aux);

-- ID/EX->Etapa3->EX/MEM
-- Hay que ver me parece que a esta etapa le falta el clock y reset!! // Hará falta????
EXEC: execution port map (dato1=>dato_1_out_aux, dato2=>dato_2_out_aux, ext_sig=>ext_sig_out_aux, sumador=>sum_out_aux2, inst1511=>inst1511_out_aux, inst2016=>inst2016_out_aux, ex=>ex_aux_out, wb=>wb_aux_out, m=>m_aux_out,
							M_out=>m_aux_out_ex, WB_out=>wb_aux_out_ex, alu_result=>alu_result2_aux, alusalto_result=>alusalto_result_aux, dato2_out=>dato_2_out_aux_ex, cero=>cero_aux, EscrDatos=>EscrDatos_aux);
EX_MEM: exmem port map (clk=>clock, reset=>reset, m=>m_aux_out_ex, wb=>wb_aux_out_ex, AluResult=>alu_result2_aux, AluSalto=>alusalto_result_aux, dato2=>dato_2_out_aux_ex, cero=>cero_aux, EscrDato=>EscrDatos_aux,
					M_out=>m_aux2_in, wb_out=>wb_aux2_in, AluResult_out=>AluResult_out_aux, AluSalto_out=>AluSalto_out_aux, dato2_out=>dato2_out_aux, cero_out=>cero_out_aux, EscrDato_out=>EscrDato_out_aux);

-- EX/MEM->Etapa4->MEM/WB
MEM_ACC: memory_acc port map (rst=>reset, clk=>clock, m=>m_aux2_in, wb=>wb_aux2_in, AluResult=>AluResult_out_aux, AluSalto=>alu_salto_aux, dato2=>dato2_out_aux, cero=>cero_out_aux, EscrDato=>EscrDato_out_aux,
							Dato_leido=>Dato_leido_aux, AluResult_out=>aluresult_out_aux_mem, alusalto_out=>alusalto_out_mem, EscrDato_out=>EscrDato_out_aux, WB_out=>wb_aux2_in, FuentePc=>fuente_pc_aux);
MEM_WB: memwb port map (clk=>clock, reset=>reset, wb=>wb_aux2_in, dato_leido=>Dato_leido_aux, AluResult=>AluResult_out_aux, EscrDato=>EscrDato_out_aux,
					WB_out=>WB_out_aux3, dato_leido_out=>dato_leido_out_aux, AluResult_out=>AluResult_out_aux2, EscrDato_out=>EscrDato_out_aux2);

-- MEM/WB->Etapa5
WRITEB: writeback port map (wb=>WB_out_aux3, Dato_leido=>dato_leido_out_aux, AluResult=>AluResult_out_aux2, EscDato=>EscrDato_out_aux2,
						EscDato_out=>escr_reg_aux, Mux_out=>escr_data_aux, EscrReg=>escrreg_aux);

--salidas de pipeline (test)
salida <= dato_leido_out_aux;
instruccion_gral <= mem_out_aux;
control_id_ex_gral(8 downto 7) <= wb_aux_out; --wb(0)->EscrReg_Aux; wb(1)->MemAReg
control_id_ex_gral(6 downto 4) <= m_aux_out;
control_id_ex_gral(3 downto 0) <= ex_aux_out;
alu_salto_gral <= AluSalto_out_aux;
direccion_gral <= AluResult_out_aux;

end bhv_str;