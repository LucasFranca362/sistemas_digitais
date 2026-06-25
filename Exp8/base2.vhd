library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity timeflags is
    port(
        cont_dezena  : in STD_LOGIC_VECTOR(3 downto 0);
        cont_unidade : in STD_LOGIC_VECTOR(3 downto 0);

        T5  : out STD_LOGIC;
        T6  : out STD_LOGIC;
        T20 : out STD_LOGIC;
        T60 : out STD_LOGIC
    );
end timeflags;

architecture comportamental of timeflags is

    signal contador_bcd : STD_LOGIC_VECTOR(7 downto 0);

begin

    contador_bcd <= cont_dezena & cont_unidade;

    T5  <= '1' when contador_bcd >= x"05" else '0';

    T6  <= '1' when contador_bcd >= x"06" else '0';

    T20 <= '1' when contador_bcd >= x"20" else '0';

    T60 <= '1' when contador_bcd >= x"60" else '0';

end comportamental;
