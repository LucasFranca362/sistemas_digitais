library ieee;
use ieee.std_logic_1164.all;

entity mux8x1_dut is
    port(
        D : in  std_logic_vector(7 downto 0);
        S : in  std_logic_vector(2 downto 0);
        Y : out std_logic
    );
end mux8x1_dut;

architecture structural of mux8x1_dut is

    component mux4x1
        port(
            D : in  std_logic_vector(3 downto 0);
            S : in  std_logic_vector(1 downto 0);
            Y : out std_logic
        );
    end component;

    signal Y0, Y1 : std_logic := '0';
    signal D_final : std_logic_vector(3 downto 0);
    signal S_final : std_logic_vector(1 downto 0);
    

begin

    -- Primeiro MUX (D0 a D3)
    MUX0: mux4x1
        port map(
            D => D(3 downto 0),
            S => S(1 downto 0),
            Y => Y0
        );

    -- Segundo MUX (D4 a D7)
    MUX1: mux4x1
        port map(
            D => D(7 downto 4),
            S => S(1 downto 0),
            Y => Y1
        );

    D_final <= Y1 & Y1 & Y0 & Y0;
    S_final <= S(2) & '0';

    -- MUX final (simulando 2x1 com 4x1)
    MUX2: mux4x1
        port map(
            D => D_final,  
            S => S_final,        
            Y => Y
        );

end structural;
