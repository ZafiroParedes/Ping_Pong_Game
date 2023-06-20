library IEEE;
use IEEE.STD_LOGIC_SIGNED.all;
use IEEE.STD_LOGIC_1164.all;

entity clklevel is
	port(adjustedclk: in STD_LOGIC;
	clr: in STD_LOGIC;
	level: in integer;
	currlevelclk: out STD_LOGIC);
end clklevel;

architecture behavior of clklevel is

signal counter: integer := 0; 
signal clockTemp: STD_LOGIC := '0';

begin
	process(adjustedclk, clr, level)
	begin
		if clr = '1' then
			counter <= 0;
			clockTemp <= '0';
		elsif(adjustedclk'event AND adjustedclk = '1') then
			counter <= counter + 1;
			
			if counter = (30 - (2 *level)) then
				clockTemp <= not clockTemp; 
				counter <= 0;
			end if;
			
		end if;	
		
	end process;
	
	currlevelclk <= clockTemp;
	
end behavior;
