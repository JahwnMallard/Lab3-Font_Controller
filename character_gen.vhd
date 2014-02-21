----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    09:46:26 02/21/2014 
-- Design Name: 
-- Module Name:    character_gen - Behavioral 
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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity character_gen is
    Port ( clk : in  STD_LOGIC;
           blank : in  STD_LOGIC;
           row : in  STD_LOGIC_VECTOR (10 downto 0);
           column : in  STD_LOGIC_VECTOR (10 downto 0);
           ascii_to_write : in  STD_LOGIC_VECTOR (7 downto 0);
           write_en : in  STD_LOGIC;
           r,g,b : out  STD_LOGIC_VECTOR (7 downto 0));
end character_gen;

architecture Behavioral of character_gen is

	COMPONENT font_rom
	PORT(
		clk : IN std_logic;
		addr : IN std_logic_vector(10 downto 0);          
		data : OUT std_logic_vector(7 downto 0)
		);
	END COMPONENT;

	COMPONENT char_screen_buffer
	PORT(
		clk : IN std_logic;
		we : IN std_logic;
		address_a : IN std_logic_vector(11 downto 0);
		address_b : IN std_logic_vector(11 downto 0);
		data_in : IN std_logic_vector(7 downto 0);          
		data_out_a : OUT std_logic_vector(7 downto 0);
		data_out_b : OUT std_logic_vector(7 downto 0)
		);
	END COMPONENT;


signal address : std_logic_vector(10 downto 0);
signal rom_data : std_logic_vector(7 downto 0);
signal data_b_sig : std_logic_vector(6 downto 0);
signal row_reg, row_next : std_logic_vector(10 downto 0);
signal font_data_sig : std_logic_vector(7 downto 0);
signal col_reg, col_next_1, col_next_2 : std_logoc_vector(3 downto 0);

begin
	

Inst_char_screen_buffer: char_screen_buffer PORT MAP(
		clk => clk,
		we => write_en,
		address_a => (others => '0') ,
		address_b => open,
		data_in => ascii_to_write,
		data_out_a => open,
		data_out_b => data_b_sig
	);

Inst_font_rom: font_rom PORT MAP(
		clk => clk ,
		addr => row_next & data_b_sig,
		data =>  font_data_sig
	);


process(clk) is 
begin
if(rising_edge(clk)) then
	col_next_1 <= (column(2) & column(1) & column(0));
	end if;
end process;

process(clk) is
begin
if(rising_edge(clk)) then
	col_next_2 <= col_next_1;
	end if;
end process;

col_reg <= col_next_2;




end Behavioral;

