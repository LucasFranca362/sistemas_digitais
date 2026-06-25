library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux4x1 is
    Port (
        S : in STD_LOGIC_VECTOR (1 downto 0);
        D : in STD_LOGIC_VECTOR (3 downto 0);
        Y : out STD_LOGIC
    );
end mux4x1;

architecture Behavioral of mux4x1 is
begin

    Y <= (D(0) and (not S(1)) and (not S(0))) or
         (D(1) and (not S(1)) and S(0)) or
         (D(2) and S(1) and (not S(0))) or
         (D(3) and S(1) and S(0));

end Behavioral;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity dec4x16 is
    Port (
        A : in  STD_LOGIC_VECTOR (3 downto 0);
        Y : out STD_LOGIC_VECTOR (15 downto 0)
    );
end dec4x16;

architecture Behavioral of dec4x16 is
begin

    with A select
        Y <= "0000000000000001" when "0000",
             "0000000000000010" when "0001",
             "0000000000000100" when "0010",
             "0000000000001000" when "0011",
             "0000000000010000" when "0100",
             "0000000000100000" when "0101",
             "0000000001000000" when "0110",
             "0000000010000000" when "0111",
             "0000000100000000" when "1000",
             "0000001000000000" when "1001",
             "0000010000000000" when "1010",
             "0000100000000000" when "1011",
             "0001000000000000" when "1100",
             "0010000000000000" when "1101",
             "0100000000000000" when "1110",
             "1000000000000000" when others;

end Behavioral;

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
