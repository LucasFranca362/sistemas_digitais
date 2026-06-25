library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity testbench is
    port(
        erro_S    : in  STD_LOGIC;
        erro_Cout : in  STD_LOGIC;

        A   : out STD_LOGIC;
        B   : out STD_LOGIC;
        Cin : out STD_LOGIC
    );
end testbench;

architecture testbench_arch of testbench is
begin

    process

        variable contbin : STD_LOGIC_VECTOR(2 downto 0);

    begin

        report "Iniciando teste..." severity NOTE;

        contbin := "000";

        for i in 1 to 8 loop

            A   <= contbin(2);
            B   <= contbin(1);
            Cin <= contbin(0);

            wait for 50 ns;

            assert (erro_S = '0')
            report "Falhou na saida S! i = " & integer'image(i)
            severity ERROR;

            assert (erro_Cout = '0')
            report "Falhou na saida Cout! i = " & integer'image(i)
            severity ERROR;

            contbin := contbin + 1;

        end loop;

        report "Teste finalizado!" severity NOTE;

        wait;

    end process;

end testbench_arch;
