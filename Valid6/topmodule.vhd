library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity topmodule is
end topmodule;

architecture topmodule_arch of topmodule is

    ----------------------------------------------------------------
    -- COMPONENTE DUT
    ----------------------------------------------------------------
    component d_ff_using_jk is
        Port (
            D   : in  STD_LOGIC;
            CLK : in  STD_LOGIC;
            PRE : in  STD_LOGIC;
            CLR : in  STD_LOGIC;
            Q   : out STD_LOGIC
        );
    end component;

    ----------------------------------------------------------------
    -- COMPONENTE GOLDEN MODEL
    ----------------------------------------------------------------
    component flipflopD is
        Port (
            D   : in  STD_LOGIC;
            clk : in  STD_LOGIC;
            clr : in  STD_LOGIC;
            Q   : out STD_LOGIC
        );
    end component;

    ----------------------------------------------------------------
    -- COMPONENTE TESTBENCH
    ----------------------------------------------------------------
    component testbench is
        port (
            q_dut, q_gm : in  STD_LOGIC;
            D, CLK, PRE, CLR : out STD_LOGIC
        );
    end component;

    ----------------------------------------------------------------
    -- SINAIS INTERNOS
    ----------------------------------------------------------------
    signal D_s, CLK_s, PRE_s, CLR_s : STD_LOGIC;
    signal q_dut_s, q_gm_s          : STD_LOGIC;

begin

    ----------------------------------------------------------------
    -- INSTÂNCIA DUT
    ----------------------------------------------------------------
    U0 : d_ff_using_jk
        port map(
            D    => D_s,
            CLK  => CLK_s,
            PRE  => PRE_s,
            CLR  => CLR_s,
            Q    => q_dut_s
        );

    ----------------------------------------------------------------
    -- INSTÂNCIA GOLDEN MODEL
    ----------------------------------------------------------------
    U1 : flipflopD
        port map(
            D   => D_s,
            clk => CLK_s,
            clr => CLR_s,
            Q   => q_gm_s
        );

    ----------------------------------------------------------------
    -- INSTÂNCIA TESTBENCH
    ----------------------------------------------------------------
    U2 : testbench
        port map(
            q_dut => q_dut_s,
            q_gm  => q_gm_s,
            D     => D_s,
            CLK   => CLK_s,
            PRE   => PRE_s,
            CLR   => CLR_s
        );

end topmodule_arch;
