library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_reg_desloc_4bits is
end tb_reg_desloc_4bits;

architecture Behavioral of tb_reg_desloc_4bits is
    component reg_desloc_4bits is
        Port (
            CLK  : in  STD_LOGIC;
            RST  : in  STD_LOGIC;
            LOAD : in  STD_LOGIC;
            D    : in  STD_LOGIC_VECTOR(3 downto 0);
            DIR  : in  STD_LOGIC;
            L    : in  STD_LOGIC;
            R    : in  STD_LOGIC;
            Q    : out STD_LOGIC_VECTOR(3 downto 0)
        );
    end component;

    signal CLK  : STD_LOGIC := '0';
    signal RST  : STD_LOGIC := '0';
    signal LOAD : STD_LOGIC := '0';
    signal D    : STD_LOGIC_VECTOR(3 downto 0) := "0000";
    signal DIR  : STD_LOGIC := '0';
    signal L    : STD_LOGIC := '0';
    signal R    : STD_LOGIC := '0';
    signal Q    : STD_LOGIC_VECTOR(3 downto 0);

begin

    DUT : reg_desloc_4bits
        port map (
            CLK  => CLK,
            RST  => RST,
            LOAD => LOAD,
            D    => D,
            DIR  => DIR,
            L    => L,
            R    => R,
            Q    => Q
        );

    CLK <= not CLK after 10 ns;

    process
    begin

        RST <= '1';
        wait for 20 ns;

        RST <= '0';
        wait for 20 ns;

        LOAD <= '1';
        D <= "1010";
        wait for 20 ns;

        LOAD <= '0';
        wait for 20 ns;

        DIR <= '0';
        L <= '0';
        wait for 20 ns;

        L <= '1';
        wait for 20 ns;

        LOAD <= '1';
        D <= "1101";
        wait for 20 ns;

        LOAD <= '0';
        wait for 20 ns;

        DIR <= '1';
        R <= '0';
        wait for 20 ns;

        R <= '1';
        wait for 20 ns;

        wait for 80 ns;

        wait;

    end process;

end Behavioral;
