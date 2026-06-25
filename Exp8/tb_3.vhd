library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity tb_questao3 is
end tb_questao3;
architecture behavior of tb_questao3 is
    component exp8visto3
        port(
            ligadesliga : in STD_LOGIC;
            sensorA     : in STD_LOGIC;
            sensorB     : in STD_LOGIC;
            clock       : in STD_LOGIC;
            cont_dezena  : out STD_LOGIC_VECTOR(3 downto 0);
            cont_unidade : out STD_LOGIC_VECTOR(3 downto 0);
            semaforoA : out STD_LOGIC_VECTOR(2 downto 0);
            semaforoB : out STD_LOGIC_VECTOR(2 downto 0));
    end component;
    signal ligadesliga : STD_LOGIC := '1';
    signal sensorA     : STD_LOGIC := '0';
    signal sensorB     : STD_LOGIC := '0';
    signal clock       : STD_LOGIC := '0';
    signal cont_dezena  : STD_LOGIC_VECTOR(3 downto 0);
    signal cont_unidade : STD_LOGIC_VECTOR(3 downto 0);
    signal semaforoA : STD_LOGIC_VECTOR(2 downto 0);
    signal semaforoB : STD_LOGIC_VECTOR(2 downto 0);
    constant periodo_clock : time := 10 ns;
begin
    DUT : exp8visto3
    port map(
        ligadesliga => ligadesliga,
        sensorA     => sensorA,
        sensorB     => sensorB,
        clock       => clock,
        cont_dezena  => cont_dezena,
        cont_unidade => cont_unidade,
        semaforoA => semaforoA,
        semaforoB => semaforoB);
    process
    begin
        while true loop
            clock <= '0';
            wait for periodo_clock/2;
            clock <= '1';
            wait for periodo_clock/2;
        end loop;
    end process;
    process
    begin
        sensorA <= '0';
        sensorB <= '0';
        wait for 150 ns;
        sensorB <= '1';
        wait for 100 ns;
        sensorB <= '0';
        wait for 150 ns;
        sensorA <= '1';
        wait for 250 ns;
        ligadesliga <= '0';
        wait for 100 ns;
        ligadesliga <= '1';
        sensorA <= '0';
        sensorB <= '0';
        wait for 300 ns;
        wait;
    end process;
end behavior;