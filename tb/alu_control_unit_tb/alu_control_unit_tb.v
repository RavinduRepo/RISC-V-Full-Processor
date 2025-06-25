`include "../../rtl/alu_control_unit/alu_control_unit.v"
`timescale 1ns / 1ps

module alu_control_unit_tb;
    // Inputs
    reg [6:0] FUNC7;
    reg [2:0] FUNC3;
    reg [2:0] ALU_OP;
    // Output
    wire [4:0] ALU_CONTROL;

    // Instantiate the Unit Under Test (UUT)
    alu_control_unit uut (
        .FUNC7(FUNC7),
        .FUNC3(FUNC3),
        .ALU_OP(ALU_OP),
        .ALU_CONTROL(ALU_CONTROL)
    );

    initial begin
        $display("Testing ALU Control Unit");
        // R-type ADD
        FUNC3 = 3'b000; FUNC7 = 7'b0000000; ALU_OP = 3'b000; #10;
        $display("ADD: ALU_CONTROL = %b", ALU_CONTROL);
        // R-type SUB
        FUNC3 = 3'b000; FUNC7 = 7'b0100000; ALU_OP = 3'b000; #10;
        $display("SUB: ALU_CONTROL = %b", ALU_CONTROL);
        // R-type AND
        FUNC3 = 3'b111; FUNC7 = 7'b0000000; ALU_OP = 3'b000; #10;
        $display("AND: ALU_CONTROL = %b", ALU_CONTROL);
        // R-type OR
        FUNC3 = 3'b110; FUNC7 = 7'b0000000; ALU_OP = 3'b000; #10;
        $display("OR: ALU_CONTROL = %b", ALU_CONTROL);
        // R-type SLL
        FUNC3 = 3'b001; FUNC7 = 7'b0000000; ALU_OP = 3'b000; #10;
        $display("SLL: ALU_CONTROL = %b", ALU_CONTROL);
        // R-type SLT
        FUNC3 = 3'b010; FUNC7 = 7'b0000000; ALU_OP = 3'b000; #10;
        $display("SLT: ALU_CONTROL = %b", ALU_CONTROL);
        // R-type SLTU
        FUNC3 = 3'b011; FUNC7 = 7'b0000000; ALU_OP = 3'b000; #10;
        $display("SLTU: ALU_CONTROL = %b", ALU_CONTROL);
        // R-type XOR
        FUNC3 = 3'b100; FUNC7 = 7'b0000000; ALU_OP = 3'b000; #10;
        $display("XOR: ALU_CONTROL = %b", ALU_CONTROL);
        // R-type SRL
        FUNC3 = 3'b101; FUNC7 = 7'b0000000; ALU_OP = 3'b000; #10;
        $display("SRL: ALU_CONTROL = %b", ALU_CONTROL);
        // R-type SRA
        FUNC3 = 3'b101; FUNC7 = 7'b0100000; ALU_OP = 3'b000; #10;
        $display("SRA: ALU_CONTROL = %b", ALU_CONTROL);
        // R-type MUL
        FUNC3 = 3'b000; FUNC7 = 7'b0000001; ALU_OP = 3'b000; #10;
        $display("MUL: ALU_CONTROL = %b", ALU_CONTROL);
        // R-type MULH
        FUNC3 = 3'b001; FUNC7 = 7'b0000001; ALU_OP = 3'b000; #10;
        $display("MULH: ALU_CONTROL = %b", ALU_CONTROL);
        // R-type MULHSU
        FUNC3 = 3'b010; FUNC7 = 7'b0000001; ALU_OP = 3'b000; #10;
        $display("MULHSU: ALU_CONTROL = %b", ALU_CONTROL);
        // R-type MULHU
        FUNC3 = 3'b011; FUNC7 = 7'b0000001; ALU_OP = 3'b000; #10;
        $display("MULHU: ALU_CONTROL = %b", ALU_CONTROL);
        // R-type DIV
        FUNC3 = 3'b100; FUNC7 = 7'b0000001; ALU_OP = 3'b000; #10;
        $display("DIV: ALU_CONTROL = %b", ALU_CONTROL);
        // R-type DIVU
        FUNC3 = 3'b101; FUNC7 = 7'b0000001; ALU_OP = 3'b000; #10;
        $display("DIVU: ALU_CONTROL = %b", ALU_CONTROL);
        // R-type REM
        FUNC3 = 3'b110; FUNC7 = 7'b0000001; ALU_OP = 3'b000; #10;
        $display("REM: ALU_CONTROL = %b", ALU_CONTROL);
        // R-type REMU
        FUNC3 = 3'b111; FUNC7 = 7'b0000001; ALU_OP = 3'b000; #10;
        $display("REMU: ALU_CONTROL = %b", ALU_CONTROL);
        // I-type ADDI
        FUNC3 = 3'b000; FUNC7 = 7'b0000000; ALU_OP = 3'b011; #10;
        $display("ADDI: ALU_CONTROL = %b", ALU_CONTROL);
        // I-type SLTI
        FUNC3 = 3'b010; FUNC7 = 7'b0000000; ALU_OP = 3'b011; #10;
        $display("SLTI: ALU_CONTROL = %b", ALU_CONTROL);
        // I-type SLTIU
        FUNC3 = 3'b011; FUNC7 = 7'b0000000; ALU_OP = 3'b011; #10;
        $display("SLTIU: ALU_CONTROL = %b", ALU_CONTROL);
        // I-type XORI
        FUNC3 = 3'b100; FUNC7 = 7'b0000000; ALU_OP = 3'b011; #10;
        $display("XORI: ALU_CONTROL = %b", ALU_CONTROL);
        // I-type ORI
        FUNC3 = 3'b110; FUNC7 = 7'b0000000; ALU_OP = 3'b011; #10;
        $display("ORI: ALU_CONTROL = %b", ALU_CONTROL);
        // I-type ANDI
        FUNC3 = 3'b111; FUNC7 = 7'b0000000; ALU_OP = 3'b011; #10;
        $display("ANDI: ALU_CONTROL = %b", ALU_CONTROL);
        // SLLI
        FUNC3 = 3'b001; FUNC7 = 7'b0000000; ALU_OP = 3'b011; #10;
        $display("SLLI: ALU_CONTROL = %b", ALU_CONTROL);
        // SRLI
        FUNC3 = 3'b101; FUNC7 = 7'b0000000; ALU_OP = 3'b011; #10;
        $display("SRLI: ALU_CONTROL = %b", ALU_CONTROL);
        // SRAI
        FUNC3 = 3'b101; FUNC7 = 7'b0100000; ALU_OP = 3'b011; #10;
        $display("SRAI: ALU_CONTROL = %b", ALU_CONTROL);
        // LUI
        FUNC3 = 3'b000; FUNC7 = 7'b0000000; ALU_OP = 3'b101; #10;
        $display("LUI: ALU_CONTROL = %b", ALU_CONTROL);
        // AUIPC
        FUNC3 = 3'b000; FUNC7 = 7'b0000000; ALU_OP = 3'b110; #10;
        $display("AUIPC: ALU_CONTROL = %b", ALU_CONTROL);
        // End simulation
        $finish;
    end
endmodule
