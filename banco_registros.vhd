library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity reg_file is
--	generic(
--		B: integer := 32; 
--		W: integer := 5
--	);
port (
	clk, reset, wr_en: in std_logic;
	wr_addr, r_addr1, r_addr2: in std_logic_vector (4 downto  0);
	wr_data: in std_logic_vector(31 downto  0);
	r_data1, r_data2 : out std_logic_vector(31 downto  0)
	);
end reg_file;

architecture arch of reg_file is
type reg_file_type is array (31 downto 0) of std_logic_vector(31 downto 0);

signal array_reg: reg_file_type;

begin
process(clk, reset)
	begin
		if (reset='1') then
			array_reg <= (others =>(others =>'0'));
			array_reg(10) <= x"000FF070";
			array_reg(11) <= x"0000D1F0";
		elsif (clk'event and clk='1') then
			if wr_en='1' then array_reg(to_integer(unsigned(wr_addr))) <= wr_data;
			end if;
		end if;
end process;

--read port
r_data1 <= array_reg(to_integer(unsigned(r_addr1)));
r_data2 <= array_reg(to_integer(unsigned(r_addr2)));

end arch;