library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity Demux is
  Port (
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
end Demux; 
architecture Behavioral of Demux is

begin
 process(Habilitar_A,Habilitar_B,Habilitar_D)
   begin
     if Habilitar_A='1' then
         Display1 <= Display1_C;
         Display2 <= Display2_C;
         Display3 <= Display3_C;
         Display4 <= Display4_C;
         Display5 <= Display5_C;
         Display6 <= Display6_C;
         Display7 <= Display7_C;
         Display8 <= Display8_C;
        elsif Habilitar_B='1' then
         Display1 <= Display1_T;
         Display2 <= Display2_T;
         Display3 <= Display3_T;
         Display4 <= Display4_T;
         Display5 <= Display5_T;
         Display6 <= Display6_T;
         Display7 <= Display7_T;
         Display8 <= Display8_T;
        elsif Habilitar_D='1' then
         Display1 <= Display1_ME;
         Display2 <= Display2_ME;
         Display3 <= Display3_ME;
         Display4 <= Display4_ME;
         Display5 <= Display5_ME;
         Display6 <= Display6_ME;
         Display7 <= Display7_ME;
         Display8 <= Display8_ME;
     end if;
 end process;
end Behavioral;