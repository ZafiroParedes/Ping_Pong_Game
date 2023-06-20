library IEEE;
use IEEE.STD_LOGIC_SIGNED.all;
use IEEE.STD_LOGIC_1164.all;
use IEEE.numeric_std.all;

entity pingpong is
	port( originalclk, clr:in std_logic;
	left_switch, right_switch: in std_logic;
	LEDs: out std_logic_vector(9 downto 0);
	sevenseg1, sevenseg2:out std_logic_vector(6 downto 0));
end pingpong;

architecture behav of pingpong is

component pingponggame is
	port( adjustedclk, clr:in std_logic;
	left_switch, right_switch: in std_logic;
	oldlevel: in integer;
	newlevel: out integer;
	LEDs: out std_logic_vector(9 downto 0));
end component;

component clkdiv is
	port(original_clk: in STD_LOGIC;
	clr: in STD_LOGIC;
	after_division_clk: out STD_LOGIC);
end component;

component clklevel is
	port(adjustedclk: in STD_LOGIC;
	clr: in STD_LOGIC;
	level: in integer;
	currlevelclk: out STD_LOGIC);
end component;

component Display is
	port(Input: in std_logic_vector(3 downto 0); --input from calc
	segmentSeven : out std_logic_vector(6 downto 0)); --7 bit output end Display_Ckt;
end component;

signal levelingup: integer := 0;
signal leveldis: std_logic_vector(7 downto 0);
signal adjustedclock: std_logic;
signal currlevelclock: std_logic;

begin

	clock: clkdiv port map(originalclk, clr, adjustedclock);
	levelclock: clklevel port map(adjustedclock, clr, levelingup, currlevelclock);
	leveldis <= std_logic_vector(to_unsigned(levelingup, 8));
	game: pingponggame port map(currlevelclock, clr, left_switch, right_switch, levelingup, levelingup, LEDs); 
	sevSeg1: Display port map(leveldis(3 downto 0), sevenseg1);
	sevSeg2: Display port map(leveldis(7 downto 4), sevenseg2);

end behav;
