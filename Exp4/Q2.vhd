library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity func_bool1 is
    Port (
        A, B, C, D : in  STD_LOGIC;
        E, F, G    : in  STD_LOGIC;
        S          : out STD_LOGIC
    );
end func_bool1;

architecture Behavioral of func_bool1 is
    component dec4x16
        Port (
            A : in  STD_LOGIC_VECTOR (3 downto 0);
            Y : out STD_LOGIC_VECTOR (15 downto 0)
        );
    end component;

    component mux8x1
        Port (
            S : in  STD_LOGIC_VECTOR (2 downto 0);
            D : in  STD_LOGIC_VECTOR (7 downto 0);
            Y : out STD_LOGIC
        );
    end component;
    signal dec_out : STD_LOGIC_VECTOR(15 downto 0);
    signal mux_in  : STD_LOGIC_VECTOR(7 downto 0);
    signal aux : STD_LOGIC_VECTOR(3 downto 0); 
    signal au2 : STD_LOGIC_VECTOR(2 downto 0);

begin
    aux <= A & B & C & D;
    au2 <= E & F & G;    
    DECODER : dec4x16
        port map (
            A => aux,
            Y => dec_out
        );
    mux_in(0) <= '0';

    mux_in(1) <= dec_out(15);

    mux_in(2) <= dec_out(7);

    mux_in(3) <= '1';

    -- Porta OR 1
    mux_in(4) <= dec_out(15) OR dec_out(9);

    mux_in(5) <= dec_out(0);

    -- Porta OR 2
    mux_in(6) <= dec_out(10) OR dec_out(11);

    mux_in(7) <= '1';

    MUX : mux8x1
        port map (
            S => au2,
            D => mux_in,
            Y => S
        );

end Behavioral;