
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

---- Uncomment the following library declaration if instantiating
---- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity mux_2x9 is
	port(
		x,y: in std_logic_vector(8 downto 0);
		sel: in std_logic;
		salida: out std_logic_vector(8 downto 0)
	);
end mux_2x9;

architecture Behavioral of mux_2x9 is

begin

	salida <= x when sel='0' else y;

end Behavioral;

