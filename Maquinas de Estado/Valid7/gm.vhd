library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity contador_bcd_0_99 is
    port(
        clock  : in STD_LOGIC;
        reset  : in STD_LOGIC;
        enable : in STD_LOGIC;
        
        Q_dez  : out STD_LOGIC_VECTOR(3 downto 0);
        Q_uni  : out STD_LOGIC_VECTOR(3 downto 0)
    );
end contador_bcd_0_99;

architecture comportamento of contador_bcd_0_99 is

    signal unidade : unsigned(3 downto 0);
    signal dezena  : unsigned(3 downto 0);

begin

    process(clock, reset)
    begin
        if reset = '1' then
            unidade <= "0000";
            dezena  <= "0000";
            
        elsif rising_edge(clock) then
            if enable = '0' then 
                
                if unidade = 9 then
                    unidade <= "0000";
                    
                    if dezena = 9 then
                        dezena <= "0000"; 
                    else
                        dezena <= dezena + 1;
                    end if;
                    
                else
                    unidade <= unidade + 1;
                end if;
                
            end if;
        end if;
    end process;

    Q_uni <= std_logic_vector(unidade);
    Q_dez <= std_logic_vector(dezena);

end comportamento;
