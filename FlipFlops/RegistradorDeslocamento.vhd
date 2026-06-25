library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity reg_desloc_4bits is
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
end reg_desloc_4bits;

architecture Behavioral of reg_desloc_4bits is
    signal Q_int : STD_LOGIC_VECTOR(3 downto 0) := "0000";
begin
    process(CLK)
    begin
        if rising_edge(CLK) then
            if (RST = '1') then
                Q_int <= "0000";
            elsif (LOAD = '1') then
                Q_int <= D;
            else
                if (DIR = '0') then
                    if (L = '0') then
                        Q_int <= Q_int(2 downto 0) & '0';
                    else
                        Q_int <= Q_int(2 downto 0) & '1';
                    end if;
                else
                    if (R = '0') then
                        Q_int <= '0' & Q_int(3 downto 1);
                    else
                        Q_int <= '1' & Q_int(3 downto 1);
                    end if;
                end if;
            end if;
        end if;
    end process;
    Q <= Q_int;
end Behavioral;
