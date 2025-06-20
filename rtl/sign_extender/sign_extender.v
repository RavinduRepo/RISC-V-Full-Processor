module sign_extender(
    input [31:0] INSTRUCTION,
    output reg [31:0] IMMEDIATE
);

wire [6:0] OPCODE = INSTRUCTION[6:0];
// wire FUNC3 = INSTRUCTION[14:12];

always @(*) begin
    case (OPCODE)
        7'b0000011, // I-type (LB, LH, LW, LBU, LHU)
        7'b0010011, // I-type (ADDI, SLTI, SLTIU, XORI, ORI, ANDI)
        7'b1100111: // I-type (JALR)
            IMMEDIATE = {{20{INSTRUCTION[31]}}, INSTRUCTION[31:20]};

        7'b0100011: // S-type (Store)
            IMMEDIATE = {{20{INSTRUCTION[31]}}, INSTRUCTION[31:25], INSTRUCTION[11:7]};

        7'b0110111, // U-type (LUI)
        7'b0010111: // U-type (AUIPC)
            IMMEDIATE = {INSTRUCTION[31:12], 12'b0};

        7'b1100011: // B-type (Branch)
            IMMEDIATE = {{19{INSTRUCTION[31]}}, INSTRUCTION[31], INSTRUCTION[7], INSTRUCTION[30:25], INSTRUCTION[11:8], 1'b0};

        7'b1101111: // J-type (JAL)
            IMMEDIATE = {{11{INSTRUCTION[31]}}, INSTRUCTION[31], INSTRUCTION[19:12], INSTRUCTION[20], INSTRUCTION[30:21], 1'b0};

        default:
            IMMEDIATE = 32'b0;
    endcase
end

endmodule