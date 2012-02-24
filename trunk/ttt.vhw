--------------------------------------------------------------------------------
-- Copyright (c) 1995-2007 Xilinx, Inc.
-- All Right Reserved.
--------------------------------------------------------------------------------
--   ____  ____ 
--  /   /\/   / 
-- /___/  \  /    Vendor: Xilinx 
-- \   \   \/     Version : 9.2i
--  \   \         Application : ISE
--  /   /         Filename : ttt.vhw
-- /___/   /\     Timestamp : Sat Dec 17 19:05:12 2011
-- \   \  /  \ 
--  \___\/\___\ 
--
--Command: 
--Design Name: ttt
--Device: Xilinx
--

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
USE IEEE.STD_LOGIC_TEXTIO.ALL;
USE STD.TEXTIO.ALL;

ENTITY ttt IS
END ttt;

ARCHITECTURE testbench_arch OF ttt IS
    COMPONENT mips
        PORT (
            clock : In std_logic;
            reset : In std_logic;
            salida : Out std_logic_vector (31 DownTo 0);
            instruccion_gral : Out std_logic_vector (31 DownTo 0);
            direccion_gral : Out std_logic_vector (31 DownTo 0);
            alu_salto_gral : Out std_logic_vector (31 DownTo 0);
            regDest : Out std_logic_vector (4 DownTo 0);
            EscrData : Out std_logic_vector (31 DownTo 0);
            EscrReg : Out std_logic;
            EscrReg2 : Out std_logic;
            W : Out std_logic_vector (1 DownTo 0);
            M : Out std_logic_vector (2 DownTo 0);
            Ex : Out std_logic_vector (3 DownTo 0)
        );
    END COMPONENT;

    SIGNAL clock : std_logic := '0';
    SIGNAL reset : std_logic := '0';
    SIGNAL salida : std_logic_vector (31 DownTo 0) := "00000000000000000000000000000000";
    SIGNAL instruccion_gral : std_logic_vector (31 DownTo 0) := "00000000000000000000000000000000";
    SIGNAL direccion_gral : std_logic_vector (31 DownTo 0) := "00000000000000000000000000000000";
    SIGNAL alu_salto_gral : std_logic_vector (31 DownTo 0) := "00000000000000000000000000000000";
    SIGNAL regDest : std_logic_vector (4 DownTo 0) := "00000";
    SIGNAL EscrData : std_logic_vector (31 DownTo 0) := "00000000000000000000000000000000";
    SIGNAL EscrReg : std_logic := '0';
    SIGNAL EscrReg2 : std_logic := '0';
    SIGNAL W : std_logic_vector (1 DownTo 0) := "00";
    SIGNAL M : std_logic_vector (2 DownTo 0) := "000";
    SIGNAL Ex : std_logic_vector (3 DownTo 0) := "0000";

    constant PERIOD : time := 200 ns;
    constant DUTY_CYCLE : real := 0.5;
    constant OFFSET : time := 100 ns;

    BEGIN
        UUT : mips
        PORT MAP (
            clock => clock,
            reset => reset,
            salida => salida,
            instruccion_gral => instruccion_gral,
            direccion_gral => direccion_gral,
            alu_salto_gral => alu_salto_gral,
            regDest => regDest,
            EscrData => EscrData,
            EscrReg => EscrReg,
            EscrReg2 => EscrReg2,
            W => W,
            M => M,
            Ex => Ex
        );

        PROCESS    -- clock process for clock
        BEGIN
            WAIT for OFFSET;
            CLOCK_LOOP : LOOP
                clock <= '0';
                WAIT FOR (PERIOD - (PERIOD * DUTY_CYCLE));
                clock <= '1';
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
                -- -------------------------------------
                WAIT FOR 4015 ns;

            END PROCESS;

    END testbench_arch;

