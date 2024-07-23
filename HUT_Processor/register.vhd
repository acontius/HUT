LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY regi IS
    GENERIC (size : INTEGER := 16);
    PORT (
        clk, rst, we : IN STD_LOGIC;
        d_in         : IN STD_LOGIC_VECTOR(size-1 DOWNTO 0);
        d_out        : OUT STD_LOGIC_VECTOR(size-1 DOWNTO 0)
    );
END ENTITY regi;

ARCHITECTURE behavioral OF regi IS
    SIGNAL reg : STD_LOGIC_VECTOR(size-1 DOWNTO 0);
BEGIN
    process(clk, rst)
    begin
        if rst = '1' then
            reg <= (others => '0');
        elsif rising_edge(clk) then
            if we = '1' then
                reg <= d_in;
            end if;
        end if;
    end process;

    d_out <= reg;
END ARCHITECTURE behavioral;
