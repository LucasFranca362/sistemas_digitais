library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity topmodule is
end topmodule;

architecture estrutural of topmodule is



    component testbench
        port(
            clock : out STD_LOGIC;
            reset : out STD_LOGIC
        );
    end component;

    component relogio
        port(
            clock   : in STD_LOGIC;
            reset   : in STD_LOGIC;

            segundo : out STD_LOGIC_VECTOR(7 downto 0);
            minuto  : out STD_LOGIC_VECTOR(7 downto 0);
            hora    : out STD_LOGIC_VECTOR(7 downto 0)
        );
    end component;

    component relogio_gm
        port(
            clock    : in STD_LOGIC;
            reset    : in STD_LOGIC;
            enable   : in STD_LOGIC;

            segundos : out STD_LOGIC_VECTOR(7 downto 0);
            minutos  : out STD_LOGIC_VECTOR(7 downto 0);
            horas    : out STD_LOGIC_VECTOR(7 downto 0)
        );
    end component;


    signal clock_s : STD_LOGIC;
    signal reset_s : STD_LOGIC;

    signal segundo_dut : STD_LOGIC_VECTOR(7 downto 0);
    signal minuto_dut  : STD_LOGIC_VECTOR(7 downto 0);
    signal hora_dut    : STD_LOGIC_VECTOR(7 downto 0);

    signal segundo_gm : STD_LOGIC_VECTOR(7 downto 0);
    signal minuto_gm  : STD_LOGIC_VECTOR(7 downto 0);
    signal hora_gm    : STD_LOGIC_VECTOR(7 downto 0);

    signal erro_segundo : STD_LOGIC;
    signal erro_minuto  : STD_LOGIC;
    signal erro_hora    : STD_LOGIC;

begin


    TB : testbench
    port map(
        clock => clock_s,
        reset => reset_s
    );



    DUT : relogio
    port map(
        clock   => clock_s,
        reset   => reset_s,
        segundo => segundo_dut,
        minuto  => minuto_dut,
        hora    => hora_dut
    );


    GM : relogio_gm
    port map(
        clock    => clock_s,
        reset    => reset_s,
        enable   => '0',
        segundos => segundo_gm,
        minutos  => minuto_gm,
        horas    => hora_gm
    );

    ------------------------------------------------------------------
    -- COMPARADORES
    ------------------------------------------------------------------

    erro_segundo <= '1'
                    when (segundo_dut /= segundo_gm)
                    else '0';

    erro_minuto <= '1'
                   when (minuto_dut /= minuto_gm)
                   else '0';

    erro_hora <= '1'
                 when (hora_dut /= hora_gm)
                 else '0';

end estrutural;
