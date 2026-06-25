library ieee;
use ieee.std_logic_1164.all;

entity adder4 is
    port(
        A : in  std_logic_vector(3 downto 0);
        B : in  std_logic_vector(3 downto 0);
        S : out std_logic_vector(4 downto 0)
    );
end entity;

architecture structural of adder4 is

    -- componente
    component full_adder
        port(
            A    : in  std_logic;
            B    : in  std_logic;
            Cin  : in  std_logic;
            S    : out std_logic;
            Cout : out std_logic
        );
    end component;

    -- sinais internos de carry
    signal C : std_logic_vector(3 downto 0);

begin

    -- FA0 (bit menos significativo)
    FA0: full_adder port map(
        A => A(0),
        B => B(0),
        Cin => '0',
        S => S(0),
        Cout => C(0)
    );

    -- FA1
    FA1: full_adder port map(
        A => A(1),
        B => B(1),
        Cin => C(0),
        S => S(1),
        Cout => C(1)
    );

    -- FA2
    FA2: full_adder port map(
        A => A(2),
        B => B(2),
        Cin => C(1),
        S => S(2),
        Cout => C(2)
    );

    -- FA3 (bit mais significativo)
    FA3: full_adder port map(
        A => A(3),
        B => B(3),
        Cin => C(2),
        S => S(3),
        Cout => S(4)  -- carry final vira o bit mais significativo
    );

end architecture;
