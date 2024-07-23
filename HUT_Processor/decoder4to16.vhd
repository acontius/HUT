LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY decoder4to16 IS
    PORT (
        inputDecoder : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        enable       : IN STD_LOGIC;
        outDecoder   : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
    );
END ENTITY decoder4to16;

ARCHITECTURE behavioral OF decoder4to16 IS
BEGIN
    process(inputDecoder, enable)
    begin
        if enable = '1' then
            outDecoder <= (others => '0');
            outDecoder(to_integer(unsigned(inputDecoder))) <= '1';
        else
            outDecoder <= (others => '0');
        end if;
    end process;
END ARCHITECTURE behavioral;