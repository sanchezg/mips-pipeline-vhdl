----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:33:21 07/19/2011 
-- Design Name: 
-- Module Name:    mux_2x32 - Behavioral 
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

entity mux_2x32 is
port(x,y : in std_logic_vector(31 downto 0);
	  sel : in std_logic;
	  salida : out std_logic_vector(31 downto 0)
);	  
end mux_2x32;

architecture Behavioral of mux_2x32 is

begin

salida <= x when sel='0' else y;

end Behavioral;

