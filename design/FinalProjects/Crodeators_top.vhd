----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    21:20:52 04/02/2016 
-- Design Name: 
-- Module Name:    Crodeators_top - Crodeators_top_arch 
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Crodeators_top is
    Port ( CurrentAreaNumber : in  STD_LOGIC_VECTOR (2 downto 0);
           CropType : in  STD_LOGIC_VECTOR (2 downto 0);
           Height : in  STD_LOGIC_VECTOR (2 downto 0);
           Health : in  STD_LOGIC;
           Humidity : in  STD_LOGIC_VECTOR (7 downto 0);
           Clock : in  STD_LOGIC;
           Cut : out  STD_LOGIC_VECTOR (1 downto 0);
           Water : out  STD_LOGIC_VECTOR (7 downto 0);
           Dispense : out  STD_LOGIC;
           TillSoil : out  STD_LOGIC);
end Crodeators_top;

architecture Crodeators_top_arch of Crodeators_top is

	signal SCut : STD_LOGIC_VECTOR (1 downto 0) := "00";
	signal SWater : STD_LOGIC_VECTOR (7 downto 0) := "00000000";
	signal SDispense : STD_LOGIC := '0';
	signal STillSoil : STD_LOGIC := '0';
	signal DCMswitch : STD_LOGIC_VECTOR (7 downto 0) := "11111111"; -- Initially all the duration counters are on
	signal BCMswitch : STD_LOGIC_VECTOR (7 downto 0) := "00000000"; -- Initially all the duration counters are on
	signal Reset : STD_LOGIC := '0';
	signal Seconds : STD_LOGIC_VECTOR (2 downto 0) := "000"; -- for simplicity we have assumed a day to be of 8 seconds
	signal Days : STD_LOGIC := '0';
	signal C0 : STD_LOGIC_VECTOR (9 downto 0) := "0000000000";
	signal C1 : STD_LOGIC_VECTOR (9 downto 0) := "0000000000";
	signal C2 : STD_LOGIC_VECTOR (9 downto 0) := "0000000000";
	signal C3 : STD_LOGIC_VECTOR (9 downto 0) := "0000000000";
	signal C4 : STD_LOGIC_VECTOR (9 downto 0) := "0000000000";
	signal C5 : STD_LOGIC_VECTOR (9 downto 0) := "0000000000";
	signal C6 : STD_LOGIC_VECTOR (9 downto 0) := "0000000000";
	signal C7 : STD_LOGIC_VECTOR (9 downto 0) := "0000000000";
	signal Ci : STD_LOGIC_VECTOR (9 downto 0) := "0000000000"; -- current duration counter
	signal B0 : STD_LOGIC_VECTOR (4 downto 0) := "00000";
	signal B1 : STD_LOGIC_VECTOR (4 downto 0) := "00000";
	signal B2 : STD_LOGIC_VECTOR (4 downto 0) := "00000";
	signal B3 : STD_LOGIC_VECTOR (4 downto 0) := "00000";
	signal B4 : STD_LOGIC_VECTOR (4 downto 0) := "00000";
	signal B5 : STD_LOGIC_VECTOR (4 downto 0) := "00000";
	signal B6 : STD_LOGIC_VECTOR (4 downto 0) := "00000";
	signal B7 : STD_LOGIC_VECTOR (4 downto 0) := "00000";
	signal Bi : STD_LOGIC_VECTOR (4 downto 0) := "00000"; -- current barren counter
	signal Water1 : STD_LOGIC_VECTOR (7 downto 0) := "00000000";
	signal S1 : STD_LOGIC := '0';
	signal busy : STD_LOGIC := '0';
	
begin -- Crodeators_top_arch
	Cut <= SCut;
	Water <= SWater;
	Dispense <= SDispense;
	TillSoil <= STillSoil;
	
	DCMresetter : process (Clock)
	begin -- process DCMresetter
		if(SDispense='1') then-- then continue counting the duration
			if (CurrentAreaNumber="000") then
				DCMswitch(0) <= '1';
			elsif (CurrentAreaNumber="001") then
				DCMswitch(1) <= '1';
			elsif (CurrentAreaNumber="010") then
				DCMswitch(2) <= '1';
			elsif (CurrentAreaNumber="011") then
				DCMswitch(3) <= '1';
			elsif (CurrentAreaNumber="100") then
				DCMswitch(4) <= '1';
			elsif (CurrentAreaNumber="101") then
				DCMswitch(5) <= '1';
			elsif (CurrentAreaNumber="110") then
				DCMswitch(6) <= '1';
			else
				DCMswitch(7) <= '1';
			end if;
		end if;
		if(Reset='1') then-- then continue counting the duration
			if (CurrentAreaNumber="000") then
				DCMswitch(0) <= '0';
			elsif (CurrentAreaNumber="001") then
				DCMswitch(1) <= '0';
			elsif (CurrentAreaNumber="010") then
				DCMswitch(2) <= '0';
			elsif (CurrentAreaNumber="011") then
				DCMswitch(3) <= '0';
			elsif (CurrentAreaNumber="100") then
				DCMswitch(4) <= '0';
			elsif (CurrentAreaNumber="101") then
				DCMswitch(5) <= '0';
			elsif (CurrentAreaNumber="110") then
				DCMswitch(6) <= '0';
			else
				DCMswitch(7) <= '0';
			end if;
		end if;
	end process DCMresetter;
	
	BCMresetter : process (Clock)
	begin -- process DCMresetter
		if(SDispense='1') then-- then continue counting the duration
			if (CurrentAreaNumber="000") then
				BCMswitch(0) <= '0';
			elsif (CurrentAreaNumber="001") then
				BCMswitch(1) <= '0';
			elsif (CurrentAreaNumber="010") then
				BCMswitch(2) <= '0';
			elsif (CurrentAreaNumber="011") then
				BCMswitch(3) <= '0';
			elsif (CurrentAreaNumber="100") then
				BCMswitch(4) <= '0';
			elsif (CurrentAreaNumber="101") then
				BCMswitch(5) <= '0';
			elsif (CurrentAreaNumber="110") then
				BCMswitch(6) <= '0';
			else
				BCMswitch(7) <= '0';
			end if;
		end if;
		if(Reset='1') then-- then continue counting the duration
			if (CurrentAreaNumber="000") then
				BCMswitch(0) <= '1';
			elsif (CurrentAreaNumber="001") then
				BCMswitch(1) <= '1';
			elsif (CurrentAreaNumber="010") then
				BCMswitch(2) <= '1';
			elsif (CurrentAreaNumber="011") then
				BCMswitch(3) <= '1';
			elsif (CurrentAreaNumber="100") then
				BCMswitch(4) <= '1';
			elsif (CurrentAreaNumber="101") then
				BCMswitch(5) <= '1';
			elsif (CurrentAreaNumber="110") then
				BCMswitch(6) <= '1';
			else
				BCMswitch(7) <= '1';
			end if;
		end if;
	end process BCMresetter;
	
	SecondsCounter : process (Clock)
	begin
		if(Seconds = "111") then
			Seconds <= "000";
		end if;
		Seconds <= Seconds + '1';
	end process SecondsCounter;
	
	DayCounter : process (Seconds)
	begin
		if (Seconds="000") then
			if (Days='1') then
				Days <= '0';
			else
				Days <= '1';
			end if;
		end if;
	end process DayCounter;
	
	DurationCounterMaintainer : process (Days)
	begin -- DurationCounterMaintainer
		if (DCMswitch(0)='1') then
			C0 <= C0 + '1';
		else
			C0 <= "0000000000";
		end if;
		if (DCMswitch(1)='1') then
			C1 <= C1 + '1';
		else
			C1 <= "0000000000";
		end if;
		if (DCMswitch(2)='1') then
			C2 <= C2 + '1';
		else
			C2 <= "0000000000";
		end if;
		if (DCMswitch(3)='1') then
			C3 <= C3 + '1';
		else
			C3 <= "0000000000";
		end if;
		if (DCMswitch(4)='1') then
			C4 <= C4 + '1';
		else
			C4 <= "0000000000";
		end if;
		if (DCMswitch(5)='1') then
			C5 <= C5 + '1';
		else
			C5 <= "0000000000";
		end if;
		if (DCMswitch(6)='1') then
			C6 <= C6 + '1';
		else
			C6 <= "0000000000";
		end if;
		if (DCMswitch(7)='1') then
			C7 <= C7 + '1';
		else
			C7 <= "0000000000";
		end if;
	end process DurationCounterMaintainer;
	
	BarrenCounterMaintainer : process (Days)
	begin -- BarrenCounterMaintainer
		if (BCMswitch(0)='1') then
			B0 <= B0 + '1';
		else
			B0 <= "00000";
		end if;
		if (BCMswitch(1)='1') then
			B1 <= B1 + '1';
		else
			B1 <= "00000";
		end if;
		if (BCMswitch(2)='1') then
			B2 <= B2 + '1';
		else
			B2 <= "00000";
		end if;
		if (BCMswitch(3)='1') then
			B3 <= B3 + '1';
		else
			B3 <= "00000";
		end if;
		if (BCMswitch(4)='1') then
			B4 <= B4 + '1';
		else
			B4 <= "00000";
		end if;
		if (BCMswitch(5)='1') then
			B5 <= B5 + '1';
		else
			B5 <= "00000";
		end if;
		if (BCMswitch(6)='1') then
			B6 <= B6 + '1';
		else
			B6 <= "00000";
		end if;
		if (BCMswitch(7)='1') then
			B7 <= B7 + '1';
		else
			B7 <= "00000";
		end if;
	end process BarrenCounterMaintainer;
	
	CurrentDurationCounter: process (Clock)
	begin 
		if (CurrentAreaNumber="000") then
			Ci <= C0;
		elsif (CurrentAreaNumber="001") then
			Ci <= C1;
		elsif (CurrentAreaNumber="010") then
			Ci <= C2;
		elsif (CurrentAreaNumber="011") then
			Ci <= C3;
		elsif (CurrentAreaNumber="100") then
			Ci <= C4;
		elsif (CurrentAreaNumber="101") then
			Ci <= C5;
		elsif (CurrentAreaNumber="110") then
			Ci <= C6;
		else
			Ci <= C7;
		end if;
	end process CurrentDurationCounter;
	
	
	CurrentBarrenCounter: process (Clock)
	begin 
		if (CurrentAreaNumber="000") then
			Bi <= B0;
		elsif (CurrentAreaNumber="001") then
			Bi <= B1;
		elsif (CurrentAreaNumber="010") then
			Bi <= B2;
		elsif (CurrentAreaNumber="011") then
			Bi <= B3;
		elsif (CurrentAreaNumber="100") then
			Bi <= B4;
		elsif (CurrentAreaNumber="101") then
			Bi <= B5;
		elsif (CurrentAreaNumber="110") then
			Bi <= B6;
		else
			Bi <= B7;
		end if;
	end process CurrentBarrenCounter;
	
	CheckCompletedDuration: process (Clock)
	begin
		if(CropType="000" and Ci="0001011010") then --W
			Reset <= '1';
		elsif(CropType="001" and Ci="0001111000") then --R
			Reset <= '1';
		elsif(CropType="010" and Ci="0010110100") then --S
			Reset <= '1';
		elsif(CropType="011" and Ci="0000101000") then --B
			Reset <= '1';
		elsif(CropType="100" and Ci="0001010000") then --A
			Reset <= '1';
		elsif(CropType="101" and Ci="101101000") then --M
			Reset <= '1';
		elsif(CropType="110" and Ci="0101101000") then --G
			Reset <= '1';
		elsif(CropType="111" and Ci="1111101000") then --O
			Reset <= '1';
		else
			Reset <= '0' ;
		end if;
	end process CheckCompletedDuration;
	
	HeightHealthChecker : process
	begin
		--wait until Clock'event;
		wait for 1ns;
		if(Reset='1') then
			if(busy='1') then
				wait until busy='0';
			end if;
			wait for 2ns;
			if(busy='1') then
				wait until busy='0';
			end if;
			SCut<="10"; -- uproot completely
			wait until reset'event ;
			SCut <="00";
		elsif(Health='1') then
			if(busy='1') then
				wait until busy='0';
			end if;
			wait for 2ns;
			if(busy='1') then
				wait until busy='0';
			end if;
			SCut<="11"; -- report and uproot completely
			wait until Health'event ;
			SCut <="00";
		elsif(Height="111") then
			if(busy='1') then
				wait until busy='0';
			end if;
			wait for 2ns;
			if(busy='1') then
				wait until busy='0';
			end if;
			SCut<="01"; -- cut till height 110
			wait until not(Height="111");
			SCut <="00";
		else
			SCut<="00"; -- don't cut
		end if;
	end process HeightHealthChecker;
	
	HumidityWatering: process 
	begin
		wait for 2ns;
		if(Ci="0000000000") then
			Water1 <="00000000";
		else
			if(Humidity(0)='1') then
				Water1(0)<='0';
			else
				Water1(0)<='1';
			end if;
			if(Humidity(1)='1') then
				Water1(1)<='0';
			else
				Water1(1)<='1';
			end if;
			if(Humidity(2)='1') then
				Water1(2)<='0';
			else
				Water1(2)<='1';
			end if;
			if(Humidity(3)='1') then
				Water1(3)<='0';
			else
				Water1(3)<='1';
			end if;
			if(Humidity(4)='1') then
				Water1(4)<='0';
			else
				Water1(4)<='1';
			end if;
			if(Humidity(5)='1') then
				Water1(5)<='0';
			else
				Water1(5)<='1';
			end if;
			if(Humidity(6)='1') then
				Water1(6)<='0';
			else
				Water1(6)<='1';
			end if;
			if(Humidity(7)='1') then
				Water1(7)<='0';
			else
				Water1(7)<='1';
			end if;
		end if ;
	end process HumidityWatering;
	
	Watering: process (clock)
	begin
		if(Bi="11111") then
			S1 <='1';
		else
			S1 <='0';
		end if;
	end process Watering;
	
	FinalWatering: process
	begin
		--wait until Clock'event;
		wait for 1ns;
		if (S1='1') then
			if(busy='1') then
				wait until busy='0';
			end if;
			wait for 2ns;
			if(busy='1') then
				wait until busy='0';
			end if;
			wait for 2ns;
			if(busy='1') then
				wait until busy='0';
			end if;
			SWater <= "11111111";
			wait until S1='0';
			SWater <= "00000000";
		else
			if (Water1="00000000") then
				SWater <= Water1;
			else
				if(busy='1') then
					wait until busy='0';
				end if;
				wait for 2ns;
				if(busy='1') then
					wait until busy='0';
				end if;
				wait for 2ns;
				if(busy='1') then
					wait until busy='0';
				end if;
				SWater <=Water1;
				wait until (Water1="00000000");
				SWater <="00000000";
			end if ;		
		end if;
	end process FinalWatering;
	
	SeedDispenser : process 
	begin
		wait until S1'event;
		if(S1='1') then
			if(busy='1') then
				wait until busy='0';
			end if;
			wait for 2ns;
			if(busy='1') then
				wait until busy='0';
			end if;
			wait for 2ns;
			if(busy='1') then
				wait until busy='0';
			end if;
			wait for 2ns;
			if(busy='1') then
				wait until busy='0';
			end if;
			SDispense <= '1';
			wait until Days'event;
			SDispense <='0';
		else
			SDispense <= '0';
		end if;
	end process SeedDispenser;
	
	SoilTiller: process 
	begin
		wait until Bi'event;
		if(((Bi="00001") or (Bi="00011")) or (Bi="00101")) then
			if(busy='1') then
				wait until busy='0';
			end if;
			STillSoil <= '1';
			wait until Clock'event;
		else
			STillSoil <= '0';
		end if;
	end process SoilTiller;
	
	Busysetter: process (SCut, SWater, SDispense, STillSoil)
	begin
		if (SCut="00" and SWater="00000000" and SDispense='0' and STillSoil='0') then
			busy <='0';
		else
			busy <='1';
		end if ;
	end process Busysetter;
	
end Crodeators_top_arch;

