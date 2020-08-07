library IEEE;
use IEEE.std_logic_1164.all;

entity example_3_4 is
port(
  A: in std_logic;
  B: in std_logic;
  C: in std_logic;
  D: in std_logic;
  E: out std_logic;
  F: out std_logic;
  G: out std_logic_vector(4 downto 0));
end example_3_4;

architecture rtl of example_3_4 is
begin
  process(A, B, C, D) is
  begin
    E <= B or (B and C) or (not(B) and D);
    F <= (not(B) and C) or (B and not(C) and not(D));
    G(0) <= B;
    G(1) <= C;
    G(2) <= B;
    G(3) <= A;
    G(4) <= '0';
  end process;
end rtl;
