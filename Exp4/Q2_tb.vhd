library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_func_bool1 is
end tb_func_bool1;

architecture sim of tb_func_bool1 is
    component func_bool1
        Port (
            A, B, C, D : in  STD_LOGIC;
            E, F, G    : in  STD_LOGIC;
            S          : out STD_LOGIC
        );
    end component;
    signal A, B, C, D : STD_LOGIC := '0';
    signal E, F, G    : STD_LOGIC := '0';
    signal S          : STD_LOGIC;
begin
    DUT : func_bool1
        port map (
            A => A,
            B => B,
            C => C,
            D => D,
            E => E,
            F => F,
            G => G,
            S => S
        );

    A <= not A after 10 ns;
    B <= not B after 20 ns;
    C <= not C after 40 ns;
    D <= not D after 80 ns;

    E <= not E after 160 ns;
    F <= not F after 320 ns;
    G <= not G after 640 ns;

    process
    begin
        wait for 1280 ns;
        wait;
    end process;

end sim;
