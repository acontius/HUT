LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

ENTITY mux4in1 IS 
    GENERIC (size : INTEGER);
    PORT (
        in0, in1, in2, in3 : IN STD_LOGIC_VECTOR(size - 1 DOWNTO 0);
        sel                : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
        outPut             : OUT STD_LOGIC_VECTOR(size - 1 DOWNTO 0)
    );
END ENTITY; --mux4/1

ARCHITECTURE behavioral OF mux4in1 IS 
    PROCESS(in0, in1, in2, in3, sel)
    BEGIN
        CASE sel IS 
            WHEN "00" => 
                outPut <= in0;
            WHEN "01" => 
                outPut <= in1;
            WHEN "10" => 
                outPut <= in2;
            WHEN "11" => 
                outPut <= in3;
        END CASE;
    END PROCESS;
END ARCHITECTURE; --Mux 4/1         