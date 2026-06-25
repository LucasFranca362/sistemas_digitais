library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity full_adder_dut is
    Port (
        A    : in  STD_LOGIC;
        B    : in  STD_LOGIC;
        Cin  : in  STD_LOGIC;
        S    : out STD_LOGIC;
        Cout : out STD_LOGIC
    );
end full_adder_dut;

architecture Structural of full_adder_dut is

    component dec4x16
        Port (
            A : in  STD_LOGIC_VECTOR(3 downto 0);
            Y : out STD_LOGIC_VECTOR(15 downto 0)
        );
    end component;

    component mux8x1
        Port (
            D   : in  STD_LOGIC_VECTOR(7 downto 0);
            S : in  STD_LOGIC_VECTOR(2 downto 0);
            Y   : out STD_LOGIC
        );
    end component;

    signal dec_cout : STD_LOGIC_VECTOR(15 downto 0);
    signal dec_sum  : STD_LOGIC_VECTOR(15 downto 0);

    signal sel : STD_LOGIC_VECTOR(3 downto 0);

    signal mux_cout_in : STD_LOGIC_VECTOR(7 downto 0);
    signal mux_sum_in  : STD_LOGIC_VECTOR(7 downto 0);

    signal aux1 : std_logic_vector(3 downto 0);
    signal aux2: std_logic_vector(3 downto 0);

    
begin
    
    aux1 <= '0' & A & B & Cin;
    sel  <= aux1;
    aux2 <= sel; 

    DEC1 : dec4x16 
        port map( 
            A => aux2, 
            Y => dec_cout 
        );

    DEC2 : dec4x16
        port map(
            A => aux1,
            Y => dec_sum
        );

    mux_cout_in(0) <= '0';
    mux_cout_in(1) <= '0';
    mux_cout_in(2) <= '0';
    mux_cout_in(3) <= dec_cout(3);
    mux_cout_in(4) <= '0';
    mux_cout_in(5) <= dec_cout(5);
    mux_cout_in(6) <= dec_cout(6);
    mux_cout_in(7) <= dec_cout(7);

    mux_sum_in(0) <= '0';
    mux_sum_in(1) <= dec_sum(1);
    mux_sum_in(2) <= dec_sum(2);
    mux_sum_in(3) <= '0';
    mux_sum_in(4) <= dec_sum(4);
    mux_sum_in(5) <= '0';
    mux_sum_in(6) <= '0';
    mux_sum_in(7) <= dec_sum(7);


    MUX_COUT : mux8x1
        port map(
            D   => mux_cout_in,
            S => sel(2 downto 0),
            Y   => Cout
        );

    MUX_SUM : mux8x1
        port map(
            D   => mux_sum_in,
            S => sel(2 downto 0),
            Y   => S
        );

end Structural;

