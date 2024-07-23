LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY register_file IS
    PORT (
        clk, rst, we : IN STD_LOGIC;
        read         : IN STD_LOGIC;
        adr          : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        wd           : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
        outPut       : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
    );
END ENTITY register_file;

ARCHITECTURE structural OF register_file IS
    COMPONENT reg_file_element IS
        GENERIC (size : INTEGER := 16);
        PORT (
            clk, rst, we : IN STD_LOGIC;
            d_in         : IN STD_LOGIC_VECTOR(size-1 DOWNTO 0);
            d_out        : OUT STD_LOGIC_VECTOR(size-1 DOWNTO 0)
        );
    END COMPONENT;

    COMPONENT decoder4to16 IS
        PORT (
            inputDecoder : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
            enable       : IN STD_LOGIC;
            outDecoder   : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
        );
    END COMPONENT;

    COMPONENT mux16in1 IS
        GENERIC (size : INTEGER := 16);
        PORT (
            input : IN STD_LOGIC_VECTOR(16*size-1 DOWNTO 0); 
            sel   : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
            outPut: OUT STD_LOGIC_VECTOR(size-1 DOWNTO 0)
        );
    END COMPONENT;

    TYPE register_array IS ARRAY (0 TO 15) OF STD_LOGIC_VECTOR(15 DOWNTO 0);
    SIGNAL registers  : register_array;
    SIGNAL we_signals : STD_LOGIC_VECTOR(15 DOWNTO 0);
    SIGNAL mux_input  : STD_LOGIC_VECTOR(16*16-1 DOWNTO 0);

BEGIN 
    gen_registers : FOR i IN 0 TO 15 GENERATE
        reg_file_i : reg_file_element
        PORT MAP(
            clk   => clk,
            rst   => rst,
            we    => we_signals(i),
            d_in  => wd,
            d_out => registers(i)
        ); --register generator
    END GENERATE; -- registers

    dec : decoder4to16
        PORT MAP(
            inputDecoder => adr,
            enable       => we,
            outDecoder   => we_signals
        ); -- decoders

    PROCESS(clk, registers)
    BEGIN 
        FOR i IN 0 TO 15 LOOP
            mux_input((i + 1) * 16 - 1 DOWNTO i * 16) <= registers(i);
        END LOOP;
    END PROCESS; -- registers array for mux 16/1

    mux_inst : mux16in1
        GENERIC MAP (size => 16)
        PORT MAP(
            input => mux_input,
            sel   => adr,
            outPut => outPut
        ); --mux output based on address

END ARCHITECTURE; -- register file
