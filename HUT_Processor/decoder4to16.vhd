LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.numeric_std.all;
USE WORK.utilities.all;

entity decoder4to16 is
    port (
        en    : in STD_LOGIC;
        input : in STD_LOGIC_VECTOR(3 DOWNTO 0);
        outPut: out STD_LOGIC_VECTOR(16 DOWNTO 0)
    );
end entity decoder4to16;

ARCHITECTURE behavioral of decoder4to16 is 
    constant zero : STD_LOGIC_VECTOR(16 DOWNTO 0) := (OTHERS => '0');
    constant one  : UNSIGNED(16 DOWNTO 0) := (0 => '1', OTHERS => '0');
    BEGIN
        outPut <= zero WHEN (en = '0') ELSE STD_LOGIC_VECTOR (SHIFT_LEFT(one,to_integer(input)));
END ARCHITECTURE;