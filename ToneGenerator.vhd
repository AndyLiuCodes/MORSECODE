LIBRARY ieee;
USE ieee.std_logic_1164.all;
Use ieee.numeric_std.all;

ENTITY ToneGenerator IS
	PORT (clear, clock: in std_logic;
			Freq			: in unsigned(15 downto 0);
			WaveOut		: out signed(15 downto 0));
END ToneGenerator;

ARCHITECTURE behaviour of ToneGenerator IS
	SIGNAL temp: signed(21 downto 0) := (others => '0');
BEGIN
	PROCESS(clear, clock)
	BEGIN
		if rising_edge(clock) then
			if clear = '0' then
				temp <= (others => '0');
			else
				temp <= signed((Freq & "000000")) + signed(temp);
			end if;
		end if;
	END PROCESS;
	
	WaveOut <= temp(21 downto 6);
END behaviour;