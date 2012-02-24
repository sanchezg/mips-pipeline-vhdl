
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

---- Uncomment the following library declaration if instantiating
---- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Unidad_Deteccion_Riesgos is
	port(Rt_IFID,Rs_IFID, Rt_IDEX: in std_logic_vector(4 downto 0);
		  LeerMem: in std_logic;
		  EscrPc,EscrIFID, Salida_mux: out std_logic	
		);
end Unidad_Deteccion_Riesgos;

architecture Behavioral of Unidad_Deteccion_Riesgos is

begin

	Salida_mux <= '1' when (LeerMem = '1' and (Rt_IDEX = Rs_IFID or Rt_IDEX = Rt_IFID)) else
					  '0'	;
					  
	EscrPc <= '0' when (LeerMem = '1' and (Rt_IDEX = Rs_IFID or Rt_IDEX = Rt_IFID)) else
				 '1';

   EscrIFID <= '0' when (LeerMem = '1' and (Rt_IDEX = Rs_IFID or Rt_IDEX = Rt_IFID)) else
				   '1';				 

end Behavioral;

