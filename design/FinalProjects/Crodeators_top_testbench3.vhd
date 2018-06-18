--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   10:06:10 04/06/2016
-- Design Name:   
-- Module Name:   /home1/ISEProjects/AgroDispenserIndicator/Crodeators_top_testbench1.vhd
-- Project Name:  AgroDispenserIndicator
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: MainMachine
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
 
ENTITY Crodeators_top_testbench3 IS
END Crodeators_top_testbench3;
 
ARCHITECTURE behavior OF Crodeators_top_testbench3 IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Crodeators_top
    PORT(
         CurrentAreaNumber : IN  std_logic_vector(2 downto 0);
         CropType : IN  std_logic_vector(2 downto 0);
         Height : IN  std_logic_vector(2 downto 0);
         Health : IN  std_logic;
         Humidity : IN  std_logic_vector(7 downto 0);
         Clock : IN  std_logic;
         Cut : OUT  std_logic_vector(1 downto 0);
         Water : OUT  std_logic_vector(7 downto 0);
         Dispense : OUT  std_logic;
         TillSoil : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal CurrentAreaNumber : std_logic_vector(2 downto 0) := (others => '0');
   signal CropType : std_logic_vector(2 downto 0) := (others => '0');
   signal Height : std_logic_vector(2 downto 0) := (others => '0');
   signal Health : std_logic := '0';
   signal Humidity : std_logic_vector(7 downto 0) := (others => '1');
   signal Clock : std_logic := '0';

  --Outputs
   signal Cut : std_logic_vector(1 downto 0);
   signal Water : std_logic_vector(7 downto 0);
   signal Dispense : std_logic;
   signal TillSoil : std_logic;

   -- Clock period definitions
   constant Clock_period : time := 100 ns;
 
BEGIN
 
  -- Instantiate the Unit Under Test (UUT)
   uut: Crodeators_top PORT MAP (
          CurrentAreaNumber => CurrentAreaNumber,
          CropType => CropType,
          Height => Height,
          Health => Health,
          Humidity => Humidity,
          Clock => Clock,
          Cut => Cut,
          Water => Water,
          Dispense => Dispense,
          TillSoil => TillSoil
        );

   -- Clock process definitions
   Clock_process :process
   begin
    Clock <= '0';
    wait for Clock_period/2;
    Clock <= '1';
    wait for Clock_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin    
      -- hold reset state for 100 ns.
    Clock <='0';
      wait for 100 ns;
    Clock <='0';
	 
	 
	 -- This test bench is used to check the case of large number of crops to check the functionality of the duration counters
    for I in 0 to 100 loop
  
    CurrentAreaNumber <="000";
    CropType <="011";
    Health <= '0';
    Height <="110";
    Humidity <= "11100010";
    --wait for Clock_period; -- wait for 1 s for cutting
    wait until not(Water="00000000");
    wait for Clock_period;
    Humidity <= "11111111";
    wait for Clock_period*2;
    
    CurrentAreaNumber <="001";
    CropType <="011";
    Health <= '0';
    Height <="110";
    Humidity <= "11100000";
    --wait for Clock_period; -- wait for 1 s for cutting
    wait until not(Water="00000000");
    wait for Clock_period;
    Humidity <= "11111111";
    wait for Clock_period*2;  

    CurrentAreaNumber <="010";
    CropType <="011";
    Health <= '0';
    Height <="110";
    Humidity <= "10100010";
    --wait for Clock_period; -- wait for 1 s for cutting
    wait until not(Water="00000000");
    wait for Clock_period;
    Humidity <= "11111111";
    wait for Clock_period*2;

    CurrentAreaNumber <="011";
    CropType <="011";
    Health <= '0';
    Height <="110";
    Humidity <= "01100010";
    --wait for Clock_period; -- wait for 1 s for cutting
    wait until not(Water="00000000");
    wait for Clock_period;
    Humidity <= "11111111";
    wait for Clock_period*2;

    CurrentAreaNumber <="100";
    CropType <="011";
    Health <= '0';
    Height <="110";
    Humidity <= "00100010";
    --wait for Clock_period; -- wait for 1 s for cutting
    wait until not(Water="00000000");
    wait for Clock_period;
    Humidity <= "11111111";
    wait for Clock_period*2;

    CurrentAreaNumber <="101";
    CropType <="011";
    Health <= '0';
    Height <="110";
    Humidity <= "11111110";
    --wait for Clock_period; -- wait for 1 s for cutting
    wait until not(Water="00000000");
    wait for Clock_period;
    Humidity <= "11111111";
    wait for Clock_period*2;

    CurrentAreaNumber <="110";
    CropType <="011";
    Health <= '0';
    Height <="110";
    Humidity <= "11101010";
    --wait for Clock_period; -- wait for 1 s for cutting
    wait until not(Water="00000000");
    wait for Clock_period;
    Humidity <= "11111111";
    wait for Clock_period*2;

    CurrentAreaNumber <="111";
    CropType <="011";
    Health <= '0';
    Height <="110";
    Humidity <= "11000010";
    --wait for Clock_period; -- wait for 1 s for cutting
    wait until not(Water="00000000");
    wait for Clock_period;
    Humidity <= "11111111";
    wait for Clock_period*2;

    end loop;

      wait for Clock_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;