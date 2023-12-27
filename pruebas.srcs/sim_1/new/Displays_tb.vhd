library ieee;
use ieee.std_logic_1164.all;

entity Displays_tb is
end Displays_tb;

architecture tb of Displays_tb is

    component Displays
        port (CLK                : in std_logic;
              display1           : in std_logic_vector (3 downto 0);
              display2           : in std_logic_vector (3 downto 0);
              display3           : in std_logic_vector (3 downto 0);
              display4           : in std_logic_vector (3 downto 0);
              display5           : in std_logic_vector (3 downto 0);
              display6           : in std_logic_vector (3 downto 0);
              display7           : in std_logic_vector (3 downto 0);
              display8           : in std_logic_vector (3 downto 0));
             -- refresh            : out std_logic_vector (7 downto 0);
            --  dis_exit           : out std_logic_vector (6 downto 0));
    end component;

    signal CLK            : std_logic;
    signal display1       : std_logic_vector (3 downto 0);
    signal display2       : std_logic_vector (3 downto 0);
    signal display3       : std_logic_vector (3 downto 0);
    signal display4       : std_logic_vector (3 downto 0);
    signal display5       : std_logic_vector (3 downto 0);
    signal display6       : std_logic_vector (3 downto 0);
    signal display7       : std_logic_vector (3 downto 0);
    signal display8       : std_logic_vector (3 downto 0);
   -- signal refresh        : std_logic_vector (7 downto 0);
    --signal dis_exit      : std_logic_vector (6 downto 0);

    constant TbPeriod : time := 100 ns; -- EDIT Put right period here
    signal TbClock : std_logic := '0';
    signal TbSimEnded : std_logic := '0';

begin

    dut : Displays
    port map (CLK             => CLK,
              display1           => display1,
              display2           => display2,
              display3           => display3,
              display4           => display4,
              display5           => display5,
              display6           => display6,
              display7           => display7,
              display8           => display8
              --refresh            => refresh,
              --dis_exit           => dis_exit
              );

    -- Clock generation
    TbClock <= not TbClock after TbPeriod/2 when TbSimEnded /= '1' else '0';

    -- EDIT: Check that CLK is really your main clock signal
    CLK <= TbClock;

    stimuli : process
    begin
        -- EDIT Adapt initialization as needed
        display1 <= "0001";
        display2 <= "1000";
        display3 <= "0110";
        display4 <= "0011";
        display5 <= "1010";
        display6 <= "1100";
        display7 <= "1011";
        display8 <= "1100";


        wait for 8000 ns;

       

        -- Stop the clock and hence terminate the simulation
        TbSimEnded <= '1';
        wait;
    end process;

end tb;
