library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_ff_jk is
end tb_ff_jk;

architecture Behavioral of tb_ff_jk is
    component ff_jk is
        Port (
            PR  : in  STD_LOGIC;
            CLR : in  STD_LOGIC;
            CLK : in  STD_LOGIC;
            J   : in  STD_LOGIC;
            K   : in  STD_LOGIC;
            Q   : out STD_LOGIC
        );
    end component;

    signal PR  : STD_LOGIC := '0';
    signal CLR : STD_LOGIC := '0';
    signal CLK : STD_LOGIC := '0';
    signal J   : STD_LOGIC := '0';
    signal K   : STD_LOGIC := '0';
    signal Q   : STD_LOGIC;

begin
    DUT : ff_jk
        port map (
            PR  => PR,
            CLR => CLR,
            CLK => CLK,
            J   => J,
            K   => K,
            Q   => Q
        );

    CLK <= not CLK after 10 ns;
    process
    begin
	-- Preset
        PR  <= '1';
        CLR <= '0';
        J   <= '0';
        K   <= '0';
        wait for 20 ns;

        -- CLEAR
        PR  <= '0';
        CLR <= '1';
        wait for 20 ns;

        PR  <= '0';
        CLR <= '0';
	-- JK = 00(Hold)
        J <= '0';
        K <= '0';
        wait for 20 ns;
        -- JK = 01 (reset)
        J <= '0';
        K <= '1';
        wait for 20 ns;
        -- JK = 10 (set)
        J <= '1';
        K <= '0';
        wait for 20 ns;
        -- JK = 11 (toggle)
        J <= '1';
        K <= '1';
        wait for 20 ns;
        -- Toggle novamente
        wait for 20 ns;
        wait;
    end process;
end Behavioral;
