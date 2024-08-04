library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity instruction_mem is 
    port(
        ins_in   : in std_logic_vector(15 downto 0);
        ins_out  : out std_logic_vector(15 downto 0)
    );
end entity instruction_mem;

architecture behavioral of instruction_mem is
begin
    ins_out <= ins_in;
end architecture behavioral;
