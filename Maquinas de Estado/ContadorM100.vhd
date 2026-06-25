library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity contador_0_99 is
    port( 
        clock   : in STD_LOGIC;
        reset   : in STD_LOGIC;
        enable  : in STD_LOGIC;
        rci     : in STD_LOGIC;
        load    : in STD_LOGIC;
        
        D_dez   : in STD_LOGIC_VECTOR(3 downto 0);
        D_uni   : in STD_LOGIC_VECTOR(3 downto 0);
        
        Q_dez   : out STD_LOGIC_VECTOR(3 downto 0);
        Q_uni   : out STD_LOGIC_VECTOR(3 downto 0);
        
        rco_out : out STD_LOGIC 
    );
end contador_0_99;

architecture estrutural of contador_0_99 is

    component contador0a9 is
        port( 
            clock  : in STD_LOGIC;
            reset  : in STD_LOGIC;
            enable : in STD_LOGIC;
            rci    : in STD_LOGIC;
            load   : in STD_LOGIC;
            D      : in STD_LOGIC_VECTOR(3 downto 0);
            Q      : out STD_LOGIC_VECTOR(3 downto 0);
            rco    : out STD_LOGIC 
        );
    end component;

    signal fio_carry_unidade_dezena : STD_LOGIC;

begin

    INST_UNIDADES: contador0a9 port map (
        clock  => clock,
        reset  => reset,
        enable => enable,   
        rci    => rci,      
        load   => load,
        D      => D_uni,
        Q      => Q_uni,
        rco    => fio_carry_unidade_dezena
    );

    INST_DEZENAS: contador0a9 port map (
        clock  => clock,
        reset  => reset,
        enable => enable,   
        rci    => fio_carry_unidade_dezena, 
        load   => load,
        D      => D_dez,
        Q      => Q_dez,
        rco    => rco_out   
    );

end estrutural;
