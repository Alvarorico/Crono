library ieee;
use ieee.std_logic_1164.all;

entity MaquinaEstados_tb is
end MaquinaEstados_tb;

architecture tb of MaquinaEstados_tb is

    component MaquinaEstados
        port (  CLK         : in std_logic;
                Boton1      : in std_logic;
                Boton2      : in std_logic;
                Boton3      : in std_logic;
                display1    : out std_logic_vector(3 downto 0);
                display2    : out std_logic_vector(3 downto 0);
                display3    : out std_logic_vector(3 downto 0);
                display4    : out std_logic_vector(3 downto 0);
                display5    : out std_logic_vector(3 downto 0);
                display6    : out std_logic_vector(3 downto 0);
                display7    : out std_logic_vector(3 downto 0);
                display8    : out std_logic_vector(3 downto 0);
                Habilitar_A : out std_logic :='0';
                Habilitar_B : out std_logic :='0';
                Habilitar_D : out std_logic :='1');
    end component;

    signal CLK         : std_logic;
    signal Boton1      : std_logic;
    signal Boton2      : std_logic;
    signal Boton3      : std_logic;
    signal display1    : std_logic_vector (3 downto 0);
    signal display2    : std_logic_vector (3 downto 0);
    signal display3    : std_logic_vector (3 downto 0);
    signal display4    : std_logic_vector (3 downto 0);
    signal display5    : std_logic_vector (3 downto 0);
    signal display6    : std_logic_vector (3 downto 0);
    signal display7    : std_logic_vector (3 downto 0);
    signal display8    : std_logic_vector (3 downto 0);
    signal Reset       : std_logic;
    signal Habilitar_A : std_logic;
    signal Habilitar_B : std_logic;
    signal Habilitar_D : std_logic;

    constant TbPeriod : time := 100 ns; -- EDIT Put right period here
    signal TbClock : std_logic := '0';
    signal TbSimEnded : std_logic := '0';

begin

    dut : MaquinaEstados
    port map (clk      => clk,
              Boton1       => Boton1,
              Boton2       => Boton2,
              Boton3       => Boton3,
              display1    => display1,
              display2    => display2,
              display3    => display3,
              display4    => display4,
              display5    => display5,
              display6    => display6,
              display7    => display7,
              display8    => display8,
              Habilitar_A => Habilitar_A,
              Habilitar_B => Habilitar_B,
              Habilitar_D => Habilitar_D);

    -- Clock generation
    TbClock <= not TbClock after TbPeriod/2 when TbSimEnded /= '1' else '0';

    -- EDIT: Check that clk is really your main clock signal
    clk <= TbClock;

    stimuli : process
    begin
        -- EDIT Adapt initialization as needed
        Boton1 <= '0'; --Start
        Boton2 <= '0'; --Cambio
        Boton3 <= '0'; --Reset

        -- Reset generation
        -- EDIT: Check that Reset is really your reset signal
 
        wait for 100 ns;

        -- EDIT Add stimuli here
        Boton1 <= '1';
        wait for 100 ns;
        Boton1 <= '0';
        wait for 200 ns;
        Boton3 <= '1';
        wait for 100 ns;
        Boton3 <= '0';
        wait for 100 ns;
        Boton2 <= '1';
        wait for 100 ns;
        Boton2 <= '0';
        wait for 100 ns;
        Boton1 <= '1';
        wait for 100 ns;
        Boton1 <= '0';
        wait for 200 ns;
        Boton3 <= '1';
        wait for 100 ns;
        Boton3 <= '0';
        wait for 100 ns;
        wait for 500 ns;
        -- Stop the clock and hence terminate the simulation
        TbSimEnded <= '1';
        wait;
    end process;

end tb;

