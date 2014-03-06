----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:56:51 03/03/2014 
-- Design Name: 
-- Module Name:    nes_speed_control - Behavioral 
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
--library UNISIM;
--use UNISIM.VComponents.all;

entity nes_speed_control is
    Port ( clk : in  STD_LOGIC;
			  reset : in std_logic;
           btn_in : in  STD_LOGIC;
           btn_out : out  STD_LOGIC);
end nes_speed_control;

architecture Behavioral of nes_speed_control is
type button is
(stall, pressed, cycle);


signal button_reg, button_next : button;
signal count_reg, count_next : unsigned ( 19 downto 0);
signal held_out_buff, held_next_buff : std_logic;

begin

process(clk, reset)
	begin
			if (reset = '1') then
				count_reg <= to_unsigned(0,20);
			elsif rising_edge(clk) then
				count_reg <= count_next;
			end if;
	end process;


	process(clk, reset)
	begin
		if (reset='1') then
			button_reg <= stall;
		elsif (rising_edge(clk)) then
			button_reg <= button_next;
		end if;
	end process;
	
	
count_next <= count_reg + 1 when (count_reg<1500000) else
to_unsigned(0, 20);


--next-state logic	
	process(btn_in, count_reg, button_reg)
		begin
		
			button_next<=button_reg;
			case button_reg is
			 when stall =>
				if(btn_in = '1') then
					button_next <= pressed;
				end if;
				
			when pressed =>
				if(count_reg=1500000) then	
					button_next <=cycle;
					
				end if;
			when cycle =>
				if(btn_in = '1') then
					button_next <= pressed;
				else
					button_next <= stall;
				end if;
			end case;
		end process;

--output logic
	process(button_reg)
		begin
			case button_reg is
				when stall =>
					held_next_buff<='0';
				when pressed =>
					held_next_buff <='0';
				when cycle =>
					held_next_buff <= '1';
			end case;
	end process;

--output buffer
	process(clk)
	begin
		held_out_buff <= held_out_buff;
		if (rising_edge(clk)) then
			held_out_buff <= held_next_buff;
		end if;
	end process;


btn_out <= held_out_buff;
end Behavioral;

