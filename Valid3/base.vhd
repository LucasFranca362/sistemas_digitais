library IEEE;
use ieee.std_logic_1164.all;

entity mux4x1 is
    port(
	S : in std_logic_vector(1 downto 0);
	D : in std_logic_vector(3 downto 0);
	Y : out std_logic
    );
end mux4x1;

architecture Behavioral of mux4x1 is
begin

	Y <= (D(0) and (not S(1)) and (not S(0))) or
	     (D(1) and (not S(1)) and S(0)) or
	     (D(2) and S(1) and (not S(0))) or 
	     (D(3) and S(1) and S(0));

end Behavioral;