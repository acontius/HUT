LIBRARY IEEE;
USE IEEE.NUMERIC_STD.ALL;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY ram IS 
    GENERIC (adr_size, data_size : INTEGER);
    PORT(
        clk, we : IN STD_LOGIC;
        adr     : IN STD_LOGIC_VECTOR(adr_size - 1 DOWNTO 0);
        d_in    : IN STD_LOGIC_VECTOR(data_size - 1 DOWNTO 0);
        d_out   : OUT STD_LOGIC_VECTOR(data_size - 1 DOWNTO 0)
    );
END ENTITY ram;

ARCHITECTURE behavioral OF ram IS 
    TYPE ram_type IS ARRAY (0 TO (2 ** adr_size - 1)) OF STD_LOGIC_VECTOR(data_size - 1 DOWNTO 0);
    SIGNAL myRam : ram_type;
BEGIN
    PROCESS(clk)
    BEGIN
        IF rising_edge(clk) THEN 
            IF we = '1' THEN 
                myRam(to_integer(unsigned(adr))) <= d_in;
            END IF;
            d_out <= myRam(to_integer(unsigned(adr)));
        END IF;
    END PROCESS;
END ARCHITECTURE behavioral;
