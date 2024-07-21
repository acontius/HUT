LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

ENTITY zero_filling IS 
    PORT(
        imm_in : IN STD_LOGIC_VECTOR(8 DOWNTO 0);
        imm_out: OUt STD_LOGIC_VECTOR(15 DOWNTO 0)
    );
END ENTITY; --Zero Filling(ZF)

ARCHITECTURE structural OF zero_filling IS 
    BEGIN
        imm_out(8 DOWNTO 0) <= imm_in(8 DOWNTO 0);
        generation1 : FOR i IN 0 TO 15 GENERATE
            generation2 : IF (i <= 8) GENERATE
                imm_out(i) <= imm_in(i);
            END GENERATE;
            generation3 : IF (i >= 9) GENERATE
                imm_out(i) <= '0';
            END GENERATE;
        END GENERATE;
    END ARCHITECTURE; --data flow of zero filling