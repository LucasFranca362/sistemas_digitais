library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity testbench is
    port(
        S_dut : in  STD_LOGIC_VECTOR(4 downto 0);
        S_gm  : in  STD_LOGIC_VECTOR(4 downto 0);
        A     : out STD_LOGIC_VECTOR(3 downto 0);
        B     : out STD_LOGIC_VECTOR(3 downto 0)
    );
end testbench;

architecture testbench_arch of testbench is
begin

    process

        variable contbin : STD_LOGIC_VECTOR(7 downto 0);

    begin

        report "Iniciando teste..." severity NOTE;

        contbin := "00000000";

        for i in 1 to 256 loop

            -- 4 bits mais significativos para A
            A <= contbin(7 downto 4);

            -- 4 bits menos significativos para B
            B <= contbin(3 downto 0);

            wait for 200 ns;

            assert (S_gm = S_dut)
            report "Falhou: i = " & integer'image(i)
            severity ERROR;

            contbin := contbin + 1;

        end loop;

        report "Teste finalizado!" severity NOTE;

        wait;

    end process;

end testbench_arch;
