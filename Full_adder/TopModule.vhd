library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity topmodule is
end topmodule;

architecture topmodule_arch of topmodule is

    -- DUT (somador estrutural)
    component adder4 is
        port(
            A : in  STD_LOGIC_VECTOR(3 downto 0);
            B : in  STD_LOGIC_VECTOR(3 downto 0);
            S : out STD_LOGIC_VECTOR(4 downto 0)
        );
    end component;

    -- Golden Model
    component adder4_gm is
        port(
            A : in  STD_LOGIC_VECTOR(3 downto 0);
            B : in  STD_LOGIC_VECTOR(3 downto 0);
            S : out STD_LOGIC_VECTOR(4 downto 0)
        );
    end component;

    -- Testbench (gerador de estímulos)
    component testbench is
        port(
            S_dut, S_gm : in  STD_LOGIC_VECTOR(4 downto 0);
            A, B        : out STD_LOGIC_VECTOR(3 downto 0)
        );
    end component;

    -- sinais internos
    signal erro : STD_LOGIC;
    signal A, B       : STD_LOGIC_VECTOR(3 downto 0);
    signal S_dut, S_gm: STD_LOGIC_VECTOR(4 downto 0);

begin

    -- DUT
    U0: adder4 
        port map(A, B, S_dut);

    -- Golden Model
    U1: adder4_gm 
        port map(A, B, S_gm);

    -- Testbench
    U2: testbench 
        port map(S_dut, S_gm, A, B);

    -- Comparação
     erro <= '1' when S_dut /= S_gm else '0';

end topmodule_arch;
