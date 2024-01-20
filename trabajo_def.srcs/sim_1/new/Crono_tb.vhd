library ieee;
use ieee.std_logic_1164.all;

entity Crono_tb is
end Crono_tb;

architecture tb of Crono_tb is

    component Contador
        port (CLK      : in std_logic;
              display1    : out std_logic_vector (3 downto 0);
              display2    : out std_logic_vector (3 downto 0);
              display3    : out std_logic_vector (3 downto 0);
              display4    : out std_logic_vector (3 downto 0);
              display5    : out std_logic_vector (3 downto 0);
              display6    : out std_logic_vector (3 downto 0);
              display7    : out std_logic_vector (3 downto 0);
              display8    : out std_logic_vector (3 downto 0);
              Habilitar_A : in std_logic;
              Start    : in std_logic;
              Pause    : in std_logic;
              Reset    : in std_logic);
    end component;

    signal CLK      : std_logic;
    signal display1    : std_logic_vector (3 downto 0);
    signal display2    : std_logic_vector (3 downto 0);
    signal display3    : std_logic_vector (3 downto 0);
    signal display4    : std_logic_vector (3 downto 0);
    signal display5    : std_logic_vector (3 downto 0);
    signal display6    : std_logic_vector (3 downto 0);
    signal display7    : std_logic_vector (3 downto 0);
    signal display8    : std_logic_vector (3 downto 0);
    signal Habilitar_A : std_logic;
    signal Start    : std_logic;
    signal Pause    : std_logic;
    signal Reset    : std_logic;

    constant TbPeriod : time := 100 ns; -- EDIT Put right period here
    signal TbClock : std_logic := '0';
    signal TbSimEnded : std_logic := '0';

begin

    dut : Contador
    port map (CLK      => CLK,
              display1    => display1,
              display2    => display2,
              display3    => display3,
              display4    => display4,
              display5    => display5,
              display6    => display6,
              display7    => display7,
              display8    => display8,
              Habilitar_A => Habilitar_A,
              Start    => Start,
              Pause    => Pause,
              Reset    => Reset
    );

    -- Clock generation
    TbClock <= not TbClock after TbPeriod/2 when TbSimEnded /= '1' else '0';

    -- EDIT: Check that CLK is really your main clock signal
    CLK <= TbClock;

    stimuli : process
    begin
        -- EDIT Adapt initialization as needed
        Habilitar_A <= '0';
        Start <= '0';
        Pause <= '0';

        -- Reset generation
        -- EDIT: Check that Reset is really your reset signal
        Reset <= '1';
        wait for 100 ns;
        Reset <= '0';
        wait for 100 ns;

        -- EDIT Add stimuli here
        Habilitar_a<='1';
        wait for 100 ns;
        start<='1';
        wait for 100 ns;
        start <= '0';
        wait for 500 ns;
        pause<='1';
        wait for 100 ns;
        pause <= '0';
        wait for 200 ns;
        reset<='1';
        wait for 100 ns;
        reset <= '0';
        wait for 200 ns;
        start<='1';
        wait for 100 ns;
        start <= '0';
        
        wait for 1000 ns;

        -- Stop the clock and hence terminate the simulation
        TbSimEnded <= '1';
        wait;
    end process;

end tb;
   
