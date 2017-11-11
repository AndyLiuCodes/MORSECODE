Library ieee;
Use ieee.std_logic_1164.all;
Use ieee.numeric_std.all;

ENTITY Sequencer IS
	PORT(clk: in std_logic;
			Q: buffer unsigned(5 downto 0));
END;

ARCHITECTURE Behaviour of Sequencer IS
	signal COUNT: unsigned(5 downto 0) := "100001";
BEGIN
	PROCESS(clk)
	BEGIN
		IF rising_edge(clk) THEN
			IF COUNT = "000000" THEN
				COUNT <= "100001";  --RELOAD ON ZERO
			ELSE
				COUNT <= COUNT - 1;
			END IF;
			
		END IF;
		Q <= COUNT;
	END PROCESS;
	
END Behaviour;