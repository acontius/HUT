library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity left_shift_imm is
    port(
        shift_amount : in std_logic_vector(2 downto 0);  -- Number of positions to shift
        shift_in     : in std_logic_vector(15 downto 0); -- Input vector
        shift_out    : out std_logic_vector(15 downto 0) -- Output vector
    );
end entity left_shift_imm;

architecture behavioral of left_shift_imm is
begin
    process(shift_amount, shift_in)
    begin
        shift_out <= std_logic_vector(shift_left(unsigned(shift_in), to_integer(unsigned(shift_amount))));
    end process;
end architecture behavioral;
