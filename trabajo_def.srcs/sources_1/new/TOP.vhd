library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity TOP is
Port ( 
        CLK      : in std_logic;
        INICIO   : in std_logic;   --BTNL
        STOP     : in std_logic;   --BTNR
        ZERO     : in std_logic;   --BTNU
        CAMBIO   : in std_logic;   --BTND
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
    signal Cambio_aux: std_logic;
    
    signal Habilitar_A : std_logic;
    signal Habilitar_B : std_logic;
    signal Habilitar_D : std_logic;
 
    signal dis1_aux : std_logic_vector(3 downto 0);
    signal dis2_aux : std_logic_vector(3 downto 0);
    signal dis3_aux : std_logic_vector(3 downto 0);
    signal dis4_aux : std_logic_vector(3 downto 0);
    signal dis5_aux : std_logic_vector(3 downto 0);
    signal dis6_aux : std_logic_vector(3 downto 0);
    signal dis7_aux : std_logic_vector(3 downto 0);
    signal dis8_aux : std_logic_vector(3 downto 0);
    
    signal dis1_ME: std_logic_vector(3 downto 0);
    signal dis2_ME : std_logic_vector(3 downto 0);
    signal dis3_ME : std_logic_vector(3 downto 0);
    signal dis4_ME : std_logic_vector(3 downto 0);
    signal dis5_ME : std_logic_vector(3 downto 0);
    signal dis6_ME : std_logic_vector(3 downto 0);
    signal dis7_ME : std_logic_vector(3 downto 0);
    signal dis8_ME : std_logic_vector(3 downto 0);
    
    signal dis1_C: std_logic_vector(3 downto 0);
    signal dis2_C : std_logic_vector(3 downto 0);
    signal dis3_C : std_logic_vector(3 downto 0);
    signal dis4_C : std_logic_vector(3 downto 0);
    signal dis5_C : std_logic_vector(3 downto 0);
    signal dis6_C : std_logic_vector(3 downto 0);
    signal dis7_C : std_logic_vector(3 downto 0);
    signal dis8_C : std_logic_vector(3 downto 0);
    
    signal dis1_T: std_logic_vector(3 downto 0);
    signal dis2_T : std_logic_vector(3 downto 0);
    signal dis3_T : std_logic_vector(3 downto 0);
    signal dis4_T : std_logic_vector(3 downto 0);
    signal dis5_T : std_logic_vector(3 downto 0);
    signal dis6_T : std_logic_vector(3 downto 0);
    signal dis7_T : std_logic_vector(3 downto 0);
    signal dis8_T : std_logic_vector(3 downto 0);
    
    

    COMPONENT Entradas
       PORT (
            CLK : in std_logic;
            INICIO : in std_logic;
            STOP : in std_logic;
            ZERO : in std_logic;
            CAMBIO : IN STD_LOGIC;
            reset : in std_logic;
            INICIO_out : out std_logic;
            STOP_out : out std_logic;
            ZERO_out : out std_logic;
            CAMBIO_out : out std_logic;
            reset_out : out std_logic
       );
    END COMPONENT;
    
    component MaquinaEstados
    PORT (
            CLK         : in std_logic;
            Boton1        : in std_logic;
            Boton2        : in std_logic;
            Boton3        : in std_logic;
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
            Habilitar_D : out std_logic :='1'
   );
 end component;

    COMPONENT Contador
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
            Habilitar_B : in std_logic;
            Start : in std_logic;
            Pause : in std_logic;
            Reset : in std_logic
       );
    END COMPONENT;

COMPONENT Demux 
  PORT (
         Habilitar_A : in std_logic;
         Habilitar_B : in std_logic;
         Habilitar_D : in std_logic;
        
         Display1_ME : in std_logic_vector(3 downto 0);
         Display2_ME : in std_logic_vector(3 downto 0);
         Display3_ME : in std_logic_vector(3 downto 0);
         Display4_ME : in std_logic_vector(3 downto 0);
         Display5_ME : in std_logic_vector(3 downto 0);
         Display6_ME : in std_logic_vector(3 downto 0);
         Display7_ME : in std_logic_vector(3 downto 0);
         Display8_ME : in std_logic_vector(3 downto 0);
        
         Display1_C : in std_logic_vector(3 downto 0);
         Display2_C : in std_logic_vector(3 downto 0);
         Display3_C : in std_logic_vector(3 downto 0);
         Display4_C : in std_logic_vector(3 downto 0);
         Display5_C : in std_logic_vector(3 downto 0);
         Display6_C : in std_logic_vector(3 downto 0);
         Display7_C : in std_logic_vector(3 downto 0);
         Display8_C : in std_logic_vector(3 downto 0);
        
         Display1_T : in std_logic_vector(3 downto 0);
         Display2_T : in std_logic_vector(3 downto 0);
         Display3_T : in std_logic_vector(3 downto 0);
         Display4_T : in std_logic_vector(3 downto 0);
         Display5_T : in std_logic_vector(3 downto 0);
         Display6_T : in std_logic_vector(3 downto 0);
         Display7_T : in std_logic_vector(3 downto 0);
         Display8_T : in std_logic_vector(3 downto 0);
        
         Display1 : out std_logic_vector(3 downto 0);
         Display2 : out std_logic_vector(3 downto 0);
         Display3 : out std_logic_vector(3 downto 0);
         Display4 : out std_logic_vector(3 downto 0);
         Display5 : out std_logic_vector(3 downto 0);
         Display6 : out std_logic_vector(3 downto 0);
         Display7 : out std_logic_vector(3 downto 0);
         Display8 : out std_logic_vector(3 downto 0)
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
        CAMBIO => CAMBIO,
        reset => reset,
        INICIO_out => INICIO_aux,
        STOP_out => STOP_aux,
        ZERO_out => ZERO_aux,
        CAMBIO_OUT => CAMBIO_AUX,
        reset_out => Reset_aux
    );
    
    MaquinaEstados1 : MaquinaEstados 
     PORT MAP(
        CLK         => CLK,
        Boton1      => INICIO_aux,
        Boton2      => CAMBIO_aux,
        Boton3      => ZERO_AUX,
        display1    => dis1_ME,
        display2    => dis2_ME,
        display3    => dis3_ME,
        display4    => dis4_ME,
        display5    => dis5_ME,
        display6    => dis6_ME,
        display7    => dis7_ME,
        display8    => dis8_ME,
        Habilitar_A => Habilitar_A,
        Habilitar_B => Habilitar_B,
        Habilitar_D => Habilitar_D
   ); 
    
     Crono1 : Contador PORT MAP(
        CLK=>clk,
        display1=>dis1_C,
        display2=>dis2_C,
        display3=>dis3_C,
        display4=>dis4_C,
        display5=>dis5_C,
        display6=>dis6_C,
        display7=>dis7_C,
        display8=>dis8_C,
        Habilitar_A=>Habilitar_A,
        Start=>INICIO_aux,
        Pause=>STOP_aux,
        Reset=>ZERO_aux
    );
    
        Inverso1 : Inverso PORT MAP(
        CLK=>clk,
        display1=>dis1_T,
        display2=>dis2_T,
        display3=>dis3_T,
        display4=>dis4_T,
        display5=>dis5_T,
        display6=>dis6_T,
        display7=>dis7_T,
        display8=>dis8_T,
        Habilitar_B=>Habilitar_B,
        Start=>INICIO_aux,
        Pause=>STOP_aux,
        Reset=>ZERO_aux
    );
    
    DeMux1 : Demux 
   PORT MAP(
         Habilitar_A => Habilitar_A,
         Habilitar_B => Habilitar_B,
         Habilitar_D => Habilitar_D,
         
         display1_ME => dis1_ME,
         display2_ME => dis2_ME,
         display3_ME => dis3_ME,
         display4_ME => dis4_ME,
         display5_ME => dis5_ME,
         display6_ME => dis6_ME,
         display7_ME => dis7_ME,
         display8_ME => dis8_ME,
         display1_C  => dis1_C,
         display2_C  => dis2_C,
         display3_C  => dis3_C,
         display4_C  => dis4_C,
         display5_C  => dis5_C,
         display6_C  => dis6_C,
         display7_C  => dis7_C,
         display8_C  => dis8_C,
         
         display1_T  => dis1_T,
         display2_T  => dis2_T,
         display3_T  => dis3_T,
         display4_T  => dis4_T,
         display5_T  => dis5_T,
         display6_T  => dis6_T,
         display7_T  => dis7_T,
         display8_T  => dis8_T,
       
         display1    => dis1_aux,
         display2    => dis2_aux,
         display3    => dis3_aux,
         display4    => dis4_aux,
         display5    => dis5_aux,
         display6    => dis6_aux,
         display7    => dis7_aux,
         display8    => dis8_aux
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

