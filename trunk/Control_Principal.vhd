----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:20:21 03/22/2011 
-- Design Name: 
-- Module Name:    Control_Principal - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

---- Uncomment the following library declaration if instantiating
---- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Control_Principal is
 
 port (
       control_out : out std_logic_vector (8 downto 0);
		--control_out(0) -> AluOp (0) 
		--control_out(1) -> AluOp (1)
		--control_out(2) -> SaltoCond 
		--control_out(3) -> EscMem
		--control_out(4) -> LeerMem 
		--control_out(5) -> EscReg
		--control_out(6) -> MemaReg 
		--control_out(7) -> Fuente Alu
		--control_out(8) -> RegDest
       		
		 instr : in std_logic_vector (5 downto 0)
		 );
		 
		 
		 
end Control_Principal;

architecture Behavioral of Control_Principal is

begin

 process (instr)
  begin
   case instr is
	
	 when "000000" => control_out <= "100100010";
	 when "100011" => control_out <= "011110000";
	 when "101011" => control_out <= "010001000"; --X1X001000
	 when "000100" => control_out <= "000000101"; --X0X000101
	 when others => null;
	 
	end case; 
	 
end process;

end Behavioral;