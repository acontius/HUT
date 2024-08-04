LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY adder_16bit IS
    PORT (
        A        : IN  STD_LOGIC_VECTOR(15 DOWNTO 0);
        B        : IN  STD_LOGIC_VECTOR(15 DOWNTO 0);
        SUM      : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
        CARRY_OUT: out std_logic
    );  
END ENTITY adder_16bit;

ARCHITECTURE behavioral OF adder_16bit IS
    SIGNAL temp_sum : STD_LOGIC_VECTOR(16 DOWNTO 0);
BEGIN
    PROCESS(A, B)
    BEGIN
        temp_sum <= ('0' & A) + ('0' & B); 
        SUM      <= temp_sum(15 DOWNTO 0); 
        CARRY_OUT<= temp_sum(16);
    END PROCESS;
END ARCHITECTURE behavioral;
