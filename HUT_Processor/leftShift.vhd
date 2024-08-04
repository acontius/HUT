library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity left_shift_1bit is
    port(
        shift_in  : in std_logic_vector(15 downto 0);
        shift_out : out std_logic_vector(15 downto 0)
    );
end entity left_shift_1bit;

architecture behavioral of left_shift_1bit is
begin
    process(shift_in)
    begin
        shift_out <= std_logic_vector(shift_left(unsigned(shift_in), 1));
    end process;
end architecture behavioral;
