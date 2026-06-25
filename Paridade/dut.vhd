library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity paridade is
   Port(
	A: in std_logic_vector(3 downto 0);
	P: out std_logic
   );
end paridade;

architecture structural of paridade is
	signal x1: std_logic;
	signal x2: std_logic;
	signal x3: std_logic;

begin 
	x1 <= (A(0) xor A(1));
	x2 <= x1 xor A(2);
	x3 <= x2 xor A(3);
	P <= not x3; 

end structural;


