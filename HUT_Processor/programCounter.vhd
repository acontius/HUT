LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY program_counter IS
    PORT (
        clk, rst, load : IN STD_LOGIC;
        pc_in          : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
        pc_out         : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
    );
END ENTITY program_counter;

ARCHITECTURE behavioral OF program_counter IS
    SIGNAL pc_reg : STD_LOGIC_VECTOR(15 DOWNTO 0) := (OTHERS => '0');
BEGIN
    PROCESS (clk, rst)
    BEGIN
        IF rst = '1' THEN
            pc_reg <= (OTHERS => '0');
        ELSIF rising_edge(clk) THEN
            IF load = '1' THEN
                pc_reg <= pc_in;
            ELSE
                pc_reg <= pc_reg + 1;
            END IF;
        END IF;
    END PROCESS;
    pc_out <= pc_reg;
END ARCHITECTURE behavioral;
