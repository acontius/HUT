LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY mux16in1 IS
    GENERIC (size : INTEGER := 16);
    PORT (
        input : IN STD_LOGIC_VECTOR(16*size-1 DOWNTO 0); 
        sel   : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        outPut: OUT STD_LOGIC_VECTOR(size-1 DOWNTO 0)
    );
END ENTITY mux16in1;

ARCHITECTURE behavioral OF mux16in1 IS
BEGIN
    outPut <= input((to_integer(unsigned(sel)) + 1) * size - 1 DOWNTO to_integer(unsigned(sel)) * size);
END ARCHITECTURE behavioral;
