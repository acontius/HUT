LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

ENTITY mux16in1 IS 
    GENERIC (size : INTEGER);
    PORT(
        input : IN mux_array; 
        sel   : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        outPut: OUT STD_LOGIC_VECTOR(16 DOWNTO 0)
    );
END ENTITY; --Mux 16/1

ARCHITECTURE behavioral OF mux16in1 IS 
    BEGIN
        outPut <= input(bin2int(sel));
END ARCHITECTURE;