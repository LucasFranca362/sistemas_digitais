library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity maqestados is
    port(
        ligadesliga : in STD_LOGIC;
        clock       : in STD_LOGIC;
        sensorA     : in STD_LOGIC;
        sensorB     : in STD_LOGIC;
        T5          : in STD_LOGIC;
        T6          : in STD_LOGIC;
        T20         : in STD_LOGIC;
        T60         : in STD_LOGIC;
        resetcounter : out STD_LOGIC;
        semaforoA : out STD_LOGIC_VECTOR(2 downto 0);
        semaforoB : out STD_LOGIC_VECTOR(2 downto 0)
    );
end maqestados;

architecture behavioral of maqestados is
type estado_t is (
    NS_VERDE,
    NS_AMARELO,
    TODOS_VERMELHOS_1,
    LO_VERDE,
    LO_AMARELO,
    TODOS_VERMELHOS_2,
    INTERMITENTE_ON,
    INTERMITENTE_OFF
);
signal currentState, nextState : estado_t;
begin
process(clock)
begin
    if rising_edge(clock) then
        currentState <= nextState;
    end if;
end process;
process(currentState, ligadesliga, sensorA, sensorB,
        T5, T6, T20, T60)
begin
    nextState <= currentState;
    case currentState is
        when NS_VERDE =>
            if ligadesliga='0' then
                nextState <= INTERMITENTE_ON;
            elsif (T60='1') or ((T20='1') and (sensorB='1')) then
                nextState <= NS_AMARELO;
            end if;
        when NS_AMARELO =>
            if ligadesliga='0' then
                nextState <= INTERMITENTE_ON;
            elsif T6='1' then
                nextState <= TODOS_VERMELHOS_1;
            end if;
        when TODOS_VERMELHOS_1 =>
            if ligadesliga='0' then
                nextState <= INTERMITENTE_ON;
            elsif T5='1' then
                nextState <= LO_VERDE;
            end if;
        when LO_VERDE =>
            if ligadesliga='0' then
                nextState <= INTERMITENTE_ON;
            elsif (T60='1') or ((T20='1') and (sensorA='1')) then
                nextState <= LO_AMARELO;
            end if;
        when LO_AMARELO =>
            if ligadesliga='0' then
                nextState <= INTERMITENTE_ON;
            elsif T6='1' then
                nextState <= TODOS_VERMELHOS_2;
            end if;
        when TODOS_VERMELHOS_2 =>
            if ligadesliga='0' then
                nextState <= INTERMITENTE_ON;
            elsif T5='1' then
                nextState <= NS_VERDE;
            end if;
        when INTERMITENTE_ON =>
            if ligadesliga='1' then
                nextState <= NS_VERDE;
            else
                nextState <= INTERMITENTE_OFF;
            end if;
        when INTERMITENTE_OFF =>
            if ligadesliga='1' then
                nextState <= NS_VERDE;
            else
                nextState <= INTERMITENTE_ON;
            end if;
    end case;
end process;
process(currentState)
begin
    case currentState is
        when NS_VERDE =>
            semaforoA <= "010";   -- verde
            semaforoB <= "100";   -- vermelho
        when NS_AMARELO =>
            semaforoA <= "001";   -- amarelo
            semaforoB <= "100";   -- vermelho
        when TODOS_VERMELHOS_1 =>
            semaforoA <= "100";
            semaforoB <= "100";
        when LO_VERDE =>
            semaforoA <= "100";
            semaforoB <= "010";
        when LO_AMARELO =>
            semaforoA <= "100";
            semaforoB <= "001";
        when TODOS_VERMELHOS_2 =>
            semaforoA <= "100";
            semaforoB <= "100";
        when INTERMITENTE_ON =>
            semaforoA <= "001";
            semaforoB <= "001";
        when INTERMITENTE_OFF =>
            semaforoA <= "000";
            semaforoB <= "000";
    end case;
end process;
resetcounter <= '1'
                when nextState /= currentState
                else '0';

end behavioral;
