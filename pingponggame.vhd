library IEEE;
use IEEE.STD_LOGIC_SIGNED.all;
use IEEE.STD_LOGIC_1164.all;
use IEEE.numeric_std.all;

entity pingponggame is
	port( adjustedclk, clr:in std_logic;
	left_switch, right_switch: in std_logic;
	oldlevel: in integer;
	newlevel: out integer;
	LEDs: out std_logic_vector(9 downto 0));
end pingponggame;

architecture behav of pingponggame is

signal LEDsect: std_logic_vector (9 downto 0) := "1000000000";
signal updown: std_logic := '0';
signal stop: std_logic := '0';

begin
	process(clr, stop, adjustedclk, left_switch, right_switch, oldlevel, LEDsect) 
	begin
		if clr = '1' then
			LEDsect <= "0100000000";
			updown <= '0';
			stop <= '0';
			newlevel <= 0;
		elsif(adjustedclk'event AND adjustedclk = '1') then

			if (LEDsect(9) = '1') then --left side hit
				if (left_switch = '1' and right_switch = '0') then -- not cheating with both sw
					updown <= '0';
				else -- end game
					LEDsect <= (others =>'1');
					stop <= '1';
				end if;
				
			elsif (LEDsect(0) = '1') then -- right side hit
				if (left_switch = '0' and right_switch = '1') then -- not cheating
					updown <= '1';
				else -- end game
					LEDsect <= (others =>'1');
					stop <= '1';
				end if;
			end if;
			
			if stop = '0' then
				if updown = '0' and LEDsect(0) = '0' then 
					LEDsect <= std_logic_vector(shift_right(unsigned(LEDsect), 1));
					
					if LEDsect(9) = '1' then --updating the level, finished round
						newlevel <= oldlevel + 1;
					end if;
					
				elsif updown = '1' and LEDsect(9) = '0'then
					LEDsect <= std_logic_vector(shift_left(unsigned(LEDsect), 1));
				end if;
			
			end if;
			
		end if;
		
	end process;
	
	LEDs <= LEDsect;

end behav;
