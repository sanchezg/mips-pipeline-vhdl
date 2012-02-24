--------------------------------------------------------------------------------
-- Copyright (c) 1995-2007 Xilinx, Inc.
-- All Right Reserved.
--------------------------------------------------------------------------------
--   ____  ____ 
--  /   /\/   / 
-- /___/  \  /    Vendor: Xilinx 
-- \   \   \/     Version : 9.2i
--  \   \         Application : ISE
--  /   /         Filename : test2.vhw
-- /___/   /\     Timestamp : Fri Dec 16 12:07:51 2011
-- \   \  /  \ 
--  \___\/\___\ 
--
--Command: 
--Design Name: test2
--Device: Xilinx
--

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
USE IEEE.STD_LOGIC_TEXTIO.ALL;
USE STD.TEXTIO.ALL;

ENTITY test2 IS
END test2;

ARCHITECTURE testbench_arch OF test2 IS
    FILE RESULTS: TEXT OPEN WRITE_MODE IS "results.txt";

    COMPONENT mips
        PORT (
            clock : In std_logic;
            reset : In std_logic;
            control_id_ex_gral : Out std_logic_vector (8 DownTo 0);
            salida : Out std_logic_vector (31 DownTo 0);
            instruccion_gral : Out std_logic_vector (31 DownTo 0);
            direccion_gral : Out std_logic_vector (31 DownTo 0);
            alu_salto_gral : Out std_logic_vector (31 DownTo 0)
        );
    END COMPONENT;

    SIGNAL clock : std_logic := '0';
    SIGNAL reset : std_logic := '0';
    SIGNAL control_id_ex_gral : std_logic_vector (8 DownTo 0) := "000000000";
    SIGNAL salida : std_logic_vector (31 DownTo 0) := "00000000000000000000000000000000";
    SIGNAL instruccion_gral : std_logic_vector (31 DownTo 0) := "00000000000000000000000000000000";
    SIGNAL direccion_gral : std_logic_vector (31 DownTo 0) := "00000000000000000000000000000000";
    SIGNAL alu_salto_gral : std_logic_vector (31 DownTo 0) := "00000000000000000000000000000000";

    constant PERIOD : time := 200 ns;
    constant DUTY_CYCLE : real := 0.5;
    constant OFFSET : time := 100 ns;

    BEGIN
        UUT : mips
        PORT MAP (
            clock => clock,
            reset => reset,
            control_id_ex_gral => control_id_ex_gral,
            salida => salida,
            instruccion_gral => instruccion_gral,
            direccion_gral => direccion_gral,
            alu_salto_gral => alu_salto_gral
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
                WAIT FOR 3015 ns;

            END PROCESS;

    END testbench_arch;

