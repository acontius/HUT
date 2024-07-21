LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY mux2in1 IS 
    GENERIC (size : INTEGER);
    PORT(
        in0,in1 : IN STD_LOGIC_VECTOR(size - 1 DOWNTO 0);
        sel     : IN STD_LOGIC;
        outPut  : OUT STD_LOGIC_VECTOR(size - 1 DOWNTO 0)
    );
END ENTITY; --Mux 2/1

ARCHITECTURE behavioral OF mux2in1 IS 
    BEGIN
        PROCESS(in0,in1,sel)
        BEGIN
            IF (sel = '0') THEN
                outPut <= in0;
            ELSE
                outPut <= in1;
            END IF;
        END PROCESS;
END ARCHITECTURE; -- mux2/1 behave