library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_maquina_refrigerante is
end tb_maquina_refrigerante;

architecture sim of tb_maquina_refrigerante is

    component maquina_refrigerante
        Port (
            clk      : in  STD_LOGIC;
            reset    : in  STD_LOGIC;
            A        : in  STD_LOGIC_VECTOR(1 downto 0);
            s_refri  : out STD_LOGIC;
            s_25     : out STD_LOGIC;
            s_50     : out STD_LOGIC
        );
    end component;

    signal clk      : STD_LOGIC := '0';
    signal reset    : STD_LOGIC := '0';
    signal A        : STD_LOGIC_VECTOR(1 downto 0) := "00";

    signal s_refri  : STD_LOGIC;
    signal s_25     : STD_LOGIC;
    signal s_50     : STD_LOGIC;

begin

    ------------------------------------------------------------------
    -- DUT
    ------------------------------------------------------------------
    DUT : maquina_refrigerante
    port map (
        clk      => clk,
        reset    => reset,
        A        => A,
        s_refri  => s_refri,
        s_25     => s_25,
        s_50     => s_50
    );

    ------------------------------------------------------------------
    -- CLOCK (20 ns)
    ------------------------------------------------------------------
    clk <= not clk after 10 ns;

    ------------------------------------------------------------------
    -- ESTÍMULOS
    ------------------------------------------------------------------
    process
    begin

        --------------------------------------------------------------
        -- RESET
        --------------------------------------------------------------
        reset <= '1';
        A <= "00";

        wait for 30 ns;

        reset <= '0';

        wait until rising_edge(clk);

        --------------------------------------------------------------
        -- TESTE 1
        -- INIT -> E25C
        --------------------------------------------------------------
        A <= "01";
        wait until rising_edge(clk);

        --------------------------------------------------------------
        -- TESTE 2
        -- E25C -> E50C
        --------------------------------------------------------------
        A <= "01";
        wait until rising_edge(clk);

        --------------------------------------------------------------
        -- TESTE 3
        -- E50C -> E75C
        --------------------------------------------------------------
        A <= "01";
        wait until rising_edge(clk);

        --------------------------------------------------------------
        -- TESTE 4
        -- E75C -> E100C
        -- Deve liberar refrigerante
        --------------------------------------------------------------
        A <= "01";
        wait until rising_edge(clk);

        A <= "00";
        wait until rising_edge(clk);

        --------------------------------------------------------------
        -- TESTE 5
        -- Caminho até E125C
        -- INIT -> E50C -> E75C -> E125C
        -- Deve liberar refrigerante + devolver 25
        --------------------------------------------------------------
        A <= "10";
        wait until rising_edge(clk);

        A <= "01";
        wait until rising_edge(clk);

        A <= "10";
        wait until rising_edge(clk);

        A <= "00";
        wait until rising_edge(clk);

        --------------------------------------------------------------
        -- TESTE 6
        -- Cancelamento com 25 centavos
        --------------------------------------------------------------
        A <= "01";
        wait until rising_edge(clk);

        A <= "11";
        wait until rising_edge(clk);

        A <= "00";
        wait until rising_edge(clk);

        --------------------------------------------------------------
        -- TESTE 7
        -- Cancelamento com 50 centavos
        --------------------------------------------------------------
        A <= "10";
        wait until rising_edge(clk);

        A <= "11";
        wait until rising_edge(clk);

        A <= "00";
        wait until rising_edge(clk);

        --------------------------------------------------------------
        -- TESTE 8
        -- Cancelamento com 75 centavos
        --------------------------------------------------------------
        A <= "10";
        wait until rising_edge(clk);

        A <= "01";
        wait until rising_edge(clk);

        A <= "11";
        wait until rising_edge(clk);

        A <= "00";
        wait until rising_edge(clk);

        --------------------------------------------------------------
        -- FIM DA SIMULAÇÃO
        --------------------------------------------------------------
        wait;

    end process;

end sim;
