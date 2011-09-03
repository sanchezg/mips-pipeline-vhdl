library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity instruction_fetch is
	port (
		reset, clk, fuente_pc : in std_logic;
		alu_result :in std_logic_vector (31 downto 0);
		salida : out std_logic_vector(31 downto 0);
		salida_sum: out std_logic_vector(31 downto 0)
		);
end instruction_fetch;

architecture Behavioral of instruction_fetch is

--Instanciacion de componentes
--Registro PC
component reg32bit is
	port (
		r_in : in  STD_LOGIC_VECTOR (31 downto 0);
		r_out : out  STD_LOGIC_VECTOR (31 downto 0);
		clk, reset : in  STD_LOGIC
		);
end component reg32bit;

--Memoria 
component memoria is
  port (
    rst, clk, rd, wr : in  std_logic;
    addr, in_data  : in  std_logic_vector (31 downto 0);
    out_data : out std_logic_vector (31 downto 0)
	 );
end component memoria;

--Sumador
component alu_32b is
    port (
		x, y : in  STD_LOGIC_VECTOR (31 downto 0);
		op : in  STD_LOGIC_VECTOR (2 downto 0);
		result : out  STD_LOGIC_VECTOR (31 downto 0);
		carry, zero: out std_logic 
		);
end component alu_32b;

--Multiplexor
component mux_2x32 is
	port (
		x, y : in std_logic_vector(31 downto 0);
		sel : in std_logic;
		salida : out std_logic_vector(31 downto 0)
		);	  
end component mux_2x32;

for all: reg32bit use entity reg32bit(bhv);
for all: memoria use entity memoria(bhv);
for all: alu_32b use entity alu_32b(Behavioral);
for all: mux_2x32 use entity mux_2x32(Behavioral);

--señales auxiliares
signal pc_out, mux0, sum_out : std_logic_vector (31 downto 0);

begin

--ports maps
registro_pc: reg32bit	port map (r_in => mux0, r_out => pc_out, clk => clk, reset => reset);
memo: memoria	port map (rst => reset, clk => clk, rd =>'1', wr => '0', addr => pc_out, out_data=>salida, in_data=>x"0000");
sum:	alu_32b	port map (x=> pc_out, y=>x"0004", op=>"010", result=>sum_out, carry=>open, zero=>open);
mux_0: mux_2x32	port map (x=>sum_out, y=>alu_result, sel=> Fuente_pc, salida=>mux0);
											
salida_sum <= sum_out;											

end Behavioral;