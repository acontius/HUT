LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY alu IS 
    PORT(
        in1, in2 : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
        alu_opr  : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
        outPut   : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
        zeroFlag : OUT STD_LOGIC
    );
END ENTITY alu;

ARCHITECTURE behavioral OF alu IS 
    SIGNAL temp : STD_LOGIC_VECTOR(15 DOWNTO 0);
BEGIN
    PROCESS(in1, in2, alu_opr)
    BEGIN
        CASE alu_opr IS 
            WHEN "000" => 
                temp <= in1 + in2;
            WHEN "001" => 
                temp <= in1 - in2;
            WHEN "010" => 
                temp <= in1 AND in2;
            WHEN "011" => 
                temp <= in1 OR in2;
            WHEN "100" => 
                temp <= in1 NAND in2;
            WHEN "101" => 
                temp <= in1 NOR in2;
            WHEN "110" => 
                temp <= NOT in1;
            WHEN OTHERS => 
                temp <= in1;
        END CASE;
    END PROCESS;
    
    zeroFlag <= '1' WHEN (temp = X"0000") ELSE '0';
    outPut <= temp;
END ARCHITECTURE behavioral;
