library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tb_mux is
end tb_mux;

architecture testbench_arch of tb_mux is

    -- Entradas
    signal D : STD_LOGIC_VECTOR(7 downto 0);
    signal S : STD_LOGIC_VECTOR(2 downto 0);

    -- Saídas
    signal Y_dut : STD_LOGIC;
    signal Y_gm  : STD_LOGIC;

    -- Sinal de erro (visual)
    signal erro  : STD_LOGIC;

begin

    ----------------------------------------------------------------
    -- INSTÂNCIA DO DUT
    ----------------------------------------------------------------
    DUT: entity work.mux8x1_dut
        port map(
            D => D,
            S => S,
            Y => Y_dut
        );

    ----------------------------------------------------------------
    -- INSTÂNCIA DO GOLDEN MODEL
    ----------------------------------------------------------------
    GM: entity work.mux8x1
        port map(
            D => D,
            S => S,
            Y => Y_gm
        );

    ----------------------------------------------------------------
    -- COMPARAÇÃO VISUAL (XOR)
    ----------------------------------------------------------------
    erro <= Y_dut xor Y_gm;

    ----------------------------------------------------------------
    -- PROCESSO DE TESTE
    ----------------------------------------------------------------
    process
        variable contbin : STD_LOGIC_VECTOR(2 downto 0);
    begin

        report "Iniciando teste..." severity NOTE;

        ----------------------------------------------------------------
        -- TESTE 1
        ----------------------------------------------------------------
        D <= "10101010";
        contbin := "000";

        for i in 0 to 7 loop
            S <= contbin;
            wait for 20 ns;

            assert (Y_gm = Y_dut)
                report "Erro no teste 1 para S = " & integer'image(i)
                severity ERROR;

            contbin := std_logic_vector(unsigned(contbin) + 1);
        end loop;

        ----------------------------------------------------------------
        -- TESTE 2
        ----------------------------------------------------------------
        D <= "11110000";
        contbin := "000";

        for i in 0 to 7 loop
            S <= contbin;
            wait for 20 ns;

            assert (Y_gm = Y_dut)
                report "Erro no teste 2 para S = " & integer'image(i)
                severity ERROR;

            contbin := std_logic_vector(unsigned(contbin) + 1);
        end loop;

        ----------------------------------------------------------------
        -- TESTE 3
        ----------------------------------------------------------------
        D <= "11001100";
        contbin := "000";

        for i in 0 to 7 loop
            S <= contbin;
            wait for 20 ns;

            assert (Y_gm = Y_dut)
                report "Erro no teste 3 para S = " & integer'image(i)
                severity ERROR;

            contbin := std_logic_vector(unsigned(contbin) + 1);
        end loop;

        report "Teste finalizado com sucesso!" severity NOTE;

        wait;

    end process;

end testbench_arch;
