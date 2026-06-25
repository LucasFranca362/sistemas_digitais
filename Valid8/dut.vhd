library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity relogio is
    port(
        clock   : in STD_LOGIC;
        reset   : in STD_LOGIC;

        segundo : out STD_LOGIC_VECTOR(7 downto 0); -- Saída unificada 8 bits
        minuto  : out STD_LOGIC_VECTOR(7 downto 0); -- Saída unificada 8 bits
        hora    : out STD_LOGIC_VECTOR(7 downto 0)
    );
end relogio;

architecture estrutural of relogio is

    component contador0a9
        port(
            clock  : in STD_LOGIC;
            reset  : in STD_LOGIC;
            enable : in STD_LOGIC;
            rci    : in STD_LOGIC;
            load   : in STD_LOGIC;
            D      : in STD_LOGIC_VECTOR(3 downto 0);
            Q      : out STD_LOGIC_VECTOR(3 downto 0);
            rco    : out STD_LOGIC
        );
    end component;

    component contador0a6
        port(
            clock  : in STD_LOGIC;
            reset  : in STD_LOGIC;
            enable : in STD_LOGIC;
            rci    : in STD_LOGIC;
            load   : in STD_LOGIC;
            D      : in STD_LOGIC_VECTOR(3 downto 0);
            Q      : out STD_LOGIC_VECTOR(3 downto 0);
            rco    : out STD_LOGIC
        );
    end component;

    component contador0a23_bcd
        port(
            clock  : in STD_LOGIC;
            reset  : in STD_LOGIC;
            enable : in STD_LOGIC;
            rci    : in STD_LOGIC;
            load   : in STD_LOGIC;
            D      : in STD_LOGIC_VECTOR(7 downto 0);
            Q      : out STD_LOGIC_VECTOR(7 downto 0);
            rco    : out STD_LOGIC
        );
    end component;

    signal rco_su : STD_LOGIC;
    signal rco_sd : STD_LOGIC;
    signal rco_mu : STD_LOGIC;
    signal rco_md : STD_LOGIC;

    -- Sinais internos para receber os 4 bits de cada contador
    signal seg_u_int : STD_LOGIC_VECTOR(3 downto 0);
    signal seg_d_int : STD_LOGIC_VECTOR(3 downto 0);
    signal min_u_int : STD_LOGIC_VECTOR(3 downto 0);
    signal min_d_int : STD_LOGIC_VECTOR(3 downto 0);
    
    signal hora_int  : STD_LOGIC_VECTOR(7 downto 0);

begin

    SEG_UNID : contador0a9
    port map(
        clock  => clock,
        reset  => reset,
        enable => '0',
        rci    => '0',
        load   => '0',
        D      => "0000",
        Q      => seg_u_int, 
        rco    => rco_su
    );

    SEG_DEZ : contador0a6
    port map(
        clock  => clock,
        reset  => reset,
        enable => '0',
        rci    => rco_su,
        load   => '0',
        D      => "0000",
        Q      => seg_d_int, 
        rco    => rco_sd
    );

    MIN_UNID : contador0a9
    port map(
        clock  => clock,
        reset  => reset,
        enable => '0',
        rci    => rco_sd,
        load   => '0',
        D      => "0000",
        Q      => min_u_int,
        rco    => rco_mu
    );

    MIN_DEZ : contador0a6
    port map(
        clock  => clock,
        reset  => reset,
        enable => '0',
        rci    => rco_mu,
        load   => '0',
        D      => "0000",
        Q      => min_d_int, 
        rco    => rco_md
    );

    HORAS : contador0a23_bcd
    port map(
        clock  => clock,
        reset  => reset,
        enable => '0',
        rci    => rco_md,
        load   => '0',
        D      => "00000000",
        Q      => hora_int,
        rco    => open
    );

    ------------------------------------------------------------------
    -- ATRIBUIÇÃO ÀS SAÍDAS FINAIS (CONCATENAÇÃO BCD)
    ------------------------------------------------------------------
    segundo <= seg_d_int & seg_u_int; -- Junta a dezena (4 bits) e a unidade (4 bits)
    minuto  <= min_d_int & min_u_int; -- Junta a dezena (4 bits) e a unidade (4 bits)
    hora    <= hora_int;

end estrutural;
