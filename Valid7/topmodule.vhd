library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity topmodule is
    port(
        erro : out STD_LOGIC
    );
end topmodule;

architecture estrutural of topmodule is

    component testbench
        port(
            clock : out STD_LOGIC;
            reset : out STD_LOGIC
        );
    end component;

    signal clock : STD_LOGIC;
    signal reset : STD_LOGIC;

    signal qd_dut, qu_dut : STD_LOGIC_VECTOR(3 downto 0);
    signal qd_gm,  qu_gm  : STD_LOGIC_VECTOR(3 downto 0);

    signal rco_dummy : STD_LOGIC;

begin

    TB : testbench
    port map(
        clock => clock,
        reset => reset
    );

    DUT : entity work.contador_0_99
    port map(
        clock   => clock,
        reset   => reset,
        enable  => '0',
        rci     => '0',
        load    => '0',
        D_dez   => "0000",
        D_uni   => "0000",
        Q_dez   => qd_dut,
        Q_uni   => qu_dut,
        rco_out => rco_dummy
    );

    GM : entity work.contador_bcd_0_99
    port map(
        clock  => clock,
        reset  => reset,
        enable => '0',
        Q_dez  => qd_gm,
        Q_uni  => qu_gm
    );

    erro <= '1'
        when (qd_dut /= qd_gm) or
             (qu_dut /= qu_gm)
        else '0';

end estrutural;
