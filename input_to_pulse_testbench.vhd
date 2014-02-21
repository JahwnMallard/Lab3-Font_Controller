--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   23:14:55 02/20/2014
-- Design Name:   
-- Module Name:   C:/Users/C15John.Miller/Documents/Classes/2nd class/Spring/ECE383/VHDL/Font_lab/input_to_pulse_testbench.vhd
-- Project Name:  Font_lab
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: input_to_pulse
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
 
ENTITY input_to_pulse_testbench IS
END input_to_pulse_testbench;
 
ARCHITECTURE behavior OF input_to_pulse_testbench IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT input_to_pulse
    PORT(
         clk : IN  std_logic;
         reset : IN  std_logic;
         input : IN  std_logic;
         pulse : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal reset : std_logic := '0';
   signal input : std_logic := '0';

 	--Outputs
   signal pulse : std_logic;

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: input_to_pulse PORT MAP (
          clk => clk,
          reset => reset,
          input => input,
          pulse => pulse
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
		reset <='1';
      wait for clk_period*10;
		
		reset<='0';
		
		wait for clk_period*10;
		
		input<='1';
		
		wait for clk_period*1000;
		
		input <='0';
      -- insert stimulus here 

      wait for clk_period*10000;
		input<='1';
		
		wait for clk_period*1000;
		
		input <='0';
      -- insert stimulus here 

      wait for clk_period*10000;
   end process;

END;
