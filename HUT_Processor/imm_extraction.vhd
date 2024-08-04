library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity immediate_extraction is
    port(
        instruction      : in  std_logic_vector(15 downto 0);
        immediate_y_type : out std_logic_vector(3 downto 0);
        immediate_z_type : out std_logic_vector(8 downto 0)
    );
end entity immediate_extraction;

architecture Behavioral of immediate_extraction is
begin
    process(instruction)
    begin
        immediate_y_type <= instruction(11 downto 8);
        immediate_z_type <= instruction(8 downto 0);
    end process;
end architecture Behavioral;
