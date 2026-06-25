library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity adder4_gm is
    port(
        A : in  std_logic_vector(3 downto 0);
        B : in  std_logic_vector(3 downto 0);
        S : out std_logic_vector(4 downto 0)
    );
end entity;

architecture behavior of adder4_gm is
begin

    S <= ('0' & A) + ('0' & B);

end architecture;
