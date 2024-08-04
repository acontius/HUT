library IEEE;
use IEEE.numeric_std.all;
use IEEE.std_logic_1164.all;


entity data_path is 
    port(
        clk : in std_logic;
        rst : in std_logic
    );
end data_path;

architecture behavioral of data_path is 
    
    signal temp               : std_logic;
    signal pc_sel             : std_logic;
    signal mem_we, reg_we     : std_logic;
    signal wr_sel             : std_logic;
    signal pc_we              : std_logic := '0';
    signal alu_opr            : std_logic_vector(2 downto 0);
    signal shift_amount       : std_logic_vector(2 downto 0);
    signal opCode             : std_logic_vector(2 downto 0);
    signal aluSel_a,aluSel_b  : std_logic_vector(1 downto 0);
    signal wd_sel             : std_logic_vector(1 downto 0);
    signal immY_type          : std_logic_vector(3 downto 0);
    signal immZ_type          : std_logic_vector(8 downto 0);
    signal wr_adr             : std_logic_vector(3 downto 0);
    signal SUM                : std_logic_vector(15 downto 0);
    signal ins_out            : std_logic_vector(15 downto 0); --instruction out put from ins_mem
    signal pc_in, pc_out      : std_logic_vector(15 downto 0);
    signal alu_out            : std_logic_vector(15 downto 0);
    signal reg_out            : std_logic_vector(15 downto 0);
    signal two_out, d_out     : std_logic_vector(15 downto 0);
    signal pc_increased       : std_logic_vector(15 downto 0);
    signal immY_shift         : std_logic_vector(15 downto 0);
    signal immSE_z            : std_logic_vector(15 downto 0);
    signal shift_in           : std_logic_vector(15 downto 0);
    signal immZF_z, immZF_y   : std_logic_vector(15 downto 0);
    signal immZF_shift_z      : std_logic_vector(15 downto 0);
    signal wd_data            : std_logic_vector(15 downto 0);
    signal aluA_in, aluB_in   : std_logic_vector(15 downto 0);
    signal shift_out          : std_logic_vector(15 downto 0);
    signal adder_jump_shifted : std_logic_vector(15 downto 0);
    signal adder_jump         : std_logic_vector(15 downto 0) := x"0000";
    
    component controller is
        port(
            alu_opr                    : out std_logic_vector(2 downto 0);
            pc_sel, pc_we, reg_we, 
            mem_we, wr_sel             : out std_logic;
            opcode                     : in std_logic_vector(2 downto 0);
            wd_sel, aluSel_a, aluSel_b : out std_logic_vector(1 downto 0);
            rst                        : in std_logic
        );
    end component;    

    component adder_16bit is
        port(
            A        : IN  STD_LOGIC_VECTOR(15 DOWNTO 0);
            B        : IN  STD_LOGIC_VECTOR(15 DOWNTO 0);
            SUM      : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
            CARRY_OUT: out std_logic
        );
    end component;
    

    component alu is
        port(
            in1, in2 : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
            alu_opr  : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
            outPut   : OUT STD_LOGIC_VECTOR(15 DOWNTO 0); --alu_out in the data path 
            zeroFlag : OUT STD_LOGIC
        );
    end component;
    

    component ram is
        generic (adr_size, data_size : integer := 16);
        port(
            clk, we : IN STD_LOGIC;
            adr     : IN STD_LOGIC_VECTOR(adr_size - 1 DOWNTO 0);
            d_in    : IN STD_LOGIC_VECTOR(data_size - 1 DOWNTO 0);
            d_out   : OUT STD_LOGIC_VECTOR(data_size - 1 DOWNTO 0)
        );
    end component;
    

    component decoder4to16 is
        port(
            inputDecoder : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
            enable       : IN STD_LOGIC;
            outDecoder   : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
        );
    end component;

    component immediate_extraction is
        port(
            instruction      : in  std_logic_vector(15 downto 0);
            immediate_y_type : out std_logic_vector(3 downto 0);
            immediate_z_type : out std_logic_vector(8 downto 0)
        );
    end component;

    component instruction_mem is
        port(
            ins_in         : in std_logic_vector(15 downto 0);
            ins_out        : out std_logic_vector(15 downto 0)
        );
    end component;

    component left_shift_imm is
        port(
            shift_amount  : in std_logic_vector(2 downto 0);
            shift_in      : in std_logic_vector(15 downto 0); 
            shift_out     : out std_logic_vector(15 downto 0) 
        );
    end component;

    component left_shift_1bit is
        port(
            shift_in  : in std_logic_vector(15 downto 0);
            shift_out : out std_logic_vector(15 downto 0)
        );
    end component;

    component mux2in1 is
        generic(size : integer := 1);
        port(
            in0,in1 : IN STD_LOGIC_VECTOR(size - 1 DOWNTO 0);
            sel     : IN STD_LOGIC;
            outPut  : OUT STD_LOGIC_VECTOR(size - 1 DOWNTO 0)
        );
    end component;

    component mux3in1 is
        generic(size : integer := 2);
        port(
            in1,in2,in3 : IN STD_LOGIC_VECTOR(size - 1 DOWNTO 0);
            sel         : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
            outPut      : OUT STD_LOGIC_VECTOR(size - 1 DOWNTO 0)
        );
    end component;

    component mux4in1 is
        generic(size : integer := 2);
        port(
            in0, in1, in2, in3 : IN STD_LOGIC_VECTOR(size - 1 DOWNTO 0);
            sel                : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
            outPut             : OUT STD_LOGIC_VECTOR(size - 1 DOWNTO 0)
        );
    end component;

    component mux16in1 is
        generic(size : integer := 16);
        port(
            input : IN STD_LOGIC_VECTOR(16*size-1 DOWNTO 0); 
            sel   : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
            outPut: OUT STD_LOGIC_VECTOR(size-1 DOWNTO 0)
        );
    end component;

    component program_counter is
        port(
            clk, rst, load : IN STD_LOGIC;
            pc_in          : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
            pc_out         : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
        );
    end component;

    component register_file is
        port(
            clk, rst, we : IN STD_LOGIC;
            read         : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
            adr          : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
            wd           : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
            outPut       : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
        );
    end component;

    component regi is
        GENERIC (size : INTEGER := 16);
        port(
            clk, rst, we : IN STD_LOGIC;
            d_in         : IN STD_LOGIC_VECTOR(size-1 DOWNTO 0);
            d_out        : OUT STD_LOGIC_VECTOR(size-1 DOWNTO 0)
        );
    end component;

    component sign_extend is
        port(
            imm_in : IN STD_LOGIC_VECTOR(8 DOWNTO 0);
            imm_out: OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
        );
    end component;

    component twos is
        port(
            tow_in : in std_logic_vector(15 downto 0);
            two_out: out std_logic_vector(15 downto 0)
        );
    end component;

    component zero_filling is
        generic(n : natural := 1);
        port(
            imm_in : IN STD_LOGIC_VECTOR(8 DOWNTO 0);
            imm_out: OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
        );
    end component;

    begin

        pc_increment : adder_16bit
        port map(
            A     => pc_out,
            B     => x"0002",
            SUM   => pc_increased
            -- CARRY_OUT => SUM                          
        );

        PCounter : program_counter
        port map(
            clk   => clk,
            rst   => rst,
            load  => pc_we,
            pc_in => pc_in,
            pc_out=> pc_out
        );

        ins_memory : instruction_mem
        port map(
            ins_in  => pc_out,
            ins_out => ins_out
        );

        opcode <= ins_out(15 downto 13);
        ins_control : controller 
        port map(
            rst     => rst,
            opcode  => opcode,
            pc_sel  => pc_sel,
            pc_we   => reg_we,
            mem_we  => mem_we,
            aluSel_a=> aluSel_a,
            aluSel_b=> aluSel_a,
            alu_opr => alu_opr,
            wd_sel  => wd_sel,
            wr_sel  => wr_sel 
        );

        mux_pc : mux2in1
        generic map(16) 
        port map(
            in0    => pc_increased,
            in1    => adder_jump_shifted,
            sel    => pc_sel,
            outPut => pc_in
        );

        immY_type <= ins_out(7 downto 4);
        immZ_type <= ins_out(12 downto 4);

        left_S_I : left_shift_imm
        port map(
            shift_amount => "001",
            shift_in     => shift_in,
            shift_out    => shift_out
        );

        signExtend : sign_extend 
        port map(
            imm_in  => immZ_type,
            imm_out => immSE_z
        );

        shifting_sevenBit : left_shift_imm
        port map(
            shift_amount => "111",
            shift_in     => immZF_z,
            shift_out    => immZF_shift_z
        );

        zf_ztype: zero_filling
        generic map (n => 9)
        port map (
            imm_in  => immZ_type,
            imm_out => immZF_z
        );

        zf_ytype: zero_filling
        generic map (n => 4) 
        port map (
            imm_in  => immY_type,
            imm_out => immZF_y
        );

        regis_file : register_file
        port map(
            clk    => clk,
            rst    => rst,
            we     => reg_we,
            read   => ins_out(3 downto 0),
            adr    => wr_adr,
            wd     => wd_data,
            outPut => reg_out            
        );

        twowsComp : twos
        port map(
            tow_in  => reg_out,
            two_out => two_out
        );

        aluA_mux : mux3in1
        port map(
            in1    => immY_shift,
            in2    => two_out,
            in3    => reg_out,
            sel    => aluSel_a,
            outPut => aluA_in
        );

        aluB_mux : mux4in1 
        port map(
            in0    => x"0001",
            in1    => reg_out,
            in2    => immSE_z,
            in3    => immZF_y,
            sel    => aluSel_b,
            outPut => aluB_in
        );

        alu_exe : alu 
        port map(
            in1      => aluA_in,
            in2      => aluB_in,
            alu_opr  => alu_opr,
            outPut   => alu_out
            -- zeroFlag => zeroFlag
        );

        adder_jump_ins : adder_16bit
        port map(
            A         => pc_out,
            B         => alu_out,
            SUM       => adder_jump
            -- CARRY_OUT => SUM
        );

        adder_shifted : left_shift_1bit
        port map(
            shift_in  => adder_jump,
            shift_out => adder_jump_shifted
        );

        memorry : ram
        port map(
            clk   => clk,
            we    => mem_we,
            adr   => immZF_shift_z,
            d_in  => reg_out,
            d_out => d_out
        );

        wr_mult : mux2in1
        port map(
            in0    => ins_out(3 downto 0),
            in1    => ins_out(12 downto 9),
            sel    => wr_sel,
            outPut => wr_adr
        );

        wd_mult : mux3in1 
        port map(
            in1    => d_out,
            in2    => immZF_shift_z,
            in3    => alu_out,
            sel    => wd_sel,
            outPut => wd_data
        );
end behavioral ;        