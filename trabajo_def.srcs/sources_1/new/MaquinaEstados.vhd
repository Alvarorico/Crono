library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MaquinaEstados is
 Port ( 
    CLK         : in std_logic;
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
    Habilitar_D : out std_logic :='1'
 );

end MaquinaEstados;

architecture Behavioral of MaquinaEstados is
  type estados is (crono_selec,tempo_selec,crono_func,tempo_func);
    signal actual_state,next_state:estados;
    signal clk_10khz : std_logic;
    
 component clk10khz
   PORT (
     CLK: in STD_LOGIC;
     clk_1hz : out STD_LOGIC
   );
 end component;
begin
 Inst_clk10khz: clk10khz 
   PORT MAP (
     CLK => CLK,
     clk_1hz => clk_10khz
   );
 Salida:process(CLK)
   begin
     if rising_edge(CLK)then
       actual_state<=next_state;
     end if;
   end process;
 
 
 gestionmaquinaestados:process(actual_state,Boton1,Boton2,Boton3)
 begin
   next_state<=actual_state;
   
   case (actual_state)is 
    when crono_selec=>
     if Boton2='1' then
       next_state<=tempo_selec;
      elsif Boton1='1' then
       next_state<=crono_func;
     end if;
     when crono_func=>
     if Boton3='1' then
       next_state<=crono_selec;
     end if;
    when tempo_selec=>
     if Boton2='1' then
       next_state<=crono_selec;
      elsif Boton1='1' then
       next_state<=tempo_func;
     end if;
    when tempo_func=>
     if Boton3='1' then
       next_state<=tempo_selec;
     end if;
    when others => next_state<=actual_state;
   end case;
 end process;

SalidasDisplays : process (actual_state)
 begin
   case(actual_state) is
    when crono_selec=>  --"C---0000"
      display1<="0000";
      display2<="0000";
      display3<="0000";
      display4<="0000";
      display5<="1100";
      display6<="1100";
      display7<="1100";
      display8<="1010";
      Habilitar_A<='0';
      Habilitar_B<='0';
      Habilitar_D<='1';
   when tempo_selec=>  --"t---0000"
      display1<="0000";
      display2<="0000";
      display3<="0000";
      display4<="0000";
      display5<="1100";
      display6<="1100";
      display7<="1100";
      display8<="1011";
      Habilitar_A<='0';
      Habilitar_B<='0';
      Habilitar_D<='1';
   when crono_func=>
      Habilitar_A<='1';
      Habilitar_B<='0';
      Habilitar_D<='0';
    when tempo_func=>
      Habilitar_A<='0';
      Habilitar_B<='1';
      Habilitar_D<='0';
   end case; 
 end process;
 
end Behavioral;