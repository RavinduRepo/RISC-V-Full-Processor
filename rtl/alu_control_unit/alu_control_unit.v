module alu_control_unit(
    input [6:0] FUNC7,
    input [2:0] FUNC3,
    input [2:0] ALU_OP,
    output reg [4:0] ALU_CONTROL
);

    always @(*) begin
        case (ALU_OP)
            3'b000: // R-type instructions (opcode: 0110011)
                case ({FUNC3, FUNC7})
                    10'b000_0000000: ALU_CONTROL = 5'b00010; // ADD
                    10'b000_0100000: ALU_CONTROL = 5'b00011; // SUB
                    10'b111_0000000: ALU_CONTROL = 5'b00000; // AND
                    10'b110_0000000: ALU_CONTROL = 5'b00001; // OR
                    10'b001_0000000: ALU_CONTROL = 5'b00100; // SLL
                    10'b010_0000000: ALU_CONTROL = 5'b00101; // SLT
                    10'b011_0000000: ALU_CONTROL = 5'b00110; // SLTU
                    10'b100_0000000: ALU_CONTROL = 5'b00111; // XOR
                    10'b101_0000000: ALU_CONTROL = 5'b01000; // SRL
                    10'b101_0100000: ALU_CONTROL = 5'b01001; // SRA
                    10'b000_0000001: ALU_CONTROL = 5'b01010; // MUL
                    10'b001_0000001: ALU_CONTROL = 5'b01011; // MULH
                    10'b010_0000001: ALU_CONTROL = 5'b01100; // MULHSU
                    10'b011_0000001: ALU_CONTROL = 5'b01101; // MULHU
                    10'b100_0000001: ALU_CONTROL = 5'b01110; // DIV
                    10'b101_0000001: ALU_CONTROL = 5'b01111; // DIVU
                    10'b110_0000001: ALU_CONTROL = 5'b10000; // REM
                    10'b111_0000001: ALU_CONTROL = 5'b10001; // REMU
                    default: ALU_CONTROL = 5'b11111; // Invalid case
                endcase

            3'b001: // I-type instructions (opcode: 0000011)
                ALU_CONTROL = 5'b00010; // ADD for load instructions

            3'b010: // JALR instruction (opcode: 1100111)
                ALU_CONTROL = 5'b00010; // ADD for calculating the target address

            3'b011: // Immediate operation instructions
                case (FUNC3)
                    3'b000: ALU_CONTROL = 5'b00010; // ADDI
                    3'b010: ALU_CONTROL = 5'b00101; // SLTI
                    3'b011: ALU_CONTROL = 5'b00110; // SLTIU
                    3'b100: ALU_CONTROL = 5'b00111; // XORI
                    3'b110: ALU_CONTROL = 5'b00001; // ORI
                    3'b111: ALU_CONTROL = 5'b00000; // ANDI
                    3'b001: // SLLI
                        if (FUNC7 == 7'b0000000)
                            ALU_CONTROL = 5'b00100;
                        else
                            ALU_CONTROL = 5'b11111; // Invalid
                    3'b101: // SRLI/SRAI
                        if (FUNC7 == 7'b0000000)
                            ALU_CONTROL = 5'b01000; // SRLI
                        else if (FUNC7 == 7'b0100000)
                            ALU_CONTROL = 5'b01001; // SRAI
                        else
                            ALU_CONTROL = 5'b11111; // Invalid
                    default: ALU_CONTROL = 5'b11111; // Invalid case
                endcase
            
            3'b100: // S-type instructions (opcode => 0100011) and B-type and J-Type instructions (opcode => 1100011)
                ALU_CONTROL = 5'b00010; // ADD for calculating the target address

            3'b101: // for LUI instruction
                ALU_CONTROL = 5'b10010; // forward => for the LUI instruction

            3'b110: // for AUIPC instruction
                ALU_CONTROL = 5'b00010; // adding PC and ths IMMEDIATE => for the AUIPC instruction

            
            default: ALU_CONTROL = 5'b11111; // Invalid ALU_OP
        endcase
    end

endmodule
