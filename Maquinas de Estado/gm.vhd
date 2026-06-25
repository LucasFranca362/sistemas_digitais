library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity relogio_gm is
    port(
        clock    : in STD_LOGIC;
        reset    : in STD_LOGIC;
        enable   : in STD_LOGIC;

        segundos : out STD_LOGIC_VECTOR(7 downto 0);
        minutos  : out STD_LOGIC_VECTOR(7 downto 0);
        horas    : out STD_LOGIC_VECTOR(7 downto 0)
    );
end relogio_gm;

architecture comportamento of relogio_gm is

    signal s_u : unsigned(3 downto 0) := "0000";
    signal s_d : unsigned(3 downto 0) := "0000";

    signal m_u : unsigned(3 downto 0) := "0000";
    signal m_d : unsigned(3 downto 0) := "0000";

    signal hora_int : integer range 0 to 23 := 0;

begin

    process(clock, reset)
    begin

        if reset = '1' then

            s_u <= "0000";
            s_d <= "0000";

            m_u <= "0000";
            m_d <= "0000";

            hora_int <= 0;

        elsif rising_edge(clock) then

            if enable = '0' then

                --------------------------------------------------
                -- SEGUNDOS
                --------------------------------------------------

                if s_u = 9 then

                    s_u <= "0000";

                    if s_d = 5 then

                        s_d <= "0000";

                        --------------------------------------------------
                        -- MINUTOS
                        --------------------------------------------------

                        if m_u = 9 then

                            m_u <= "0000";

                            if m_d = 5 then

                                m_d <= "0000";

                                --------------------------------------------------
                                -- HORAS
                                --------------------------------------------------

                                if hora_int = 23 then
                                    hora_int <= 0;
                                else
                                    hora_int <= hora_int + 1;
                                end if;

                            else
                                m_d <= m_d + 1;
                            end if;

                        else
                            m_u <= m_u + 1;
                        end if;

                    else
                        s_d <= s_d + 1;
                    end if;

                else
                    s_u <= s_u + 1;
                end if;

            end if;

        end if;

    end process;

    --------------------------------------------------
    -- SAÍDAS BCD
    --------------------------------------------------

    segundos <= std_logic_vector(s_d) &
                std_logic_vector(s_u);

    minutos <= std_logic_vector(m_d) &
               std_logic_vector(m_u);

    horas <= std_logic_vector(to_unsigned(hora_int / 10, 4)) &
             std_logic_vector(to_unsigned(hora_int mod 10, 4));

end comportamento;
