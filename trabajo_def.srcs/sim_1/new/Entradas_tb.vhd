
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Entradas_tb is
end Entradas_tb;

architecture tb of Entradas_tb is
  component Entradas
    Port (
        CLK       : in std_logic;
        INICIO    : in std_logic;  --BTNL
        STOP       : in std_logic;  --BTNR
        ZERO       : in std_logic;  --BTNU
        CAMBIO    : IN STD_LOGIC;   --BTND
        reset     : in std_logic;
        INICIO_out   : out std_logic;
        STOP_out   : out std_logic;
        ZERO_out   : out std_logic;
        CAMBIO_out   : out std_logic;
        reset_out : out std_logic
    );
  end component;
  
    signal CLK       : std_logic;
    signal INICIO       : std_logic;
    signal STOP       : std_logic;
    signal ZERO       : std_logic;
    signal CAMBIO       : std_logic;
    signal reset     : std_logic;
    signal INICIO_out   : std_logic;
    signal STOP_out   : std_logic;
    signal ZERO_out   : std_logic;
    signal CAMBIO_out   : std_logic;
    signal reset_out : std_logic;

    constant TbPeriod : time := 100 ns; -- EDIT Put right period here
    signal TbClock : std_logic := '0';
    signal TbSimEnded : std_logic := '0';

BEGIN

dut : Entradas
    port map (CLK        => CLK,
              INICIO     => INICIO,
              STOP       => STOP,
              ZERO       => ZERO,
              CAMBIO     => CAMBIO,
              reset      => reset,
              INICIO_out => INICIO_out,
              STOP_out   => STOP_out,
              ZERO_out   => ZERO_out,
              CAMBIO_out => CAMBIO_out,
              reset_out  => reset_out);

    -- Clock generation
    TbClock <= not TbClock after TbPeriod/2 when TbSimEnded /= '1' else '0';

    -- EDIT: Check that CLK is really your main clock signal
    CLK <= TbClock;

    stimuli : process
    begin
        -- EDIT Adapt initialization as needed
        INICIO <= '0';
        STOP   <= '0';
        ZERO   <= '0';
        CAMBIO <= '0';

        -- Reset generation
        -- EDIT: Check that reset is really your reset signal
        reset <= '1';
        wait for 100 ns;
        reset <= '0';
        wait for 100 ns;

        -- EDIT Add stimuli here
        INICIO <= '1';
        --wait for 100 * TbPeriod
        wait for 100ns;
        STOP <= '1';
        --wait for 100 * TbPeriod;
        wait for 100ns;
        ZERO <= '1';
        --wait for 100 * TbPeriod;
        wait for 100ns;
        CAMBIO <= '1';
       --wait for 100 * TbPeriod;
       wait for 100ns;
        INICIO <= '0';
        --wait for 100 * TbPeriod;
        wait for 100ns;
        STOP <= '0';
        --wait for 100 * TbPeriod;
        wait for 100ns;
        ZERO <= '0';
        --wait for 100 * TbPeriod;
        wait for 100ns;
        CAMBIO <= '0';
        --wait for 100 * TbPeriod;
        wait for 100ns;

        -- Stop the clock and hence terminate the simulation
        TbSimEnded <= '1';
        wait;
    end process;

end tb;