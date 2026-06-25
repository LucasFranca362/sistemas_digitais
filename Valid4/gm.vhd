library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity somador_completo is
    Port (
        A    : in  STD_LOGIC;
        B    : in  STD_LOGIC;
        Cin  : in  STD_LOGIC;
        S    : out STD_LOGIC;
        Cout : out STD_LOGIC
    );
end somador_completo;

architecture comportamento of somador_completo is
begin

    -- Soma
    S <= A xor B xor Cin;

    -- Vai-um
    Cout <= (A and B) or (A and Cin) or (B and Cin);

end comportamento;
