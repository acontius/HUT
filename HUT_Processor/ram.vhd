LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE WORK.utilities.ALL;

ENTITY ram IS 
    GENERIC (adr_size, data_size : INTEGER);
    PORT(
        clk, we : IN STD_LOGIC;
        adr     : IN STD_LOGIC_VECTOR(adr_size - 1 DOWNTO 0);
        d_in    : IN STD_LOGIC_VECTOR(data_size - 1 DOWNTO 0);
        d_out   : OUT STD_LOGIC_VECTOR(data_size - 1 DOWNTO 0)
    );
END ENTITY; --RAM

ARCHITECTURE behavioral OF ram IS 
    TYPE ram_type IS ARRAY (0 TO (2 ** adr_size - 1)) OF STD_LOGIC_VECTOR(data_size - 1 DOWNTO 0);
    SIGNAL myRam : ram_type;
    BEGIN
        PROCESS(clk)
        BEGIN
            IF (clk'EVENT AND (clk = '1')) THEN 
                IF (we = '1') THEN 
                    myRam(bin2int(adr)) <= d_in;
                END IF;
            END IF;
        END PROCESS;
    d_out <= myRam(bin2int(adr));
END ARCHITECTURE;