library IEEE;
use IEEE.numeric_std.all;
use IEEE.std_logic_1164.all;

entity controller is 
    port(
        alu_opr                    : out std_logic_vector(2 downto 0);
        pc_sel, pc_we, reg_we, 
        mem_we, wr_sel             : out std_logic;
        opcode                     : in std_logic_vector(2 downto 0);
        wd_sel, aluSel_a, aluSel_b : out std_logic_vector(1 downto 0);
        rst                        : in std_logic
    );
end controller;

architecture behavioral of controller is 
begin
    process(opcode, rst)
    begin
        if rst = '1' then
            pc_we    <= '0';
            reg_we   <= '0';
            mem_we   <= '0';
            wr_sel   <= '0';
            wd_sel   <= "00";
            aluSel_a <= "00";
            aluSel_b <= "00";
            alu_opr  <= "000";
        else
            case opcode is
                when "000" => -- ra = 2's complement(rb) 
                    pc_sel   <= '0';
                    pc_we    <= '1';
                    reg_we   <= '1';
                    mem_we   <= '0';
                    wr_sel   <= '1';
                    wd_sel   <= "10";
                    aluSel_a <= "01";
                    aluSel_b <= "00";
                    alu_opr  <= "000";

                when "001" => -- rb(imm) = '1'
                    pc_sel   <= '0';
                    pc_we    <= '1';
                    reg_we   <= '1';
                    mem_we   <= '0';
                    wr_sel   <= '1';
                    wd_sel   <= "10";
                    aluSel_a <= "10";
                    aluSel_b <= "11";
                    alu_opr  <= "011";
                    
                when "010" => -- ra = (rb OR ZF(imm))
                    pc_sel   <= '0';
                    pc_we    <= '1';
                    reg_we   <= '1';
                    mem_we   <= '0';
                    wr_sel   <= '1';
                    wd_sel   <= "10";
                    aluSel_a <= "10";
                    aluSel_b <= "11";
                    alu_opr  <= "011";
                
                when "011" => -- pc = 2*(pc+ra+SE(imm))
                    pc_sel   <= '1';
                    pc_we    <= '1';
                    reg_we   <= '0';
                    mem_we   <= '0';
                    wr_sel   <= '1';
                    wd_sel   <= "00";
                    aluSel_a <= "10";
                    aluSel_b <= "10";
                    alu_opr  <= "000";

                when "100" => -- ra = imm * 128
                    pc_sel   <= '0';
                    pc_we    <= '1';
                    reg_we   <= '1';
                    mem_we   <= '0';
                    wr_sel   <= '0';
                    wd_sel   <= "01";
                    aluSel_a <= "00";
                    aluSel_b <= "11";
                    alu_opr  <= "000";

                when "101" => -- ra = mem[2*ZF(imm)]
                    pc_sel   <= '0';
                    pc_we    <= '1';
                    reg_we   <= '1';
                    mem_we   <= '0';
                    wr_sel   <= '0';
                    wd_sel   <= "00";
                    aluSel_a <= "00";
                    aluSel_b <= "11";
                    alu_opr  <= "000";

                when "110" => -- mem[2*ZF(imm)] = ra
                    pc_sel   <= '0';
                    pc_we    <= '1';
                    reg_we   <= '0';
                    mem_we   <= '1';
                    wr_sel   <= '0';
                    wd_sel   <= "00";
                    aluSel_a <= "00";
                    aluSel_b <= "11";
                    alu_opr  <= "000";

                when others => 
                    pc_sel   <= '0';
                    pc_we    <= '0';
                    reg_we   <= '0';
                    mem_we   <= '0';            
                    wr_sel   <= '0';
                    wd_sel   <= "00";
                    aluSel_a <= "00";
                    aluSel_b <= "00";
                    alu_opr  <= "000";
                    
            end case;
        end if;
    end process;
end behavioral;
