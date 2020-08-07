library IEEE;
use IEEE.std_logic_1164.all;



entity testbench is
-- Empty
end testbench;

architecture behavior of testbench is
    component example_3_4 is
        port (
            A: in std_logic;
            B: in std_logic;
            C: in std_logic;
            D: in std_logic;
            E: out std_logic;
            F: out std_logic;
            G: out std_logic_vector(4 downto 0));
    end component;
    signal A : std_logic;
    signal B : std_logic;
    signal C : std_logic;
    signal D : std_logic;
    signal E : std_logic;
    signal F : std_logic;
    signal G : std_logic_vector(4 downto 0);
    
    
    -- Cambiar número de entradas y salidas
	function display(constant T: integer := 0; constant inp : std_logic_vector(3 downto 0) ;
                        constant otp : std_logic_vector(6 downto 0) ) return string is
    begin
    --Cambiar orden -- El (2) se usa para obtener solo el caracter
        return "T, " & INTEGER'IMAGE(T) & 
        ", INPUTS, A, " & std_logic'IMAGE(inp(3))(2) & 
                ", B, " & std_logic'IMAGE(inp(2))(2) & 
                ", C, " & std_logic'IMAGE(inp(1))(2) & 
                ", D, " & std_logic'IMAGE(inp(0))(2) & 
        ", OUTPUTS, E, " & std_logic'IMAGE(otp(6))(2) & 
                 ", F, " & std_logic'IMAGE(otp(5))(2) & 
                 ", G[4:0], " & std_logic'IMAGE(otp(4))(2) &
                                std_logic'IMAGE(otp(3))(2) &
                                std_logic'IMAGE(otp(2))(2) &
                                std_logic'IMAGE(otp(1))(2) &
                                std_logic'IMAGE(otp(0))(2) ;
                 
    end function display;
begin
    DUT: example_3_4 port map (
        A => A,
        B => B,
        C => C,
        D => D,
        E => E,
        F => F,
        G => G
    );
 

    stim_proc: process
    begin
    	
      A <= '0'; B <= '0'; C <= '0'; D <= '0'; wait for 10 ns; report display(0, A & B & C & D, E & F & G);
      A <= '0'; B <= '0'; C <= '0'; D <= '1'; wait for 10 ns; report display(2, A & B & C & D, E & F & G);
      A <= '0'; B <= '0'; C <= '1'; D <= '0'; wait for 10 ns; report display(4, A & B & C & D, E & F & G);
      A <= '0'; B <= '0'; C <= '1'; D <= '1'; wait for 10 ns; report display(6, A & B & C & D, E & F & G);
      A <= '0'; B <= '1'; C <= '0'; D <= '0'; wait for 10 ns; report display(8, A & B & C & D, E & F & G);
      A <= '0'; B <= '1'; C <= '0'; D <= '1'; wait for 10 ns; report display(10, A & B & C & D, E & F & G);
      A <= '0'; B <= '1'; C <= '1'; D <= '0'; wait for 10 ns; report display(12, A & B & C & D, E & F & G);
      A <= '0'; B <= '1'; C <= '1'; D <= '1'; wait for 10 ns; report display(14, A & B & C & D, E & F & G);
      A <= '1'; B <= '0'; C <= '0'; D <= '0'; wait for 10 ns; report display(16, A & B & C & D, E & F & G);
      A <= '1'; B <= '0'; C <= '0'; D <= '1'; wait for 10 ns; report display(18, A & B & C & D, E & F & G);
      A <= '1'; B <= '0'; C <= '1'; D <= '0'; wait for 10 ns; report display(20, A & B & C & D, E & F & G);
      A <= '1'; B <= '0'; C <= '1'; D <= '1'; wait for 10 ns; report display(22, A & B & C & D, E & F & G);
      A <= '1'; B <= '1'; C <= '0'; D <= '0'; wait for 10 ns; report display(24, A & B & C & D, E & F & G);
      A <= '1'; B <= '1'; C <= '0'; D <= '1'; wait for 10 ns; report display(26, A & B & C & D, E & F & G);
      A <= '1'; B <= '1'; C <= '1'; D <= '0'; wait for 10 ns; report display(28, A & B & C & D, E & F & G);
      A <= '1'; B <= '1'; C <= '1'; D <= '1'; wait for 10 ns; report display(30, A & B & C & D, E & F & G);
A <= '0'; B <= '0'; C <= '0'; D <= '0'; wait for 10 ns; report display(30, A & B & C & D, E & F & G);
  wait;
    end process;
end;
