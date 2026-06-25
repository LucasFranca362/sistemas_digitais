library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity contador0a23_bcd is
    port( clock : in STD_LOGIC;
          reset : in STD_LOGIC;
          enable : in STD_LOGIC;
          rci : in STD_LOGIC;
          load : in STD_LOGIC;
          D : in STD_LOGIC_VECTOR(7 downto 0); -- 8 bits: 4 para dezena, 4 para unidade
          Q : out STD_LOGIC_VECTOR(7 downto 0); -- 8 bits: 4 para dezena, 4 para unidade
          rco : out STD_LOGIC );
end contador0a23_bcd;

architecture contador_bcd_arch of contador0a23_bcd is
    type estado is (ST0, ST1, ST2, ST3, ST4, ST5, ST6, ST7, ST8, ST9, 
                    ST10, ST11, ST12, ST13, ST14, ST15, ST16, ST17, 
                    ST18, ST19, ST20, ST21, ST22, ST23);
    signal currentState, nextState, loadState : estado;
begin

    -- Mapeamento da entrada D em BCD para os estados (Dezena | Unidade)
    with D select
        loadState <= ST0  when "00000000", -- 00
                     ST1  when "00000001", -- 01
                     ST2  when "00000010", -- 02
                     ST3  when "00000011", -- 03
                     ST4  when "00000100", -- 04
                     ST5  when "00000101", -- 05
                     ST6  when "00000110", -- 06
                     ST7  when "00000111", -- 07
                     ST8  when "00001000", -- 08
                     ST9  when "00001001", -- 09
                     ST10 when "00010000", -- 10
                     ST11 when "00010001", -- 11
                     ST12 when "00010010", -- 12
                     ST13 when "00010011", -- 13
                     ST14 when "00010100", -- 14
                     ST15 when "00010101", -- 15
                     ST16 when "00010110", -- 16
                     ST17 when "00010111", -- 17
                     ST18 when "00011000", -- 18
                     ST19 when "00011001", -- 19
                     ST20 when "00100000", -- 20
                     ST21 when "00100001", -- 21
                     ST22 when "00100010", -- 22
                     ST23 when "00100011", -- 23
                     ST0  when others;

    sync_proc: process(clock)
    begin
        if rising_edge(clock) then
            currentState <= nextState;
        end if;
    end process sync_proc;

    comb_proc: process(currentState,reset,enable,rci,load,loadState)
    begin
        case currentState is
            
            when ST0 =>
                Q <= "00000000"; rco <= '1';
                if (reset = '1') then nextState <= ST0;
                elsif (load = '1') then nextState <= loadState;
                elsif ((enable = '0') and (rci = '0')) then nextState <= ST1;
                else nextState <= ST0; end if;
                
            when ST1 =>
                Q <= "00000001"; rco <= '1';
                if (reset = '1') then nextState <= ST0;
                elsif (load = '1') then nextState <= loadState;
                elsif ((enable = '0') and (rci = '0')) then nextState <= ST2;
                else nextState <= ST1; end if;
                
            when ST2 =>
                Q <= "00000010"; rco <= '1';
                if (reset = '1') then nextState <= ST0;
                elsif (load = '1') then nextState <= loadState;
                elsif ((enable = '0') and (rci = '0')) then nextState <= ST3;
                else nextState <= ST2; end if;
                
            when ST3 =>
                Q <= "00000011"; rco <= '1';
                if (reset = '1') then nextState <= ST0;
                elsif (load = '1') then nextState <= loadState;
                elsif ((enable = '0') and (rci = '0')) then nextState <= ST4;
                else nextState <= ST3; end if;

            when ST4 =>
                Q <= "00000100"; rco <= '1';
                if (reset = '1') then nextState <= ST0;
                elsif (load = '1') then nextState <= loadState;
                elsif ((enable = '0') and (rci = '0')) then nextState <= ST5;
                else nextState <= ST4; end if;
                
            when ST5 =>
                Q <= "00000101"; rco <= '1';
                if (reset = '1') then nextState <= ST0;
                elsif (load = '1') then nextState <= loadState;
                elsif ((enable = '0') and (rci = '0')) then nextState <= ST6;
                else nextState <= ST5; end if;
                
            when ST6 =>
                Q <= "00000110"; rco <= '1';
                if (reset = '1') then nextState <= ST0;
                elsif (load = '1') then nextState <= loadState;
                elsif ((enable = '0') and (rci = '0')) then nextState <= ST7;
                else nextState <= ST6; end if;
                
            when ST7 =>
                Q <= "00000111"; rco <= '1';
                if (reset = '1') then nextState <= ST0;
                elsif (load = '1') then nextState <= loadState;
                elsif ((enable = '0') and (rci = '0')) then nextState <= ST8;
                else nextState <= ST7; end if;

            when ST8 =>
                Q <= "00001000"; rco <= '1';
                if (reset = '1') then nextState <= ST0;
                elsif (load = '1') then nextState <= loadState;
                elsif ((enable = '0') and (rci = '0')) then nextState <= ST9;
                else nextState <= ST8; end if;
                
            when ST9 =>
                Q <= "00001001"; rco <= '1';
                if (reset = '1') then nextState <= ST0;
                elsif (load = '1') then nextState <= loadState;
                elsif ((enable = '0') and (rci = '0')) then nextState <= ST10;
                else nextState <= ST9; end if;
                
            -- Transição para a dezena: "0001" (1) e unidade "0000" (0)
            when ST10 =>
                Q <= "00010000"; rco <= '1';
                if (reset = '1') then nextState <= ST0;
                elsif (load = '1') then nextState <= loadState;
                elsif ((enable = '0') and (rci = '0')) then nextState <= ST11;
                else nextState <= ST10; end if;

            when ST11 =>
                Q <= "00010001"; rco <= '1';
                if (reset = '1') then nextState <= ST0;
                elsif (load = '1') then nextState <= loadState;
                elsif ((enable = '0') and (rci = '0')) then nextState <= ST12;
                else nextState <= ST11; end if;

            when ST12 =>
                Q <= "00010010"; rco <= '1';
                if (reset = '1') then nextState <= ST0;
                elsif (load = '1') then nextState <= loadState;
                elsif ((enable = '0') and (rci = '0')) then nextState <= ST13;
                else nextState <= ST12; end if;

            when ST13 =>
                Q <= "00010011"; rco <= '1';
                if (reset = '1') then nextState <= ST0;
                elsif (load = '1') then nextState <= loadState;
                elsif ((enable = '0') and (rci = '0')) then nextState <= ST14;
                else nextState <= ST13; end if;

            when ST14 =>
                Q <= "00010100"; rco <= '1';
                if (reset = '1') then nextState <= ST0;
                elsif (load = '1') then nextState <= loadState;
                elsif ((enable = '0') and (rci = '0')) then nextState <= ST15;
                else nextState <= ST14; end if;

            when ST15 =>
                Q <= "00010101"; rco <= '1';
                if (reset = '1') then nextState <= ST0;
                elsif (load = '1') then nextState <= loadState;
                elsif ((enable = '0') and (rci = '0')) then nextState <= ST16;
                else nextState <= ST15; end if;

            when ST16 =>
                Q <= "00010110"; rco <= '1';
                if (reset = '1') then nextState <= ST0;
                elsif (load = '1') then nextState <= loadState;
                elsif ((enable = '0') and (rci = '0')) then nextState <= ST17;
                else nextState <= ST16; end if;

            when ST17 =>
                Q <= "00010111"; rco <= '1';
                if (reset = '1') then nextState <= ST0;
                elsif (load = '1') then nextState <= loadState;
                elsif ((enable = '0') and (rci = '0')) then nextState <= ST18;
                else nextState <= ST17; end if;

            when ST18 =>
                Q <= "00011000"; rco <= '1';
                if (reset = '1') then nextState <= ST0;
                elsif (load = '1') then nextState <= loadState;
                elsif ((enable = '0') and (rci = '0')) then nextState <= ST19;
                else nextState <= ST18; end if;

            when ST19 =>
                Q <= "00011001"; rco <= '1';
                if (reset = '1') then nextState <= ST0;
                elsif (load = '1') then nextState <= loadState;
                elsif ((enable = '0') and (rci = '0')) then nextState <= ST20;
                else nextState <= ST19; end if;

            -- Transição para a dezena: "0010" (2)
            when ST20 =>
                Q <= "00100000"; rco <= '1';
                if (reset = '1') then nextState <= ST0;
                elsif (load = '1') then nextState <= loadState;
                elsif ((enable = '0') and (rci = '0')) then nextState <= ST21;
                else nextState <= ST20; end if;

            when ST21 =>
                Q <= "00100001"; rco <= '1';
                if (reset = '1') then nextState <= ST0;
                elsif (load = '1') then nextState <= loadState;
                elsif ((enable = '0') and (rci = '0')) then nextState <= ST22;
                else nextState <= ST21; end if;

            when ST22 =>
                Q <= "00100010"; rco <= '1';
                if (reset = '1') then nextState <= ST0;
                elsif (load = '1') then nextState <= loadState;
                elsif ((enable = '0') and (rci = '0')) then nextState <= ST23;
                else nextState <= ST22; end if;

            when ST23 =>
                Q <= "00100011"; rco <= '0'; -- RCO ativa em '0' no final da contagem
                if (reset = '1') then nextState <= ST0;
                elsif (load = '1') then nextState <= loadState;
                elsif ((enable = '0') and (rci = '0')) then nextState <= ST0;
                else nextState <= ST23; end if;
                
            when others =>
                Q <= "00000000"; rco <= '1';
                if (reset = '1') then nextState <= ST0;
                elsif (load = '1') then nextState <= loadState;
                elsif ((enable = '0') and (rci = '0')) then nextState <= ST1;
                else nextState <= ST0; end if;
                
        end case;
    end process comb_proc;
end contador_bcd_arch;
