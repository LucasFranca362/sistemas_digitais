library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux8x1 is
    Port (
        S : in  STD_LOGIC_VECTOR (2 downto 0); -- seletor
        D : in  STD_LOGIC_VECTOR (7 downto 0); -- entradas
        Y : out STD_LOGIC                     -- saída
    );
end mux8x1;

architecture Behavioral of mux8x1 is
begin

    Y <= D(0) when S = "000" else
         D(1) when S = "001" else
         D(2) when S = "010" else
         D(3) when S = "011" else
         D(4) when S = "100" else
         D(5) when S = "101" else
         D(6) when S = "110" else
         D(7); -- quando S = "111"

end Behavioral;
