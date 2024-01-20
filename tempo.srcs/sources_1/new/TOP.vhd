
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity TOP is
Port ( 
        CLK      : in std_logic;
        INICIO   : in std_logic;   --BTNL
        STOP     : in std_logic;   --BTNR
        ZERO     : in std_logic;   --BTNU
        reset    : in std_logic;
        refresh  : out std_logic_vector(7 downto 0); --vector que pone a 1 el ánodo correspondiente para actualizar
        dis_exit : out std_logic_vector(6 downto 0); --salida de los displays
        led : out std_logic
    );
end TOP;

architecture Behavioral of TOP is
    
    signal sync_auxINICIO: std_logic;
    signal sync_auxSTOP: std_logic;
    signal sync_auxZERO: std_logic;
    
    signal INICIO_aux: std_logic;
    signal STOP_aux: std_logic;
    signal ZERO_aux: std_logic;
    signal Reset_aux: std_logic;
 
    signal dis1_aux : std_logic_vector(3 downto 0);
    signal dis2_aux : std_logic_vector(3 downto 0);
    signal dis3_aux : std_logic_vector(3 downto 0);
    signal dis4_aux : std_logic_vector(3 downto 0);
    signal dis5_aux : std_logic_vector(3 downto 0);
    signal dis6_aux : std_logic_vector(3 downto 0);
    signal dis7_aux : std_logic_vector(3 downto 0);
    signal dis8_aux : std_logic_vector(3 downto 0);
    
    

    COMPONENT Entradas
       PORT (
            CLK : in std_logic;
            INICIO : in std_logic;
            STOP : in std_logic;
            ZERO : in std_logic;
            reset : in std_logic;
            INICIO_out : out std_logic;
            STOP_out : out std_logic;
            ZERO_out : out std_logic;
            reset_out : out std_logic
       );
    END COMPONENT;
    

    COMPONENT Inverso
       PORT (
            CLK : in std_logic;
            display1 : out std_logic_vector(3 downto 0);
            display2 : out std_logic_vector(3 downto 0);
            display3 : out std_logic_vector(3 downto 0);
            display4 : out std_logic_vector(3 downto 0);
            display5 : out std_logic_vector(3 downto 0);
            display6 : out std_logic_vector(3 downto 0);
            display7 : out std_logic_vector(3 downto 0);
            display8 : out std_logic_vector(3 downto 0);
            Habilitar_A : in std_logic;
            Start : in std_logic;
            Pause : in std_logic;
            Reset : in std_logic
       );
    END COMPONENT;




    
    COMPONENT Displays
       PORT (
        CLK : in std_logic;
        display1 : in std_logic_vector(3 downto 0);
        display2 : in std_logic_vector(3 downto 0);
        display3 : in std_logic_vector(3 downto 0);
        display4 : in std_logic_vector(3 downto 0);
        display5 : in std_logic_vector(3 downto 0);
        display6 : in std_logic_vector(3 downto 0);
        display7 : in std_logic_vector(3 downto 0);
        display8 : in std_logic_vector(3 downto 0);
        refresh : out std_logic_vector(7 downto 0);
        dis_exit : out std_logic_vector(6 downto 0)
       );
    END COMPONENT;      
       
begin

        GestorEntradas1 : Entradas PORT MAP(
        CLK => CLK,
        INICIO => INICIO,
        STOP => STOP,
        ZERO => ZERO,
        reset => reset,
        INICIO_out => INICIO_aux,
        STOP_out => STOP_aux,
        ZERO_out => ZERO_aux,
        reset_out => Reset_aux
    );
    
    
        Inverso1 : Inverso PORT MAP(
        CLK=>clk,
        display1=>dis1_aux,
        display2=>dis2_aux,
        display3=>dis3_aux,
        display4=>dis4_aux,
        display5=>dis5_aux,
        display6=>dis6_aux,
        display7=>dis7_aux,
        display8=>dis8_aux,
        Habilitar_A=>'1',
        Start=>INICIO_aux,
        Pause=>STOP_aux,
        Reset=>ZERO_aux
    );
    
    
        Dispalys1 : Displays PORT MAP(
        CLK=>clk,
        display1=>dis1_aux,
        display2=>dis2_aux,
        display3=>dis3_aux,
        display4=>dis4_aux,
        display5=>dis5_aux,
        display6=>dis6_aux,
        display7=>dis7_aux,
        display8=>dis8_aux,
        refresh=>refresh,
        dis_exit=>dis_exit
     );

end Behavioral;
