library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity mux_2x5 is
port(x,y: in std_logic_vector(4 downto 0);
	  sel: in std_logic;
		salida: out std_logic_vector(4 downto 0));	
end mux_2x5;

architecture Behavioral of mux_2x5 is

begin

salida <= x when sel='0' else y;

end Behavioral;

