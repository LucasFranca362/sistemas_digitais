library ieee;
use ieee.std_logic_1164.all;

entity top is
    port(
        D : in  std_logic_vector(7 downto 0);
        S : in  std_logic_vector(2 downto 0);
        erro : out std_logic
    );
end top;

architecture sim of top is

    -- Saídas
    signal Y_dut : std_logic;
    signal Y_gm  : std_logic;

    component mux8x1_dut
        port(
            D : in  std_logic_vector(7 downto 0);
            S : in  std_logic_vector(2 downto 0);
            Y : out std_logic
        );
    end component;


    component mux8x1
        port(
            S : in  std_logic_vector(2 downto 0);
            D : in  std_logic_vector(7 downto 0);
            Y : out std_logic
        );
    end component;

begin

    DUT: mux8x1_dut
        port map(
            D => D,
            S => S,
            Y => Y_dut
        );

    GM: mux8x1
        port map(
            D => D,
            S => S,
            Y => Y_gm
        );
	
	-- Comparador

    erro <= '1' when Y_dut /= Y_gm else '0';

end sim;
