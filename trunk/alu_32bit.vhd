library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity alu_32b is
    Port ( x, y : in  STD_LOGIC_VECTOR (31 downto 0);
           op : in  STD_LOGIC_VECTOR (2 downto 0);
           result : out  STD_LOGIC_VECTOR (31 downto 0);
			  carry, zero: out std_logic );
end alu_32b;

architecture Behavioral of alu_32b is

component alu_1bit is
    Port ( x, y, cin, menor : in  STD_LOGIC;
           op : in  STD_LOGIC_VECTOR (2 downto 0);
           cout, comparacion, result : out  STD_LOGIC);
end component;

signal res_aux, caux: std_logic_vector (31 downto 0);
signal auxmen: std_logic;

begin

alu_1b_inicial: alu_1bit port map (x=>x(0), y=>y(0), cin=>op(2), op(2 downto 0)=>op(2 downto 0),menor=>auxmen, cout=>caux(0), result=>res_aux(0));
alu_1b_sig: for i in 1 to 30 generate
alu_sig: alu_1bit port map (x=>x(i), y=>y(i), cin=>caux(i-1), op(2 downto 0)=>op(2 downto 0),menor=>'0', cout=>caux(i), result=>res_aux(i));
end generate;
alu_1b_final: alu_1bit port map (x=>x(31), y=>y(31), cin=>caux(30), op(2 downto 0)=>op(2 downto 0),menor=>'0', comparacion=>auxmen, cout=>caux(31), result=>res_aux(31));

--actualizar seniales
result <= res_aux;
carry <= caux(31);
zero <= '1' when res_aux=x"00" else '0';

end Behavioral;