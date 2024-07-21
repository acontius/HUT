LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.all;

ENTITY reg IS 
    PORT(
        clk,rst,we, : IN STD_LOGIC;
        d_in        : IN STD_LOGIC_VECTOR;
        d_out       : OUT STD_LOGIC_VECTOR
    );
END ENTITY; --register 

ARCHITECTURE behavioral OF reg IS 
    CONSTANT zero : STD_LOGIC_VECTOR(d_in'RANGE) := (OTHERS => '0');
    BEGIN
        PROCESS (clk,rst)
        BEGIN
            IF (rst = '1') THEN
                d_out <= zero;
            ELSIF (clk'EVENT AND (clk = '1')) THEN
                IF (we = '1') THEN
                    d_out <= d_in;
                END IF;
            END IF;
        END PROCESS;
    END ARCHITECTURE; --reg behave