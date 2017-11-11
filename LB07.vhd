Library ieee;
Use ieee.std_logic_1164.all;
Use ieee.numeric_std.all;

Entity LB07 is
	Port (
		SW : in std_logic_vector(17 downto 0);
		LEDR : out std_logic_vector(17 downto 0) := (others => '0');
		LEDG : out std_logic_vector(8 downto 0 ) := (others => '0');
		KEY : in std_logic_vector(3 downto 0);
		CLOCK_50 : in std_logic;

		I2C_SDAT : inout std_logic;
		I2C_SCLK, AUD_XCK : out std_logic;
		AUD_ADCDAT : in std_logic;
		AUD_DACDAT : out std_logic;
		AUD_ADCLRCK, AUD_DACLRCK, AUD_BCLK : in std_logic );
End Entity LB07;


Architecture structural of LB07 is

	Signal	AudioIn, AudioOut : signed(15 downto 0);
	Signal	SamClk, Clear, PulseO : std_logic;

Begin

ASSM: Entity work.AudioInterface	generic map ( SID =>  56789)
			port map (
			Clock_50 => CLOCK_50, AudMclk => AUD_XCK,	-- period is 80 ns ( 12.5 Mhz )
			init => KEY(0), 									-- +ve edge initiates I2C data
			I2C_Sclk => I2C_SCLK,
			I2C_Sdat => I2C_SDAT,
			AUD_BCLK => AUD_BCLK, AUD_ADCLRCK => AUD_ADCLRCK, AUD_DACLRCK => AUD_DACLRCK,
			AUD_ADCDAT => AUD_ADCDAT, AUD_DACDAT => AUD_DACDAT,

			AudioOut => AudioOut, AudioIn => AudioIn, SamClk => SamClk );

--AudioOut <= AudioIn;


TestMorseGenerator: entity work.MorseGenerator port map(Clock=>SamClk, PulseOut=> PulseO);
LEDG(0)<= PulseO;	
Clear<= KEY(1) OR not PulseO;
TestToneGenerator: entity work.ToneGenerator port map(Clear, SamClk, unsigned(SW(15 downto 0)), AudioOut);	
End Architecture structural;
