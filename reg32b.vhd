library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity reg32bit is
    Port ( r_in : in  STD_LOGIC_VECTOR (31 downto 0);
           r_out : out  STD_LOGIC_VECTOR (31 downto 0);
           clk, reset : in  STD_LOGIC);
end reg32bit;


architecture bhv of reg32bit is

begin
	process(clk, reset) is
	begin
		if (reset='1') then
			r_out <= (others => '0');
		elsif (clk'event and clk='1') then
			r_out <= r_in;
		end if;
	end process;

end bhv;
