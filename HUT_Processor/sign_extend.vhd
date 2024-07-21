LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY sign_extend IS 
    PORT (
        imm_in : IN STD_LOGIC_VECTOR(8 DOWNTO 0);
        imm_out: OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
    );
END ENTITY; --Sign Extend (SF)

ARCHITECTURE behavioral OF sign_extend IS 
    BEGIN 
        imm_out(8 DOWNTO 0) <= imm_in(8 DOWNTO 0);
        generation1 : FOR i IN 0 TO 15 GENERATE
            generation2 : IF (i <= 8) GENERATE    
                imm_out(i) <= imm_in(i);
            END GENERATE;
            generation3 : IF (i >= 9) GENERATE
                imm_out(i) <= imm_in(8);
            END GENERATE;
        END GENERATE;
    END ARCHITECTURE; --Sign Extend