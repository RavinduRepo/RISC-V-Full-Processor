

module control_unit(
    input  wire [6:0] OPCODE,
    input  wire [2:0] FUNC3,
    input  wire [6:0] FUNC7,
    output reg        WRITE_ENABLE,
    output reg        MEM_WRITE,
    output reg        MEM_READ,
    output reg        BRANCH,
    output reg        JUMP,
    output reg        MUX_2_PC_SELECT, // PC_SELECT, // MUX_2
    output reg        MUX_1_IMM_SELECT, // IMM_SELECT, // MUX_1
    output reg        MUX_3_JAL_SELECT, // JAL_SELECT, // MUX_3
    output reg        MUX_4_DATA_MEM_SELECT, // DATA_MEM_SELECT, // MUX_4
    output reg [2:0]  ALU_OP
);
    // always block * to run the block whenever any input changes
    always @(*)
    begin
        // Default values
        WRITE_ENABLE = 1'b0;
        MEM_WRITE = 1'b0;
        MEM_READ = 1'b0;
        BRANCH = 1'b0;
        JUMP = 1'b0;
        MUX_2_PC_SELECT = 1'b0;
        MUX_1_IMM_SELECT = 1'b1;
        MUX_3_JAL_SELECT = 1'b0;
        MUX_4_DATA_MEM_SELECT = 1'b0;
        ALU_OP = 3'b000;

        case (OPCODE)

        //////////////////////////////////////////////////// R-type //////////////////////////////////////////////////////////////////
        8'b0110011:
            begin
                WRITE_ENABLE = 1'b1;
            end

        //////////////////////////////////////////////////// I-type //////////////////////////////////////////////////////////////////
        8'b0000011:
            if (FUNC3 == 3'b000 || // LB
                FUNC3 == 3'b001 || // LH
                FUNC3 == 3'b010 || // LW
                FUNC3 == 3'b100 || // LBU
                FUNC3 == 3'b101)   // LHU
                begin
                    MUX_1_IMM_SELECT = 1'b1;
                    WRITE_ENABLE = 1'b1;
                    MEM_READ = 1'b1;
                    ALU_OP = 3'b001;
                    MUX_4_DATA_MEM_SELECT = 1'b1;
                end
        8'b1100111:
            case (FUNC3)
            3'b000: // JALR
            begin
                WRITE_ENABLE = 1'b1;
                MUX_3_JAL_SELECT = 1'b1;
                MUX_1_IMM_SELECT = 1'b1;
                JUMP = 1'b1;
                ALU_OP = 3'b010;
                // Set the LSB of the calculated address to 0 to ensure it is word-aligned.
            end
            endcase
        8'b0010011:
            if (FUNC3 == 3'b000 || // ADDI
                FUNC3 == 3'b010 || // SLTI
                FUNC3 == 3'b011 || // SLTIU
                FUNC3 == 3'b100 || // XORI
                FUNC3 == 3'b110 || // ORI
                FUNC3 == 3'b111)   // ANDI
            begin
                WRITE_ENABLE = 1'b1;
                MUX_1_IMM_SELECT = 1'b1;
                ALU_OP = 3'b011;
            end
            
            else if ((FUNC7 == 7'b0000000 && FUNC3 == 3'b001) || // SLLI
                (FUNC7 == 7'b0000000 && FUNC3 == 3'b101) || // SRLI
                (FUNC7 == 7'b0100000 && FUNC3 == 3'b101))   // SRAI
            begin
                WRITE_ENABLE = 1'b1;
                MUX_1_IMM_SELECT = 1'b1;
                ALU_OP = 3'b011;
            end

        //////////////////////////////////////////////////// S-type //////////////////////////////////////////////////////////////////
        8'b0100011:
            case (FUNC3)
            3'b000: // SB
            begin
                MEM_WRITE = 1'b1;
                MUX_1_IMM_SELECT = 1'b1;
                ALU_OP = 3'b100;
            end
            3'b001: // SH
            begin
                MEM_WRITE = 1'b1;
                MUX_1_IMM_SELECT = 1'b1;
                ALU_OP = 3'b100;
            end
            3'b010: // SW
            begin
                MEM_WRITE = 1'b1;
                MUX_1_IMM_SELECT = 1'b1;
                ALU_OP = 3'b100;
            end
            endcase

        //////////////////////////////////////////////////// U-type //////////////////////////////////////////////////////////////////
        8'b0110111: // LUI
            begin
            WRITE_ENABLE = 1'b1;
            MUX_1_IMM_SELECT = 1'b1;
            ALU_OP     = 3'b101;
            end
        8'b0010111: // AUIPC
            begin
            WRITE_ENABLE = 1'b1;
            MUX_1_IMM_SELECT = 1'b1;
            MUX_2_PC_SELECT = 1'b1;
            ALU_OP = 3'b100;
            end

        //////////////////////////////////////////////////// B-type //////////////////////////////////////////////////////////////////
        8'b1100011:
            if (FUNC3 == 3'b000 || // BEQ
                FUNC3 == 3'b001 || // BNE
                FUNC3 == 3'b100 || // BLT
                FUNC3 == 3'b101 || // BGE
                FUNC3 == 3'b110 || // BLTU
                FUNC3 == 3'b111)   // BGEU
            begin
                BRANCH = 1'b1;
                MUX_2_PC_SELECT = 1'b1;
                MUX_1_IMM_SELECT = 1'b1;
                ALU_OP = 3'b100;
            end


        //////////////////////////////////////////////////// J-type //////////////////////////////////////////////////////////////////
        8'b1101111: // JAL
            begin
            JUMP = 1'b1;
            MUX_3_JAL_SELECT = 1'b1;
            MUX_2_PC_SELECT = 1'b1;
            MUX_1_IMM_SELECT = 1'b1;
            WRITE_ENABLE = 1'b1;
            ALU_OP = 3'b100;
            end
        endcase

    end

endmodule

