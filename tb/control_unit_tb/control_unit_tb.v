`include "../../rtl/control_unit/control_unit.v"

`timescale 1ns / 1ps
module control_unit_tb;
    // Inputs
    reg [6:0] OPCODE;
    reg [2:0] FUNC3;
    reg [6:0] FUNC7;

    // Outputs
    wire WRITE_ENABLE;
    wire MEM_WRITE;
    wire MEM_READ;
    wire BRANCH;
    wire JUMP;
    wire MUX_2_PC_SELECT;
    wire MUX_1_IMM_SELECT;
    wire MUX_3_JAL_SELECT;
    wire MUX_4_DATA_MEM_SELECT;

    // Instantiate the Unit Under Test (UUT)
    control_unit uut (
        .OPCODE(OPCODE), 
        .FUNC3(FUNC3), 
        .FUNC7(FUNC7), 
        .WRITE_ENABLE(WRITE_ENABLE), 
        .MEM_WRITE(MEM_WRITE), 
        .MEM_READ(MEM_READ), 
        .BRANCH(BRANCH), 
        .JUMP(JUMP), 
        .MUX_2_PC_SELECT(MUX_2_PC_SELECT), 
        .MUX_1_IMM_SELECT(MUX_1_IMM_SELECT),
        .MUX_3_JAL_SELECT(MUX_3_JAL_SELECT), 
        .MUX_4_DATA_MEM_SELECT(MUX_4_DATA_MEM_SELECT)
    );

    initial begin
        // Initialize Inputs
        OPCODE = 0;
        FUNC3 = 0;
        FUNC7 = 0;

        // Open VCD file for GTKWave
        $dumpfile("control_unit_tb.vcd");
        $dumpvars(0, control_unit_tb);

        // Wait 100 ns for global reset to finish
        #10;
        
        // Test R-type instructions
        OPCODE = 8'b0110011;
        FUNC3 = 3'b000; FUNC7 = 7'b0000000; #10; // ADD
        FUNC3 = 3'b000; FUNC7 = 7'b0100000; #10; // SUB
        FUNC3 = 3'b001; FUNC7 = 7'b0000000; #10; // SLL
        FUNC3 = 3'b010; FUNC7 = 7'b0000000; #10; // SLT
        FUNC3 = 3'b011; FUNC7 = 7'b0000000; #10; // SLTU
        FUNC3 = 3'b100; FUNC7 = 7'b0000000; #10; // XOR
        FUNC3 = 3'b101; FUNC7 = 7'b0000000; #10; // SRL
        FUNC3 = 3'b101; FUNC7 = 7'b0100000; #10; // SRA
        FUNC3 = 3'b110; FUNC7 = 7'b0000000; #10; // OR
        FUNC3 = 3'b111; FUNC7 = 7'b0000000; #10; // AND

        // Test I-type instructions
        OPCODE = 8'b0000011;
        FUNC3 = 3'b000; #10; // LB
        FUNC3 = 3'b001; #10; // LH
        FUNC3 = 3'b010; #10; // LW
        FUNC3 = 3'b100; #10; // LBU
        FUNC3 = 3'b101; #10; // LHU

        OPCODE = 8'b1100111;
        FUNC3 = 3'b000; #10; // JALR

        OPCODE = 8'b0010011;
        FUNC3 = 3'b000; #10; // ADDI
        FUNC3 = 3'b010; #10; // SLTI
        FUNC3 = 3'b011; #10; // SLTIU
        FUNC3 = 3'b100; #10; // XORI
        FUNC3 = 3'b110; #10; // ORI
        FUNC3 = 3'b111; #10; // ANDI
        FUNC3 = 3'b001; FUNC7 = 7'b0000000; #10; // SLLI
        FUNC3 = 3'b101; FUNC7 = 7'b0000000; #10; // SRLI
        FUNC3 = 3'b101; FUNC7 = 7'b0100000; #10; // SRAI

        // Test S-type instructions
        OPCODE = 8'b0100011;
        FUNC3 = 3'b000; #10; // SB
        FUNC3 = 3'b001; #10; // SH
        FUNC3 = 3'b010; #10; // SW

        // Test U-type instructions
        OPCODE = 8'b0110111; #10; // LUI
        OPCODE = 8'b0010111; #10; // AUIPC

        // Test B-type instructions
        OPCODE = 8'b1100011;
        FUNC3 = 3'b000; #10; // BEQ
        FUNC3 = 3'b001; #10; // BNE
        FUNC3 = 3'b100; #10; // BLT
        FUNC3 = 3'b101; #10; // BGE
        FUNC3 = 3'b110; #10; // BLTU
        FUNC3 = 3'b111; #10; // BGEU

        // Test J-type instruction
        OPCODE = 8'b1101111; #10; // JAL


        OPCODE = 8'b0010011;
        FUNC3 = 3'b000; #10; // NOP when rd -> x0 ; rs1 -> x0 ; imm -> 0
        $finish; // $stop; only pauses the simulation
    end
      
endmodule
