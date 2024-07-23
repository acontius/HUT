library library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity instruction_mem is 
    port(
        clk, rst, load : in std_logic;
        ins_in         : in std_logic_vector(15 downto 0);
        ins_out        : out std_logic_vector(15 downto 0);
    );
end entity instruction_mem;

architecture behavioral of instruction_mem is
    signal ins_register
    begin 
        process(clk,rst)
        begin
            if rst = '1' then 
                ins_out <= (OTHERS => '0')
            elsif clk'event and clk = '1' then 
                if load = '1' then
                    ins_register <= ins_in;
                end if;
            end if;
        end process;
    ins_out <= ins_register;
end architecture; --instraction memory