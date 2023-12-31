library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE ieee.std_logic_arith.ALL;
USE ieee.std_logic_unsigned.ALL;

ENTITY deco IS
    PORT (
        code : IN std_logic_vector(3 DOWNTO 0);
        led : OUT std_logic_vector(6 DOWNTO 0)
     );
END ENTITY deco;

ARCHITECTURE dataflow OF deco IS
    BEGIN
    WITH code SELECT
        led <=  "0000001" WHEN "0000",--0
                "1001111" WHEN "0001",--1
                "0010010" WHEN "0010",--2
                "0000110" WHEN "0011",--3
                "1001100" WHEN "0100",--4
                "0100100" WHEN "0101",--5
                "0100000" WHEN "0110",--6
                "0001111" WHEN "0111",--7
                "0000000" WHEN "1000",--8
                "0000100" WHEN "1001",--9
                "0110001" WHEN "1010",--C
                "1110000" WHEN "1011",--t
                "1111110" WHEN "1100",--'-'
                "0110000" WHEN others;--E
END ARCHITECTURE dataflow;