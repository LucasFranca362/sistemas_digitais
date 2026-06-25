library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ff_jk is
    Port (
        PR  : in  STD_LOGIC;
        CLR : in  STD_LOGIC;
        CLK : in  STD_LOGIC;
        J   : in  STD_LOGIC;
        K   : in  STD_LOGIC;
        Q   : out STD_LOGIC
    );
end ff_jk;

architecture Behavioral of ff_jk is
    signal Q_int : STD_LOGIC := '0';
    signal nQ    : STD_LOGIC;
    signal jk    : STD_LOGIC_VECTOR(1 downto 0);
    
begin
    jk <= J & K;
    nQ <= not Q_int;
    process(PR, CLR, CLK)
    begin
        if (PR = '1') then
            Q_int <= '1';
        elsif (CLR = '1') then
            Q_int <= '0';
        -- Borda de subida
        elsif rising_edge(CLK) then
            case jk is
                when "00" =>
                    Q_int <= Q_int; -- mantém
                when "01" =>
                    Q_int <= '0';
                when "10" =>
                    Q_int <= '1';
                when "11" =>
                    Q_int <= nQ; -- inverte
                when others =>
                    null;
            end case;
        end if;
    end process;
    Q <= Q_int;
end Behavioral;
