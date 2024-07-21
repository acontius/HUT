LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

ENTITY mux3in1 IS 
    GENERIC (size : INTEGER);
    PORT(
        in1,in2,in3 : IN STD_LOGIC_VECTOR(size - 1 DOWNTO 0);
        sel         : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
        outPut      : OUT STD_LOGIC_VECTOR(size - 1 DOWNTO 0)
    );
END ENTITY; --mux3in1

ARCHITECTURE behavioral OF mux3in1 IS 
    PROCESS(in1, in2, in3, sel)
    BEGIN
        IF (sel = "00") THEN
            outPut <= in1;
        ELSIF (sel = "01") THEN
            outPut <= in2;
        ELSE 
            outPut <= in3;
    END IF;
    END PROCESS;
END ARCHITECTURE; --mux3/1 behave