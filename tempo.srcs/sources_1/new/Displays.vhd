
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Displays is
generic(
        width:positive:=3
        );
    port(
        CLK : in std_logic;
        display1 : in std_logic_vector(width downto 0);
        display2 : in std_logic_vector(width downto 0);
        display3 : in std_logic_vector(width downto 0);
        display4 : in std_logic_vector(width downto 0);
        display5 : in std_logic_vector(width downto 0);
        display6 : in std_logic_vector(width downto 0);
        display7 : in std_logic_vector(width downto 0);
        display8 : in std_logic_vector(width downto 0);
        refresh : out std_logic_vector(7 downto 0); --vector que pone a 1 el ánodo correspondiente para actualizar
        dis_exit : out std_logic_vector(6 downto 0) --salida de los displays
    );
end Displays;

architecture Behavioral of Displays is

    signal dis1 : std_logic_vector(6 downto 0);
    signal dis2 : std_logic_vector(6 downto 0);
    signal dis3 : std_logic_vector(6 downto 0);
    signal dis4 : std_logic_vector(6 downto 0);
    signal dis5 : std_logic_vector(6 downto 0);
    signal dis6 : std_logic_vector(6 downto 0);
    signal dis7 : std_logic_vector(6 downto 0);
    signal dis8 : std_logic_vector(6 downto 0);
    
    
    signal flag : integer := 1;
    
    signal clk_10khz : std_logic;
    
    COMPONENT clk10khz
       PORT (
              CLK: in  STD_LOGIC;
              clk_1hz : out STD_LOGIC
            );
     END COMPONENT;
    
    COMPONENT deco
       PORT (
              code : IN std_logic_vector(3 DOWNTO 0);
              led : OUT std_logic_vector(6 DOWNTO 0)
       );
   END COMPONENT;
   
begin

Inst_clk10khz: clk10khz 
    PORT MAP (
        CLK => CLK,
        CLK_1hz => clk_10khz
    );

Inst_deco1: deco PORT MAP (
        code => display1,
        led => dis1
);
Inst_deco2: deco PORT MAP (
        code => display2,
        led => dis2
);
Inst_deco3: deco PORT MAP (
        code => display3,
        led => dis3
);
Inst_deco4: deco PORT MAP (
        code => display4,
        led => dis4
);
Inst_deco5: deco PORT MAP (
        code => display5,
        led => dis5
);
Inst_deco6: deco PORT MAP (
        code => display6,
        led => dis6
);
Inst_deco7: deco PORT MAP (
        code => display7,
        led => dis7
);
Inst_deco8: deco PORT MAP (
        code => display8,
        led => dis8
);


    process (clk_10khz)
    begin
        if rising_edge(clk_10khz) then
            if flag=1 then
                refresh(0) <=  '0';
                refresh(7 downto 1) <=  "1111111";
                dis_exit <= dis1;
                flag<=2;
            end if;
            if flag=2 then
                refresh(1) <=  '0';
                refresh(0) <=  '1';
                refresh(7 downto 2) <=  "111111";
                dis_exit <= dis2;
                flag<=3;
            end if;
            if flag=3 then
                refresh(2) <=  '0';
                refresh(1 downto 0) <=  "11";
                refresh(7 downto 3) <=  "11111";
                dis_exit <= dis3;
                flag<=4;
            end if;
            if flag=4 then
                refresh(3) <=  '0';
                refresh(2 downto 0) <=  "111";
                refresh(7 downto 4) <=  "1111";
                dis_exit <= dis4;
                flag<=5;
            end if;
            if flag=5 then
                refresh(4) <=  '0';
                refresh(3 downto 0) <=  "1111";
                refresh(7 downto 5) <=  "111";
                dis_exit <= dis5;
                flag<=6;
            end if;
            if flag=6 then
                refresh(5) <=  '0';
                refresh(4 downto 0) <=  "11111";
                refresh(7 downto 6) <=  "11";
                dis_exit <= dis6;
                flag<=7;
            end if;
            if flag=7 then
                refresh(6) <=  '0';
                refresh(5 downto 0) <=  "111111";
                refresh(7) <=  '1';
                dis_exit <= dis7;
                flag<=8;
            end if;
            if flag=8 then
                refresh(7) <=  '0';
                refresh(6 downto 0) <=  "1111111";
                dis_exit <= dis8;
                flag<=1;
            end if;
        end if;

    end process;



end Behavioral;

