----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    22:28:28 02/23/2014 
-- Design Name: 
-- Module Name:    char_gen_test - Behavioral 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
  use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
  library UNISIM;
  use UNISIM.VComponents.all;

entity char_gen_test is
    Port ( clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           ascii_char : in  STD_LOGIC;
           en : in  STD_LOGIC;
           r : out  STD_LOGIC_VECTOR (7 downto 0);
           g : out  STD_LOGIC_VECTOR (7 downto 0);
           b : out  STD_LOGIC_VECTOR (7 downto 0));
end char_gen_test;

architecture Behavioral of char_gen_test is

	COMPONENT vga_sync
	PORT(
		clk : IN std_logic;
		reset : IN std_logic;          
		h_sync : OUT std_logic;
		v_sync : OUT std_logic;
		v_completed : OUT std_logic;
		blank : OUT std_logic;
		row : OUT std_logic_vector(10 downto 0);
		column : OUT std_logic_vector(10 downto 0)
		);
	END COMPONENT;
	
	COMPONENT character_gen
	PORT(
		clk : IN std_logic;
		blank : IN std_logic;
		row : IN std_logic_vector(10 downto 0);
		column : IN std_logic_vector(10 downto 0);
		ascii_to_write : IN std_logic_vector(7 downto 0);
		write_en : IN std_logic;          
		r : OUT std_logic_vector(7 downto 0);
		g : OUT std_logic_vector(7 downto 0);
		b : OUT std_logic_vector(7 downto 0)
		);
	END COMPONENT;

	signal blank_sig, v_sig : std_logic ;
	signal row_sig, col_sig : std_logic_vector(10 downto 0);
	
begin

Inst_vga_sync: vga_sync PORT MAP(
		clk => clk,
		reset => reset,
		h_sync => open,
		v_sync => open,
		v_completed => v_sig,
		blank => blank_sig,
		row => row_sig,
		column => col_sig 
	);


Inst_character_gen: character_gen PORT MAP(
		clk => clk,
		blank => blank_sig,
		row => row_sig,
		column => col_sig,
		ascii_to_write => "00000111",
		write_en => en,
		r => r,
		g => g,
		b => b
	);

end Behavioral;

