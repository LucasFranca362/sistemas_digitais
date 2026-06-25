library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity d_ff_using_jk is
    Port (
        D   : in  STD_LOGIC;
        CLK : in  STD_LOGIC;
        PRE : in  STD_LOGIC;
        CLR : in  STD_LOGIC;
        Q   : out STD_LOGIC
    );
end d_ff_using_jk;

architecture Structural of d_ff_using_jk is

    component jk_ff is
        Port (
            J   : in  STD_LOGIC;
            K   : in  STD_LOGIC;
            CLK : in  STD_LOGIC;
            PRE : in  STD_LOGIC;
            CLR : in  STD_LOGIC;
            Q   : out STD_LOGIC
        );
    end component;
    signal nD : std_logic;
begin
    nd <= not D;
    JK1 : jk_ff
        port map(
            J   => D,
            K   => nD,
            CLK => CLK,
            PRE => PRE,
            CLR => CLR,
            Q   => Q
        );

end Structural;