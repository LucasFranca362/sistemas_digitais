library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity topmodule is
end topmodule;

architecture topmodule_arch of topmodule is

    component paridade is
	port(
	    A: in std_logic_vector(3 downto 0);
	    P: out std_logic
	);
    end component;

    component paridade_gm is
	port(
	    A: in std_logic_vector(3 downto 0);
	    P: out std_logic
	);
    end component;

    component testbench is
        port(
            S_dut    : in  STD_LOGIC;
            S_gm     : in Std_logic;

            A   : out STD_LOGIC_VECTOR(3 downto 0)            
        );
    end component;
    signal A: std_logic_vector(3 downto 0);
    signal S_dut: std_logic;
    signal S_gm: std_logic;

begin
	T1: paridade
	   Port map(
	   A,
	   S_dut
	);

	T2: paridade_gm
	   Port map(
	   A,
	   S_gm
	);

	T3: testbench
	   Port map(
	   S_gm,
	   S_dut,
	   A
	);

end topmodule_arch;
