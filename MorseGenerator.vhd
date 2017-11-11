Library ieee;
Use ieee.std_logic_1164.all;
Use ieee.numeric_std.all;

Entity MorseGenerator is
	Port (
		Clock : in std_logic;
		PulseOut: out std_logic ;
		registr: buffer signed(13 downto 0);
		Seq : buffer unsigned (5 downto 0));
End Entity MorseGenerator;


ARCHITECTURE behaviour of MorseGenerator IS
	SIGNAL SlowClock: std_logic;
BEGIN
	PROCESS (Clock)
	BEGIN
	IF rising_edge(Clock) then
			registr <= registr + 1; ---"00000000000001";
	END IF;
	END PROCESS;
	
	SlowClock <= registr(13);

	--PulseOut <= SlowClock; -- TEMPORARY CONNECTION

Sequencer_Connection: work.Sequencer port map(SlowClock, Seq);
	
	WITH Seq SELECT PulseOut <= 
		'1' when "100001",
		'1' when "011111",
		'1' when "011101",
		'1' when "011001",
		'1' when "011000",
		'1' when "010111",
		'1' when "010101",
		'1' when "010100",
		'1' when "010011",
		'1' when "010001",
		'1' when "010000",
		'1' when "001111",
		'1' when "001011",
		'1' when "001001",
		'1' when "000111",
		'0' when others;
	---or using conditional assignment 
	--pulseout <= '1' when (sequencerreg = "100001" 
--						    or sequencerreg = "011111"
---						 or sequencerreg = "011101"
---						 or sequencerreg = "011001"
---						 or sequencerreg = "011000"
---						 or sequencerreg = "010111"	
---						 or sequencerreg = "010101"
---						 or sequencerreg = "010100"
---						 or sequencerreg = "010011"
---						 or sequencerreg = "010001"
---						 or sequencerreg = "010000"
---						 or sequencerreg = "001111"
---						 or sequencerreg = "001011"
---						 or sequencerreg = "001001"
---						 or sequencerreg = "000111") else '0';
END behaviour;
