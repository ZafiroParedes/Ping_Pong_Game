library IEEE;
use IEEE.STD_LOGIC_SIGNED.all;
use IEEE.STD_LOGIC_1164.all;

entity clkdiv is
	port(original_clk: in STD_LOGIC;
	clr: in STD_LOGIC;
	after_division_clk: out STD_LOGIC);
end clkdiv;

architecture behavior of clkdiv is

signal counter: STD_LOGIC_VECTOR(18 downto 0) := (others => '0'); 
signal clockTemp: STD_LOGIC := '0';

begin
	process(original_clk, clr)
	begin
		if clr = '1' then
			counter <= (others => '0');
			clockTemp <= '0';
		elsif(original_clk'event AND original_clk = '1') then
			counter <= counter + 1;
			
			if counter(18) = '1' then
				clockTemp <= not clockTemp; 
				counter <= (others => '0');
			end if;
			
		end if;	
		
	end process;
	
	after_division_clk <= clockTemp;
	
end behavior;
