library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity testbench is
    port (
        q_dut, q_gm : in  STD_LOGIC;
        D, CLK, PRE, CLR : out STD_LOGIC
    );
end testbench;

architecture testbench_arch of testbench is
begin

    process
    begin

        report "Iniciando teste..." severity NOTE;

        -- Estado inicial
        D   <= '0';
        CLK <= '0';
        PRE <= '0';
        CLR <= '1';

        wait for 100 ns;

        ----------------------------------------------------------------
        -- TESTE 1 : CLEAR
        ----------------------------------------------------------------
        CLR <= '1';
        wait for 100 ns;

        assert (q_dut = q_gm)
        report "Falhou no teste de CLR"
        severity ERROR;

        CLR <= '0';

        ----------------------------------------------------------------
        -- TESTE 2 : PRESET
        ----------------------------------------------------------------
        PRE <= '1';
        wait for 100 ns;

        assert (q_dut = q_gm)
        report "Falhou no teste de PRE"
        severity ERROR;

        PRE <= '0';

        ----------------------------------------------------------------
        -- TESTE 3 : D = 0
        ----------------------------------------------------------------
        D <= '0';

        CLK <= '0';
        wait for 100 ns;

        CLK <= '1';
        wait for 100 ns;

        assert (q_dut = q_gm)
        report "Falhou no teste D = 0"
        severity ERROR;

        ----------------------------------------------------------------
        -- TESTE 4 : D = 1
        ----------------------------------------------------------------
        D <= '1';

        CLK <= '0';
        wait for 100 ns;

        CLK <= '1';
        wait for 100 ns;

        assert (q_dut = q_gm)
        report "Falhou no teste D = 1"
        severity ERROR;

        ----------------------------------------------------------------

        report "Teste finalizado!" severity NOTE;

        wait;

    end process;

end testbench_arch;
