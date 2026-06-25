library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity questao2 is
    port(
        reset : in STD_LOGIC;
        clock : in STD_LOGIC;

        T5  : out STD_LOGIC;
        T6  : out STD_LOGIC;
        T20 : out STD_LOGIC;
        T60 : out STD_LOGIC;

        cont_dezena  : out STD_LOGIC_VECTOR(3 downto 0);
        cont_unidade : out STD_LOGIC_VECTOR(3 downto 0)
    );
end questao2;
architecture estrutural of questao2 is

component contador_0_99
    port(
        clock   : in STD_LOGIC;
        reset   : in STD_LOGIC;
        enable  : in STD_LOGIC;
        rci     : in STD_LOGIC;
        load    : in STD_LOGIC;

        D_dez   : in STD_LOGIC_VECTOR(3 downto 0);
        D_uni   : in STD_LOGIC_VECTOR(3 downto 0);

        Q_dez   : out STD_LOGIC_VECTOR(3 downto 0);
        Q_uni   : out STD_LOGIC_VECTOR(3 downto 0);

        rco_out : out STD_LOGIC
    );
end component;

component timeflags
    port(
        cont_dezena  : in STD_LOGIC_VECTOR(3 downto 0);
        cont_unidade : in STD_LOGIC_VECTOR(3 downto 0);

        T5  : out STD_LOGIC;
        T6  : out STD_LOGIC;
        T20 : out STD_LOGIC;
        T60 : out STD_LOGIC
    );
end component;

signal dezena_int  : STD_LOGIC_VECTOR(3 downto 0);
signal unidade_int : STD_LOGIC_VECTOR(3 downto 0);

signal rco_dummy : STD_LOGIC;

begin

    CONTADOR100 : contador_0_99
    port map(
        clock   => clock,
        reset   => reset,
        enable  => '0',
        rci     => '0',
        load    => '0',

        D_dez   => "0000",
        D_uni   => "0000",

        Q_dez   => dezena_int,
        Q_uni   => unidade_int,

        rco_out => rco_dummy
    );

    FLAGS : timeflags
    port map(
        cont_dezena  => dezena_int,
        cont_unidade => unidade_int,

        T5  => T5,
        T6  => T6,
        T20 => T20,
        T60 => T60
    );

    cont_dezena  <= dezena_int;
    cont_unidade <= unidade_int;

end estrutural;
