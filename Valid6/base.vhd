library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity jk_ff is
    Port (
        J   : in  STD_LOGIC;
        K   : in  STD_LOGIC;
        CLK : in  STD_LOGIC;
	CLR : in  STD_LOGIC;
	PRE : in  STD_LOGIC;
        Q   : out STD_LOGIC
    );
end jk_ff;

architecture Behavioral of jk_ff is

    signal q_int : STD_LOGIC := '0';
    signal jk    : STD_LOGIC_VECTOR(1 downto 0);

begin

    jk <= J & K;

    process(CLK, CLR, PRE)
begin

    if CLR = '1' then
        q_int <= '0';

    elsif PRE = '1' then
        q_int <= '1';

    elsif rising_edge(CLK) then

        case jk is

            when "00" =>
                null;

            when "01" =>
                q_int <= '0';

            when "10" =>
                q_int <= '1';

            when "11" =>
                q_int <= not q_int;

            when others =>
                null;

        end case;

    end if;

end process;

    Q <= q_int;

end Behavioral;


