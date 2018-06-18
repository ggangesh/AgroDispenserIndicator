--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   19:04:41 04/06/2016
-- Design Name:   
-- Module Name:   /home1/ISEProjects/FinalProjects/Crodeators_top_testbench3.vhd
-- Project Name:  FinalProjects
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Crodeators_top
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
 
ENTITY Crodeators_top_testbench1 IS
END Crodeators_top_testbench1;
 
ARCHITECTURE behavior OF Crodeators_top_testbench1 IS 
 
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
	 --Entering the first area with area number "000" and crop type "011"
    CurrentAreaNumber <="000";
    CropType <="011";
	 --First crop
	 -- Normal health, height 7 and humidity 11100010
	 -- In this case the height of crop is full hence it must be cut and also since the humidity is not full it also needs watering
	 -- This case gives preferece to cutting and then it waters the crop appropriately
    Health <= '0';
    Height <="111";
    Humidity <= "11100010";
    wait until (Cut="01");
    wait for Clock_period; -- wait for 1 s for cutting
    Height <="110";
    wait until not(Water="00000000");
    wait for Clock_period;
    Humidity <= "11111111"; -- humidity changes back to full once watered
    wait for Clock_period*2;
    
	 --new area with area number "001" and crop type "010"
    CurrentAreaNumber <="001";
    CropType <="010";
    Clock <='0';
	 
	 --Second crop
	 --normal health, height 2 and humidity 11100010
	 -- used to check just the amount of water released
    Health <= '0';
    Height <="010";
    Humidity <= "11100010";
    wait until not(Water="00000000");
    wait for Clock_period;
    Humidity <= "11111111";-- humidity changes back to full once watered
    wait for Clock_period*2;
    
	 --new crop
	 --normal health, height 7 and humidity 11101011
	 --It gives preference for cutting and then waters the land
    Height <="111";
    Humidity <= "11101011";
    wait until (Cut="01");
    wait for Clock_period; -- wait for 1 s for cutting
    Height <="110";
    wait until not(Water="00000000");
    wait for Clock_period;
    Humidity <= "11111111";
    wait for Clock_period*2;
    
	 
	 --new area
	 -- with area number 010 and crop type 111
    CurrentAreaNumber <="010";
    CropType <="111";
	 
	 --new crop
	 -- crop is dead with height 3 and humidity 10101110
	 -- in this case the crop will be completely uprooted and reported given by the Cut value "11"
    Health <= '1';
    Height <="011";
    Humidity <= "10101110";
    wait until (Cut="11");
    wait for Clock_period; -- wait for 1 s for cutting
    Health <='0';
    Height <="000";
    wait until not(Water="00000000");
    wait for Clock_period;
    Humidity <= "11111111";
    wait for Clock_period*2;
    
	 --new area 
	 -- with area number 011 and crop type 101
    CurrentAreaNumber <="011";
    CropType <="101";
	 
	 --new crop
	 -- normal health and height  increasing from 2 to 7 with every clock period and full humidity
	 -- In this case there wont be any watering and the crop will be cut when the height reaches 7
    Health <= '0';
    Height <="010";
    Humidity <= "11111111";
    wait for Clock_period;
    Height <="011";
    wait for Clock_period;
    Height <="100";
    wait for Clock_period;
    Height <="101";
    wait for Clock_period;
    Height <="110";
    wait for Clock_period;
    Height <="011";
    wait for Clock_period;
    Height <="111";
    wait until (Cut="01");
    wait for Clock_period; -- wait for 1 s for cutting
    Height <="011";
    --wait until not(Water="00000000");
    --wait for Clock_period;
    --Humidity <= "11111111";
    wait for Clock_period*2;

	 --new area with area number 100 and crop type 100
    CurrentAreaNumber <="100";
    CropType <="100";
	 
	 --Dead crop with height 7 and humidity 11000000
	 -- the crop is uprooted completely since it is dead
    Health <= '1';
    Height <="111";
    Humidity <= "11000000";
    wait until (Cut="01" or Cut="11");
    wait for Clock_period; -- wait for 1 s for cutting
    Height <="011";
	 Health <= '0';
    wait until not(Water="00000000");
    wait for Clock_period;
    Humidity <= "11111111";
    wait for Clock_period*2;
    
      wait for Clock_period*10;
	 -- after the complete duration of the crop with type 100 i.e. duration 80 will be uprooted after 80 days
	 -- after that the area will be tilled in the 1st,3rd and 5th day
	 -- after that the area block is left barren for 30 days and then watered one day, and seeds are dispensed on the next day
      
		-- insert stimulus here 

      wait;
   end process;

END;