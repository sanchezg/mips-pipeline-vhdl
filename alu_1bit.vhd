library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity alu_1bit is
    Port ( x, y, cin, menor: in std_logic;
           op : in  STD_LOGIC_VECTOR (2 downto 0);
           cout, comparacion, result : out  STD_LOGIC);
end alu_1bit;

architecture Behavioral of alu_1bit is

component full_adder is port (
	x: in std_logic;
	y: in std_logic;
	cin: in std_logic;
	cout: out std_logic;
	r: out std_logic);
end component full_adder;

signal aux2, aux3, res_mux: std_logic;

begin
--mux que elige entre Y y NOT Y
aux3 <= y when op(2)='0' else not y;

full_adder_alu: full_adder port map (x=>x, y=>aux3, cin=>cin, cout=>cout, r=>aux2);

--res_mux<= aux2;
--mux que elige la operacion
process(op, x, y, aux2, menor) is
begin
	case op is
		when "000" => res_mux <= x and y; --and
		when "001" => res_mux <= x or y; --or
		when "010" => res_mux <= aux2;
		when "110" => res_mux <= aux2;
		when "011" => res_mux <= menor; --para la operacion slt
		when others => null;
	end case;
end process;

--actualizar seniales
result <= res_mux;
comparacion <= aux2;

end Behavioral;