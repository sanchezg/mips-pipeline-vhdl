----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:46:24 09/26/2011 
-- Design Name: 
-- Module Name:    mux_4x32 - Behavioral 
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

entity mux_3x32 is
port(x,y,w : in std_logic_vector(31 downto 0);
	  sel : in std_logic_vector(2 downto 0);
	  salida : out std_logic_vector(31 downto 0)
);	  
end mux_3x32;

architecture Behavioral of mux_3x32 is

begin

salida <= x when sel="00" else y;

end Behavioral;
