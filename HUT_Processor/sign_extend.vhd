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
        process(imm_in)
        begin
            imm_out(8 downto 0) <= imm_in(8 downto 0);
            imm_out(15 downto 9)<= (others => imm_in(8));
        end process;
END ARCHITECTURE; --Sign Extend