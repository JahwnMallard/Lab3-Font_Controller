----------------------------------------------------------------------------------
-- Company: 	USAF Academy
-- Engineer: 	C2C John Miller
-- 
-- Create Date:    10:24:08 01/31/2014 
-- Design Name: 
-- Module Name:    v_sync_gen - Behavioral 
-- Project Name: 	 ECE 383 lab 1
-- Target Devices: 
-- Tool versions: 
-- Description:  Syncs the vertical element for a vga controller
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

entity v_sync_gen is
    Port ( clk         : in  std_logic;
           reset       : in std_logic;
           h_blank     : in std_logic;
           h_completed : in std_logic;
           v_sync      : out std_logic;
           blank       : out std_logic;
           completed   : out std_logic;
           row         : out unsigned(10 downto 0)
     );
end v_sync_gen;

architecture Behavioral of v_sync_gen is


signal count, count_next : unsigned (10 downto 0);

type v_sync_type is
(ActiveVideo, FrontPorch, BackPorch, Sync, Complete);

signal state_reg, state_next : v_sync_type;
begin
 --state register
process(clk, reset)
   begin
      if (reset='1') then
         state_reg <= ActiveVideo;
      elsif rising_edge(clk) then
			state_reg <= state_next;
      end if;
end process;

--count register
process(clk,reset)
   begin
      if (reset='1') then
			count <= (others => '0');
      elsif rising_edge(clk) then
         count <= count_next;
      end if;
end process;



--next state logic
process(count, state_reg)
	begin
		
		state_next <= state_reg;
	
	if(h_completed = '1') then
		case state_reg is
		
			when ActiveVideo =>
				if (count = 480) then
					state_next <= FrontPorch;
				end if;
			when FrontPorch =>
				if (count = 10) then
					state_next <= Sync;
				end if;
			when Sync =>
				if (count = 2) then
					state_next <= BackPorch;
				end if;
			when BackPorch =>
				if (count = 32) then
					state_next <= Complete;
				end if;
			when Complete =>
				state_next <= ActiveVideo;	
			
		end case;
		end if;	
	end process;

--count_next logic
count_next <= (others => '0') when (state_reg /= state_next) else
				  count when (h_completed = '0') else
				  count + 1;

--output logic

 process(state_next, count_next, h_completed)
	
   begin
		v_sync <= '0';
		blank <='0';
		completed <='0';
		row <= (others => '0');
       
      case state_next is
         when ActiveVideo =>
            v_sync <= '1';
				blank <='0';
				completed <='0';
				row <= count_next;
         when FrontPorch =>
            v_sync <= '1';
				blank <='1';
				completed <='0';
				row <= (others => '0');
         when Sync =>
            v_sync <= '0';
				blank <='1';
				completed <='0';
				row <= (others => '0');
         when BackPorch =>
            v_sync <= '1';
				blank <='1';
				completed <='0';
				row <= (others => '0');
			when Complete =>
			   v_sync <= '1';
				blank <='1';
				completed <='1';
				row <= (others => '0');
      end case;
   end process;
			  
end Behavioral;

