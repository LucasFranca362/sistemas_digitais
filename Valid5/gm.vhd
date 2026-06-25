library ieee;
use IEEE.STD_LOGIC_1164.ALL;

entity paridade_gm is
   Port(
	A: in std_logic_vector(3 downto 0);
	P: out std_logic
   );
end paridade_gm;

architecture structural of paridade_gm is
	
begin 
	P <= not (((A(0) xor A(1)) xor A(2)) xor A(3)); 

end structural;
