//alu module

//op codes
// 5'b00010; // ADD
// 5'b00011; // SUB
// 5'b00000; // AND
// 5'b00001; // OR
// 5'b00100; // SLL
// 5'b00101; // SLT
// 5'b00110; // SLTU
// 5'b00111; // XOR
// 5'b01000; // SRL
// 5'b01001; // SRA
// 5'b01010; // MUL
// 5'b01011; // MULH
// 5'b01100; // MULHSU
// 5'b01101; // MULHU
// 5'b01110; // DIV
// 5'b01111; // DIVU
// 5'b10000; // REM
// 5'b10001; // REMU
// 5'b11111; // Invalid case

//Not completed - Have to check with the guideline and need to create the test bench



module alu(

    input [31:0] INPUT_1,
    input [31:0] INPUT_2,
    input [4:0] ALU_CONTROL,
    output reg [31:0] ALU_RESULT,
    output reg ZERO_FLAG

);


    always @(*) begin
        case (ALU_CONTROL)
            5'b00010: ALU_RESULT = INPUT_1 + INPUT_2; // ADD
            5'b00011: ALU_RESULT = INPUT_1 - INPUT_2; // SUB
            5'b00000: ALU_RESULT = INPUT_1 & INPUT_2; // AND
            5'b00001: ALU_RESULT = INPUT_1 | INPUT_2; // OR
            5'b00100: ALU_RESULT = INPUT_1 << INPUT_2[4:0]; // SLL
            5'b00101: ALU_RESULT = (INPUT_1 < INPUT_2) ? 32'b1 : 32'b0; // SLT
            5'b00110: ALU_RESULT = (INPUT_1 < INPUT_2) ? 32'b1 : 32'b0; // SLTU
            5'b00111: ALU_RESULT = INPUT_1 ^ INPUT_2; // XOR
            5'b01000: ALU_RESULT = INPUT_1 >> INPUT_2[4:0]; // SRL
            5'b01001: ALU_RESULT = $signed(INPUT_1) >>> INPUT_2[4:0]; // SRA
            5'b01010: ALU_RESULT = INPUT_1 * INPUT_2; // MUL
            5'b01011: ALU_RESULT = $signed(INPUT_1) * $signed(INPUT_2); // MULH
            5'b01100: ALU_RESULT = $signed(INPUT_1) * $unsigned(INPUT_2); // MULHSU
            5'b01101: ALU_RESULT = $unsigned(INPUT_1) * $unsigned(INPUT_2); // MULHU
            5'b01110: ALU_RESULT = INPUT_1 / INPUT_2; // DIV
            5'b01111: ALU_RESULT = $unsigned(INPUT_1) / $unsigned(INPUT_2); // DIVU
            5'b10000: ALU_RESULT = INPUT_1 % INPUT_2; // REM
            5'b10001: ALU_RESULT = $unsigned(INPUT_1) % $unsigned(INPUT_2); // REMU
            5'b11111: ALU_RESULT = 32'h00000000; //
            default: ALU_RESULT = 32'h00000000; // Default case for invalid operation
        endcase

        ZERO_FLAG = (ALU_RESULT == 32'h00000000); // Set ZERO_FLAG if result is zero
    end

endmodule;