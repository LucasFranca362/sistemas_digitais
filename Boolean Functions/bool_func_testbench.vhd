library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_func_bool is
end tb_func_bool;

architecture sim of tb_func_bool is
    component func_bool
        Port (
            A : in  STD_LOGIC;
            B : in  STD_LOGIC;
            C : in  STD_LOGIC;
            X : out STD_LOGIC;
            Y : out STD_LOGIC
        );
    end component;

    signal A : STD_LOGIC := '0';
    signal B : STD_LOGIC := '0';
    signal C : STD_LOGIC := '0';

    signal X : STD_LOGIC;
    signal Y : STD_LOGIC;

begin
T
    DUT : func_bool
        port map(
            A => A,
            B => B,
            C => C,
            X => X,
            Y => Y
        );
    -- A troca a cada 40 ns
    A <= not A after 40 ns;

    -- B troca a cada 20 ns
    B <= not B after 20 ns;

    -- C troca a cada 10 ns
    C <= not C after 10 ns;

end sim;
