library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Entradas is
 Port (
        CLK       : in std_logic;
        INICIO    : in std_logic;   --BTNL
        STOP       : in std_logic;  --BTNR
        ZERO       : in std_logic;  --BTNU
        reset     : in std_logic;
        INICIO_out   : out std_logic;
        STOP_out   : out std_logic;
        ZERO_out   : out std_logic;
        reset_out : out std_logic
    );
end Entradas;

architecture Behavioral of Entradas is

    signal sync_auxINICIO : std_logic;
    signal sync_auxSTOP: std_logic;
    signal sync_auxZERO: std_logic;
    
    signal sync_auxReset: std_logic;
    
    
    COMPONENT SINCRONIZADOR
       PORT (
              async_in : IN std_logic;
              clk: IN std_logic;
              sync_out : OUT std_logic
       );
    END COMPONENT;

    COMPONENT FLANCO
       PORT (
              sync_in : IN std_logic;
              clk: IN std_logic;
              edge : OUT std_logic
       );
    END COMPONENT;
    
begin
    Sincronizador1: SINCRONIZADOR 
    PORT MAP(
        ASYNC_IN=>INICIO,
        CLK=>clk,
        SYNC_OUT=>sync_auxINICIO
    );

    DetectorFlanco: FLANCO 
    PORT MAP(
        clk=>clk,
        SYNC_IN=>sync_auxINICIO,
        EDGE=>INICIO_out
    );

    Sincronizador2: SINCRONIZADOR 
    PORT MAP(
        ASYNC_IN=>STOP,
        CLK=>clk,
        SYNC_OUT=>sync_auxSTOP
    );

    DetectorFlanco2: FLANCO 
    PORT MAP(
        clk=>clk,
        SYNC_IN=>sync_auxSTOP,
        EDGE=>STOP_out
    );

    Sincronizador3: SINCRONIZADOR 
    PORT MAP(
        ASYNC_IN=>ZERO,
        CLK=>clk,
        SYNC_OUT=>sync_auxZERO
    );

    DetectorFlanco3: FLANCO 
    PORT MAP(
        clk=>clk,
        SYNC_IN=>sync_auxZERO,
        EDGE=>ZERO_out
    );
    
    Sincronizador4: SINCRONIZADOR 
    PORT MAP(
        ASYNC_IN=>reset,
        CLK=>clk,
        SYNC_OUT=>sync_auxReset
    );

    DetectorFlanco4: FLANCO 
    PORT MAP(
        clk=>clk,
        SYNC_IN=>sync_auxReset,
        EDGE=>reset_out
    );
end behavioral;