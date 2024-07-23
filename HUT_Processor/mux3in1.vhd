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
        CASE sel IS 
            WHEN "00" =>
                outPut <= in1;
            WHEN "01" =>
                outPut <= in2;
            WHEN "10" =>
                outPut <= in3;
            WHEN OTHERS => 
                outPut <= (OTHERS => '0');
        END CASE;
    END PROCESS;
END ARCHITECTURE; --mux3/1 behave