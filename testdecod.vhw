--------------------------------------------------------------------------------
-- Copyright (c) 1995-2007 Xilinx, Inc.
-- All Right Reserved.
--------------------------------------------------------------------------------
--   ____  ____ 
--  /   /\/   / 
-- /___/  \  /    Vendor: Xilinx 
-- \   \   \/     Version : 9.2i
--  \   \         Application : ISE
--  /   /         Filename : testdecod.vhw
-- /___/   /\     Timestamp : Sat Dec 17 16:26:53 2011
-- \   \  /  \ 
--  \___\/\___\ 
--
--Command: 
--Design Name: testdecod
--Device: Xilinx
--

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
USE IEEE.STD_LOGIC_TEXTIO.ALL;
USE STD.TEXTIO.ALL;

ENTITY testdecod IS
END testdecod;

ARCHITECTURE testbench_arch OF testdecod IS
    FILE RESULTS: TEXT OPEN WRITE_MODE IS "results.txt";

    COMPONENT instruction_decode
        PORT (
            clk : In std_logic;
            reset : In std_logic;
            EscrReg : In std_logic;
            Escr_reg : In std_logic_vector (4 DownTo 0);
            IDEXLeerMem : In std_logic;
            IDEX_RT : In std_logic_vector (4 DownTo 0);
            Escr_IFID : Out std_logic;
            Escr_PC : Out std_logic;
            instruccion : In std_logic_vector (31 DownTo 0);
            Escr_data : In std_logic_vector (31 DownTo 0);
            sumador_in : In std_logic_vector (31 DownTo 0);
            dato_1 : Out std_logic_vector (31 DownTo 0);
            dato_2 : Out std_logic_vector (31 DownTo 0);
            ext_sign : Out std_logic_vector (31 DownTo 0);
            sumador : Out std_logic_vector (31 DownTo 0);
            inst20_16 : Out std_logic_vector (4 DownTo 0);
            inst15_11 : Out std_logic_vector (4 DownTo 0);
            inst25_21 : Out std_logic_vector (4 DownTo 0);
            EX : Out std_logic_vector (3 DownTo 0);
            M : Out std_logic_vector (2 DownTo 0);
            WB : Out std_logic_vector (1 DownTo 0)
        );
    END COMPONENT;

    SIGNAL clk : std_logic := '0';
    SIGNAL reset : std_logic := '0';
    SIGNAL EscrReg : std_logic := '0';
    SIGNAL Escr_reg : std_logic_vector (4 DownTo 0) := "00000";
    SIGNAL IDEXLeerMem : std_logic := '0';
    SIGNAL IDEX_RT : std_logic_vector (4 DownTo 0) := "00000";
    SIGNAL Escr_IFID : std_logic := '0';
    SIGNAL Escr_PC : std_logic := '0';
    SIGNAL instruccion : std_logic_vector (31 DownTo 0) := "00000000000000000000000000000000";
    SIGNAL Escr_data : std_logic_vector (31 DownTo 0) := "00000000000000000000000000000000";
    SIGNAL sumador_in : std_logic_vector (31 DownTo 0) := "00000000000000000000000000000000";
    SIGNAL dato_1 : std_logic_vector (31 DownTo 0) := "00000000000000000000000000000000";
    SIGNAL dato_2 : std_logic_vector (31 DownTo 0) := "00000000000000000000000000000000";
    SIGNAL ext_sign : std_logic_vector (31 DownTo 0) := "00000000000000000000000000000000";
    SIGNAL sumador : std_logic_vector (31 DownTo 0) := "00000000000000000000000000000000";
    SIGNAL inst20_16 : std_logic_vector (4 DownTo 0) := "00000";
    SIGNAL inst15_11 : std_logic_vector (4 DownTo 0) := "00000";
    SIGNAL inst25_21 : std_logic_vector (4 DownTo 0) := "00000";
    SIGNAL EX : std_logic_vector (3 DownTo 0) := "0000";
    SIGNAL M : std_logic_vector (2 DownTo 0) := "000";
    SIGNAL WB : std_logic_vector (1 DownTo 0) := "00";

    constant PERIOD : time := 200 ns;
    constant DUTY_CYCLE : real := 0.5;
    constant OFFSET : time := 100 ns;

    BEGIN
        UUT : instruction_decode
        PORT MAP (
            clk => clk,
            reset => reset,
            EscrReg => EscrReg,
            Escr_reg => Escr_reg,
            IDEXLeerMem => IDEXLeerMem,
            IDEX_RT => IDEX_RT,
            Escr_IFID => Escr_IFID,
            Escr_PC => Escr_PC,
            instruccion => instruccion,
            Escr_data => Escr_data,
            sumador_in => sumador_in,
            dato_1 => dato_1,
            dato_2 => dato_2,
            ext_sign => ext_sign,
            sumador => sumador,
            inst20_16 => inst20_16,
            inst15_11 => inst15_11,
            inst25_21 => inst25_21,
            EX => EX,
            M => M,
            WB => WB
        );

        PROCESS    -- clock process for clk
        BEGIN
            WAIT for OFFSET;
            CLOCK_LOOP : LOOP
                clk <= '0';
                WAIT FOR (PERIOD - (PERIOD * DUTY_CYCLE));
                clk <= '1';
                WAIT FOR (PERIOD * DUTY_CYCLE);
            END LOOP CLOCK_LOOP;
        END PROCESS;

        PROCESS
            BEGIN
                -- -------------  Current Time:  100ns
                WAIT FOR 100 ns;
                reset <= '1';
                -- -------------------------------------
                -- -------------  Current Time:  185ns
                WAIT FOR 85 ns;
                reset <= '0';
                EscrReg <= '1';
                Escr_reg <= "00001";
                Escr_data <= "00000000000000000000000000000101";
                -- -------------------------------------
                -- -------------  Current Time:  385ns
                WAIT FOR 200 ns;
                EscrReg <= '0';
                -- -------------------------------------
                -- -------------  Current Time:  585ns
                WAIT FOR 200 ns;
                Escr_reg <= "00000";
                Escr_data <= "00000000000000000000000000000000";
                -- -------------------------------------
                -- -------------  Current Time:  785ns
                WAIT FOR 200 ns;
                instruccion <= "00000000010000010111000000100101";
                -- -------------------------------------
                WAIT FOR 2415 ns;

            END PROCESS;

    END testbench_arch;

