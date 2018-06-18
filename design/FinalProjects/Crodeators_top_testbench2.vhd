--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   10:06:10 04/06/2016
-- Design Name:   
-- Module Name:   /home1/ISEProjects/AgroDispenserIndicator/MainMachineTestbench.vhd
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
 
ENTITY Crodeators_top_testbench2 IS
END Crodeators_top_testbench2;
 
ARCHITECTURE behavior OF Crodeators_top_testbench2 IS 
 
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
		CurrentAreaNumber <="000";
		CropType <="011";
		
		-- check the water amount depending on the humidity
		Health <= '0';
		Height <="001";
		Humidity <= "01100110";
		wait until not(Water="00000000");
		wait for Clock_period;
		Humidity <= "11111111";
		wait for Clock_period*2;
		
		-- check the water amount depending on the humidity
		Health <= '0';
		Height <="011";
		Humidity <= "11100010";
		wait until not(Water="00000000");
		wait for Clock_period;
		Humidity <= "11111111";
		wait for Clock_period*2;
		
		-- check the water amount depending on the humidity and cut till the height of 6
		Health <= '0';
		Height <="111";
		Humidity <= "11100010";
		wait until (Cut="01");
		wait for Clock_period; -- wait for 1 s for cutting
		Height <="110";
		wait until not(Water="00000000");
		wait for Clock_period;
		Humidity <= "11111111";
		wait for Clock_period*2;
		
		-- check the water amount depending on the humidity
		Health <= '0';
		Height <="011";
		Humidity <= "10101110";
		wait until not(Water="00000000");
		wait for Clock_period;
		Humidity <= "11111111";
		wait for Clock_period*2;
		
		-- cut the crop from roots because the crop is dead
		Health <= '1';
		Height <="011";
		Humidity <= "10100101";
		wait until (Cut="11");
		wait for Clock_period; -- wait for 1 s for cutting
		Health <='0';
		Height <="000";
		Humidity <= "11111111";
		wait for Clock_period*2;
		
      wait for Clock_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
