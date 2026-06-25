library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity maquina_refrigerante is
    Port (
        clk    : in  STD_LOGIC;
        reset  : in  STD_LOGIC;
        A      : in  STD_LOGIC_VECTOR(1 downto 0);

        s_refri : out STD_LOGIC;
        s_25    : out STD_LOGIC;
        s_50    : out STD_LOGIC
    );
end maquina_refrigerante;

architecture Behavioral of maquina_refrigerante is

    type estado_t is (
        INIT,
        E25C,
        E50C,
        E75C,
        E100C,
        E125C,
        D25C,
        D50C,
        D75C
    );

    signal estado_atual, proximo_estado : estado_t;

begin

------------------------------------------------------------------
-- Registrador de estado
------------------------------------------------------------------
process(clk, reset)
begin
    if reset = '1' then
        estado_atual <= INIT;
    elsif rising_edge(clk) then
        estado_atual <= proximo_estado;
    end if;
end process;

------------------------------------------------------------------
-- Lógica de próximo estado
------------------------------------------------------------------
process(estado_atual, A)
begin

    proximo_estado <= estado_atual;

    case estado_atual is

        ----------------------------------------------------------
        when INIT =>
            case A is
                when "01" => proximo_estado <= E25C;
                when "10" => proximo_estado <= E50C;
                when others => proximo_estado <= INIT;
            end case;

        ----------------------------------------------------------
        when E25C =>
            case A is
                when "00" => proximo_estado <= E25C;
                when "01" => proximo_estado <= E50C;
                when "10" => proximo_estado <= E75C;
                when "11" => proximo_estado <= D25C;
                when others => proximo_estado <= E25C;
            end case;

        ----------------------------------------------------------
        when E50C =>
            case A is
                when "00" => proximo_estado <= E50C;
                when "01" => proximo_estado <= E75C;
                when "10" => proximo_estado <= E100C;
                when "11" => proximo_estado <= D50C;
                when others => proximo_estado <= E50C;
            end case;

        ----------------------------------------------------------
        when E75C =>
            case A is
                when "00" => proximo_estado <= E75C;
                when "01" => proximo_estado <= E100C;
                when "10" => proximo_estado <= E125C;
                when "11" => proximo_estado <= D75C;
                when others => proximo_estado <= E75C;
            end case;

        ----------------------------------------------------------
        -- Estados de saída
        ----------------------------------------------------------
        when E100C =>
            proximo_estado <= INIT;

        when E125C =>
            proximo_estado <= INIT;

        when D25C =>
            proximo_estado <= INIT;

        when D50C =>
            proximo_estado <= INIT;

        when D75C =>
            proximo_estado <= INIT;

    end case;

end process;

------------------------------------------------------------------
-- Lógica de saída (MOORE)
------------------------------------------------------------------
process(estado_atual)
begin

    s_refri <= '0';
    s_25    <= '0';
    s_50    <= '0';

    case estado_atual is

        ----------------------------------------------------------
        when E100C =>
            s_refri <= '1';

        ----------------------------------------------------------
        when E125C =>
            s_refri <= '1';
            s_25    <= '1';

        ----------------------------------------------------------
        when D25C =>
            s_25 <= '1';

        ----------------------------------------------------------
        when D50C =>
            s_50 <= '1';

        ----------------------------------------------------------
        when D75C =>
            s_25 <= '1';
            s_50 <= '1';

        ----------------------------------------------------------
        when others =>
            null;

    end case;

end process;

end Behavioral;
