library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity IFID is
	port(
		mem_in, sum_in: in std_logic_vector(31 downto 0);
		IFID_cs: in std_logic;
		mem_out, sum_out: out std_logic_vector(31 downto 0);
		clk, reset: in std_logic
	);
end IFID;

architecture Behavioral of IFID is

begin

process (clk, reset, mem_in, sum_in) is
begin
	if (reset='1') then
		mem_out <= x"00000000";
		sum_out <= x"00000000";
	elsif (clk'event and clk = '1' and IFID_cs='1') then
		mem_out <= mem_in;
		sum_out <= sum_in;
	end if;
end process;

end Behavioral;

