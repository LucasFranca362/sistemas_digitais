library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity tb_contador_bcd_100 is
end tb_contador_bcd_100;

architecture behavior of tb_contador_bcd_100 is

    -- 1. Declaração do componente agora idêntica à entidade original
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

    -- 2. Criação de todos os sinais internos necessários
    signal clock   : STD_LOGIC := '0';
    signal reset   : STD_LOGIC := '0';
    signal enable  : STD_LOGIC := '0'; -- Forçado a 0 para permitir contagem
    signal rci     : STD_LOGIC := '0'; -- Forçado a 0 para permitir contagem
    signal load    : STD_LOGIC := '0';
    signal D_dez   : STD_LOGIC_VECTOR(3 downto 0) := "0000";
    signal D_uni   : STD_LOGIC_VECTOR(3 downto 0) := "0000";
    signal Q_dez   : STD_LOGIC_VECTOR(3 downto 0);
    signal Q_uni   : STD_LOGIC_VECTOR(3 downto 0);
    signal rco_out : STD_LOGIC;

    constant periodo_clock : time := 10 ns;

begin

    -- 3. Mapeamento de portas completo (Port Map)
    DUT: contador_0_99 port map (
        clock   => clock,
        reset   => reset,
        enable  => enable,
        rci     => rci,
        load    => load,
        D_dez   => D_dez,
        D_uni   => D_uni,
        Q_dez   => Q_dez,
        Q_uni   => Q_uni,
        rco_out => rco_out
    );

    processo_clock : process
    begin
        while true loop
            clock <= '0';
            wait for periodo_clock/2;
            clock <= '1';
            wait for periodo_clock/2;
        end loop;
    end process;

    processo_estimulos : process
    begin
        -- Estado inicial de Reset
        reset <= '1';
        wait for 20 ns;
        
        -- Libera o Reset e garante que os controles permitem a contagem
        reset <= '0';
        enable <= '0';
        rci <= '0';
        load <= '0';
        
        -- Tempo suficiente para contar até 99 e resetar/virar
        wait for 1100 ns;
        
        -- Testa outro reset no meio da operação
        reset <= '1';
        wait for 20 ns;
        reset <= '0';
        wait for 300 ns;
        
        wait;
    end process;
end behavior;
