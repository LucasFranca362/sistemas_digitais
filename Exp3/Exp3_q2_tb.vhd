library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tb_dec4x16 is
end tb_dec4x16;

architecture sim of tb_dec4x16 is

    signal clk : STD_LOGIC := '0';
    signal A   : STD_LOGIC_VECTOR (3 downto 0);
    signal Y   : STD_LOGIC_VECTOR (15 downto 0);

begin

    uut: entity work.dec4x16
        port map (
            A => A,
            Y => Y
        );

    clk <= not clk after 5 ns;

    process
    begin

        for i in 0 to 15 loop
            A <= std_logic_vector(to_unsigned(i, 4));
            wait until rising_edge(clk);
        end loop;

        wait;
    end process;

end sim;
