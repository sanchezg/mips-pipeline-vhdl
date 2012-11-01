
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

---- Uncomment the following library declaration if instantiating
---- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ANTICIPACION is
port(Rt,Rs : in std_logic_vector(4 downto 0);
	  EX_MEM_Rd,MEM_WB_Rd : in std_logic_vector(4 downto 0);
	  EscrReg_ExMem, EscrReg_MemWb: in std_logic;
	  Out_A, Out_B : out std_logic_vector(1 downto 0)
);	  
end ANTICIPACION;

architecture Behavioral of ANTICIPACION is

begin

	Out_A<= "10" when (EscrReg_ExMem = '1' and EX_MEM_Rd /= "00000" and EX_MEM_Rd = Rs ) else
			  "01" when (EscrReg_MemWb = '1' and MEM_WB_Rd /= "00000" and MEM_WB_Rd = Rs ) else
			  "00";
			  
	Out_B<= "10" when (EscrReg_ExMem = '1' and EX_MEM_Rd /= "00000" and EX_MEM_Rd = Rt ) else
			  "01" when (EscrReg_MemWb = '1' and MEM_WB_Rd /= "00000" and MEM_WB_Rd = Rt ) else
			  "00";


end Behavioral;

