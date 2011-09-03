----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:45:36 03/22/2011 
-- Design Name: 
-- Module Name:    Control_ALU - Behavioral 
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

entity Control_ALU is
 port (
   func: in std_logic_vector (5 downto 0);
	Aluop : in std_logic_vector (1 downto 0);
   alu_op : out std_logic_vector (2 downto 0)
	 );
 
 
end Control_ALU;

architecture Behavioral of Control_ALU is

begin


 process (Aluop, func) is
  begin
    case Aluop is
	 
	 When "00" => alu_op <= "010";  -- Instruccion Load/Store   (suma)
    When "01" => alu_op <= "110";  -- Instruccion Branch equal (resta)  
    When "10" =>						  -- Instrucciones R-type  (decodificar)	

	      if (func = "100000") then alu_op <= "010";     --suma
         else if(func = "100010") then alu_op <= "110"; --resta 
			else if(func = "100100") then alu_op <= "000"; -- and
			else if(func = "100101") then alu_op <= "001"; -- or
			else if(func = "101010") then alu_op <= "111"; --slt
			end if;
			end if;
			end if;
			end if;
			end if;
    When others => null;
	 
	 end case;
	end process; 
	 
end Behavioral;

