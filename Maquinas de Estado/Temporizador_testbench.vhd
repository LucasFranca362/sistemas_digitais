library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_questao2 is
end tb_questao2;

architecture behavior of tb_questao2 is

    ----------------------------------------------------------------
    -- Componente sob teste
    ----------------------------------------------------------------
    component questao2
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
    end component;

    ----------------------------------------------------------------
    -- Sinais
    ----------------------------------------------------------------
    signal reset : STD_LOGIC := '0';
    signal clock : STD_LOGIC := '0';

    signal T5  : STD_LOGIC;
    signal T6  : STD_LOGIC;
    signal T20 : STD_LOGIC;
    signal T60 : STD_LOGIC;

    signal cont_dezena  : STD_LOGIC_VECTOR(3 downto 0);
    signal cont_unidade : STD_LOGIC_VECTOR(3 downto 0);

    constant periodo_clock : time := 10 ns;

begin

    ----------------------------------------------------------------
    -- Instanciação do DUT
    ----------------------------------------------------------------
    DUT : questao2
    port map(
        reset => reset,
        clock => clock,

        T5  => T5,
        T6  => T6,
        T20 => T20,
        T60 => T60,

        cont_dezena  => cont_dezena,
        cont_unidade => cont_unidade
    );

    ----------------------------------------------------------------
    -- Geração do clock
    ----------------------------------------------------------------
    processo_clock : process
    begin
        while true loop
            clock <= '0';
            wait for periodo_clock/2;

            clock <= '1';
            wait for periodo_clock/2;
        end loop;
    end process;


    ----------------------------------------------------------------
    -- Estímulos
    ----------------------------------------------------------------
    processo_estimulos : process
    begin

        -- Reset síncrono
        reset <= '1';
        wait for 20 ns;

        reset <= '0';

        -- Permitir a contagem de 0 até 99
        wait for 1100 ns;

        -- Novo reset
        reset <= '1';
        wait for 20 ns;

        reset <= '0';

        -- Mais alguns ciclos
        wait for 100 ns;

        wait;

    end process;

end behavior;
