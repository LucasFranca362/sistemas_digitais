library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity topmodule is
end topmodule;

architecture topmodule_arch of topmodule is

    -------------------------------------------------
    -- COMPONENTE DUT
    -------------------------------------------------
    component full_adder_dut is
        port(
            A    : in  STD_LOGIC;
            B    : in  STD_LOGIC;
            Cin  : in  STD_LOGIC;
            S    : out STD_LOGIC;
            Cout : out STD_LOGIC
        );
    end component;

    -------------------------------------------------
    -- COMPONENTE GOLDEN MODEL
    -------------------------------------------------
    component somador_completo is
        port(
            A    : in  STD_LOGIC;
            B    : in  STD_LOGIC;
            Cin  : in  STD_LOGIC;
            S    : out STD_LOGIC;
            Cout : out STD_LOGIC
        );
    end component;

    -------------------------------------------------
    -- COMPONENTE TESTBENCH
    -------------------------------------------------
    component testbench is
        port(
            erro_S    : in  STD_LOGIC;
            erro_Cout : in  STD_LOGIC;

            A   : out STD_LOGIC;
            B   : out STD_LOGIC;
            Cin : out STD_LOGIC
        );
    end component;

    -------------------------------------------------
    -- SINAIS
    -------------------------------------------------
    signal A    : STD_LOGIC;
    signal B    : STD_LOGIC;
    signal Cin  : STD_LOGIC;

    signal S_dut    : STD_LOGIC;
    signal Cout_dut : STD_LOGIC;

    signal S_gm    : STD_LOGIC;
    signal Cout_gm : STD_LOGIC;

    signal erro_S    : STD_LOGIC;
    signal erro_Cout : STD_LOGIC;

begin

    U0 : full_adder_dut
        port map(
            A,
            B,
            Cin,
            S_dut,
            Cout_dut
        );

    U1 : somador_completo
        port map(
            A,
            B,
            Cin,
            S_gm,
            Cout_gm
        );


    erro_S    <= S_dut xor S_gm;

    erro_Cout <= Cout_dut xor Cout_gm;


    U2 : testbench
        port map(
            erro_S,
            erro_Cout,

            A,
            B,
            Cin
        );

end topmodule_arch;
