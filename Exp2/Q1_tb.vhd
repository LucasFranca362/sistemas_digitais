library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_somador is
end tb_somador;

architecture teste of tb_somador is

    component somador_completo
        Port (
            A    : in  STD_LOGIC;
            B    : in  STD_LOGIC;
            Cin  : in  STD_LOGIC;
            S    : out STD_LOGIC;
            Cout : out STD_LOGIC
        );
    end component;

    signal A, B, Cin : STD_LOGIC := '0';
    signal S, Cout   : STD_LOGIC;

begin

    -- Instanciação do circuito
    uut: somador_completo
        port map (
            A => A,
            B => B,
            Cin => Cin,
            S => S,
            Cout => Cout
        );

    -- Geração automática de sinais (tipo clock)

    A   <= not A   after 40 ns;
    B   <= not B   after 20 ns;
    Cin <= not Cin after 10 ns;

end teste;
