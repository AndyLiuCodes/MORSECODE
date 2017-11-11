Library ieee;
Use ieee.std_logic_1164.all;
Use ieee.numeric_std.all;

Entity addition_operator is
	Port (
		SW : in std_logic_vector(7 downto 0);
		LEDR : out std_logic_vector(4 downto 0) := (others => '0'));
End Entity addition_operator;

Architecture behaviour of addition_operator is

signal OpX, OpY: signed (3 downto 0);
signal Sum: signed(4 downto 0);

begin

OpX<=signed (SW(3 downto 0));
OpY<=signed (SW(7 downto 4));

Sum<= ("0"& OpX)+("0"& OpY);

LEDR<=std_logic_vector (Sum(4 downto 0));

End behaviour;
