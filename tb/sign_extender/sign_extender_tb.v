`include "../../rtl/sign_extender/sign_extender.v"
// Testbench for the sign_extender module
module sign_extender_tb();

    // Testbench signals
    reg [31:0] INSTRUCTION;
    wire [31:0] IMMEDIATE;
    
    // Instantiate sign_extender
    sign_extender sign_extender (
        .INSTRUCTION(INSTRUCTION),
        .IMMEDIATE(IMMEDIATE)
    );

    initial begin
        // Initialize waveform dump
        $dumpfile("sign_extender_tb.vcd");
        $dumpvars(0, sign_extender_tb);
        
        // Test 1: I-type (LB, LH, LW, LBU, LHU) - opcode 0000011
        INSTRUCTION = 32'b100000000000_00000_000_00001_0000011; // imm=0x800, opcode=0000011
        #10;
        if (IMMEDIATE !== 32'hFFFFF800)
            $display("Test 1 Failed: I-type (load) - Expected 0xFFFFF800, Got %h", IMMEDIATE);
        else
            $display("Test 1 Passed: I-type (load)");

        // Test 2: I-type (ADDI, SLTI, SLTIU, XORI, ORI, ANDI) - opcode 0010011
        INSTRUCTION = 32'b000000000001_00000_000_00001_0010011; // imm=0x1, opcode=0010011
        #10;
        if (IMMEDIATE !== 32'h00000001)
            $display("Test 2 Failed: I-type (addi) - Expected 0x00000001, Got %h", IMMEDIATE);
        else
            $display("Test 2 Passed: I-type (addi)");

        // Test 3: I-type (JALR) - opcode 1100111
        INSTRUCTION = 32'b111111111111_00000_000_00001_1100111; // imm=0xFFF, opcode=1100111
        #10;
        if (IMMEDIATE !== 32'hFFFFFFFF)
            $display("Test 3 Failed: I-type (jalr) - Expected 0xFFFFFFFF, Got %h", IMMEDIATE);
        else
            $display("Test 3 Passed: I-type (jalr)");

        // Test 4: S-type (Store) - opcode 0100011
        INSTRUCTION = 32'b1000000_00001_00000_010_00001_0100011; // imm[11:5]=1000000, rs2=00001, rs1=00000, funct3=010, imm[4:0]=00001, opcode=0100011
        #10;
        if (IMMEDIATE !== 32'hFFFFF801)
            $display("Test 4 Failed: S-type - Expected 0xFFFFF801, Got %h", IMMEDIATE);
        else
            $display("Test 4 Passed: S-type");

        // Test 5: U-type (LUI) - opcode 0110111
        INSTRUCTION = 32'b10000000000000000000_00001_0110111; // imm[31:12]=10000000000000000000, rd=00001, opcode=0110111
        #10;
        if (IMMEDIATE !== 32'h80000000)
            $display("Test 5 Failed: U-type (LUI) - Expected 0x80000000, Got %h", IMMEDIATE);
        else
            $display("Test 5 Passed: U-type (LUI)");

        // Test 6: U-type (AUIPC) - opcode 0010111
        INSTRUCTION = 32'b00000000111100000000_00001_0010111; // imm[31:12]=00000000111100000000, rd=00001, opcode=0010111
        #10;
        if (IMMEDIATE !== 32'h00F00000)
            $display("Test 6 Failed: U-type (AUIPC) - Expected 0x00F00000, Got %h", IMMEDIATE);
        else
            $display("Test 6 Passed: U-type (AUIPC)");

        // Test 7: B-type (Branch) - opcode 1100011
        // imm[12] = [31], imm[11] = [7], imm[10:5] = [30:25], imm[4:1] = [11:8], imm[0] = 0
        INSTRUCTION = 32'b1_000000_00001_00000_000_0001_0_1100011; // [31]=1, [7]=0, [30:25]=000000, [11:8]=0001, opcode=1100011
                    //  11111111111111111111000000000010
        #10;
        if (IMMEDIATE !== 32'hFFFFF002)
            $display("Test 7 Failed: B-type - Expected 0xFFFFF002, Got %h", IMMEDIATE);
        else
            $display("Test 7 Passed: B-type");

        // Test 8: J-type (JAL) - opcode 1101111
        // imm[20] = [31], imm[19:12] = [19:12], imm[11] = [20], imm[10:1] = [30:21], imm[0] = 0
        INSTRUCTION = 32'b1_0000000000_0_10000001_00001_1101111; // [31]=1, [19:12]=00000000, [20]=0, [30:21]=10000001, opcode=1101111
                    // 11111111111110000001000000000000
        #10;
        if (IMMEDIATE !== 32'hFFF81000)
            $display("Test 8 Failed: J-type - Expected 0xFFF81000, Got %h", IMMEDIATE);
        else
            $display("Test 8 Passed: J-type");

        // Test 9: Default case (invalid opcode)
        INSTRUCTION = 32'b11111111111111111111_11111_1111110; // random invalid opcode
        #10;
        if (IMMEDIATE !== 32'b0)
            $display("Test 9 Failed: Default case - Expected 0x00000000, Got %h", IMMEDIATE);
        else
            $display("Test 9 Passed: Default case");

        // End simulation
        #20 $display("All tests completed!");
        $finish;
    end

endmodule
