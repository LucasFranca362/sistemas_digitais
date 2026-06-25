library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity func_bool is
    Port (
        A : in  STD_LOGIC;
        B : in  STD_LOGIC;
        C : in  STD_LOGIC;
        X : out STD_LOGIC;
        Y : out STD_LOGIC
    );
end func_bool;

architecture Structural of func_bool is
    -- componente MUX 4x1
    component mux4x1
        Port (
            S : in  STD_LOGIC_VECTOR (1 downto 0);
            D : in  STD_LOGIC_VECTOR (3 downto 0);
            Y : out STD_LOGIC
        );
    end component;
    signal nC : STD_LOGIC;

    -- sinais de entrada dos MUX
    signal DX : STD_LOGIC_VECTOR(3 downto 0);
    signal DY : STD_LOGIC_VECTOR(3 downto 0);

begin
    nC <= not C;    
    DX(0) <= '0';
    DX(1) <= C;
    DX(2) <= nC;
    DX(3) <= '1';

    MUX_X : mux4x1
        port map(
            S(1) => A,
            S(0) => B,
            D    => DX,
            Y    => X
        );
    DY(0) <= '1';
    DY(1) <= nC;
    DY(2) <= '0';
    DY(3) <= C;

    MUX_Y : mux4x1
        port map(
            S(1) => A,
            S(0) => B,
            D    => DY,
            Y    => Y
        );

end Structural;