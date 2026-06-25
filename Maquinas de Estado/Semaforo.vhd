library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity exp8visto3 is
    port(
        ligadesliga : in STD_LOGIC;
        sensorA     : in STD_LOGIC;
        sensorB     : in STD_LOGIC;
        clock       : in STD_LOGIC;
        cont_dezena  : out STD_LOGIC_VECTOR(3 downto 0);
        cont_unidade : out STD_LOGIC_VECTOR(3 downto 0);
        semaforoA : out STD_LOGIC_VECTOR(2 downto 0);
        semaforoB : out STD_LOGIC_VECTOR(2 downto 0)
    );
end exp8visto3;
architecture estrutural of exp8visto3 is
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
component maqestados
    port(
        ligadesliga : in STD_LOGIC;
        clock       : in STD_LOGIC;
        sensorA     : in STD_LOGIC;
        sensorB     : in STD_LOGIC;
        T5          : in STD_LOGIC;
        T6          : in STD_LOGIC;
        T20         : in STD_LOGIC;
        T60         : in STD_LOGIC;
        resetcounter : out STD_LOGIC;
        semaforoA : out STD_LOGIC_VECTOR(2 downto 0);
        semaforoB : out STD_LOGIC_VECTOR(2 downto 0)
    );
end component;
signal dezena_int  : STD_LOGIC_VECTOR(3 downto 0);
signal unidade_int : STD_LOGIC_VECTOR(3 downto 0);
signal T5_int  : STD_LOGIC;
signal T6_int  : STD_LOGIC;
signal T20_int : STD_LOGIC;
signal T60_int : STD_LOGIC;
signal resetcounter_int : STD_LOGIC;
signal rco_dummy : STD_LOGIC;
begin
CONTADOR : contador_0_99
port map(
    clock   => clock,
    reset   => resetcounter_int,
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

    T5  => T5_int,
    T6  => T6_int,
    T20 => T20_int,
    T60 => T60_int
);
FSM : maqestados
port map(
    ligadesliga => ligadesliga,
    clock       => clock,
    sensorA     => sensorA,
    sensorB     => sensorB,

    T5  => T5_int,
    T6  => T6_int,
    T20 => T20_int,
    T60 => T60_int,

    resetcounter => resetcounter_int,

    semaforoA => semaforoA,
    semaforoB => semaforoB
);
cont_dezena  <= dezena_int;
cont_unidade <= unidade_int;

end estrutural;