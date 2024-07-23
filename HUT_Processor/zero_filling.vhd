LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY zero_filling IS 
    PORT(
        imm_in : IN STD_LOGIC_VECTOR(8 DOWNTO 0);
        imm_out: OUt STD_LOGIC_VECTOR(15 DOWNTO 0)
    );
END ENTITY; --Zero Filling(ZF)

ARCHITECTURE behavioral OF zero_filling IS 
BEGIN
    process(imm_in)
    BEGIN
        imm_out(8 downto 0)  <= imm_in(8 downto 0);
        imm_out(15 downto 9) <= (others => '0');
    end process;        
END ARCHITECTURE; --data flow of zero filling