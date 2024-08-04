library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity zero_filling is
    generic (n : natural := 1);
    port (
        imm_in  : in std_logic_vector(n - 1 downto 0);
        imm_out : out std_logic_vector(15 downto 0)
    );
end zero_filling;

architecture behavioral of zero_filling is
begin
    process (imm_in) 
    begin
        if n <= 16 then
            imm_out                 <= (others => '0');
            imm_out(15 downto 16-n) <= imm_in;
        else
            imm_out <= imm_in(n-1 downto n-16);
        end if;
    end process;
end behavioral;
