library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_mux4x1 is
end tb_mux4x1;

architecture test of tb_mux4x1 is

    signal S   : STD_LOGIC_VECTOR (1 downto 0);
    signal D   : STD_LOGIC_VECTOR (3 downto 0);
    signal Y   : STD_LOGIC;
    signal clk : STD_LOGIC := '0';

begin

    -- Geração do clock (período = 10 ns)
    clk <= not clk after 5 ns;

    uut: entity work.mux4x1
        port map (
            S => S,
            D => D,
            Y => Y
        );

    stim_proc: process
    begin
        -- Teste 1
        D <= "1010"; S <= "00"; wait for 5 ns;
        S <= "01"; wait for 5 ns;
        S <= "10"; wait for 5 ns;
        S <= "11"; wait for 5 ns;

        -- Teste 2
        D <= "1100"; S <= "00"; wait for 5 ns;
        S <= "01"; wait for 5 ns;
        S <= "10"; wait for 5 ns;
        S <= "11"; wait for 5 ns;

        wait;
    end process;

end test;
