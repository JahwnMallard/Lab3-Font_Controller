--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   09:57:19 02/25/2014
-- Design Name:   
-- Module Name:   C:/Users/C15John.Miller/Documents/Classes/2nd class/Spring/ECE383/VHDL/Font_lab/chargen_testbench.vhd
-- Project Name:  Font_lab
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: char_gen_test
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY chargen_testbench IS
END chargen_testbench;
 
ARCHITECTURE behavior OF chargen_testbench IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT char_gen_test
    PORT(
         clk : IN  std_logic;
         reset : IN  std_logic;
         ascii_char : IN  std_logic;
         en : IN  std_logic;
         r : OUT  std_logic_vector(7 downto 0);
         g : OUT  std_logic_vector(7 downto 0);
         b : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal reset : std_logic := '0';
   signal ascii_char : std_logic := '0';
   signal en : std_logic := '0';

 	--Outputs
   signal r : std_logic_vector(7 downto 0);
   signal g : std_logic_vector(7 downto 0);
   signal b : std_logic_vector(7 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: char_gen_test PORT MAP (
          clk => clk,
          reset => reset,
          ascii_char => ascii_char,
          en => en,
          r => r,
          g => g,
          b => b
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      wait for clk_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
