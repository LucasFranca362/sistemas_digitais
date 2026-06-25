library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity testbench is
    port(
        clock : out STD_LOGIC;
        reset : out STD_LOGIC
    );
end testbench;

architecture behavior of testbench is
    signal clk_int : STD_LOGIC := '0';
begin

    clk_int <= not clk_int after 2 ns;

    clock <= clk_int;

    process
    begin
        reset <= '1';
        wait for 20 ns;

        reset <= '0';

        wait;
    end process;

end behavior;
