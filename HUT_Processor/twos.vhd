library library IEEE;
use IEEE.numeric_std.all;
use IEEE.std_logic_1164.all;

entity twos is 
    port(
        tow_in : in std_logic_vector(15 downto 0);
        two_out: out std_logic_vector(15 downto 0)
    );
end twos;

architecture behavioral of tows is 
    begin
    process(tow_in)
        begin    
            two_out <= not tow_in;
    end process;
end behavioral;