`include "../../rtl/register_file/register_file.v"
// Testbench for the register file module
module register_file_tb();

    // Testbench signals
    reg CLK, RST, WRITE_ENABLE;
    reg [4:0] READ_REG_1, READ_REG_2, WRITE_REG;
    reg [31:0] WRITE_DATA;
    wire [31:0] READ_DATA_1, READ_DATA_2;
    
    // Instantiate register file
    register_file dut (
        .CLK(CLK),
        .RST(RST),
        .WRITE_ENABLE(WRITE_ENABLE),
        .READ_REG_1(READ_REG_1),
        .READ_REG_2(READ_REG_2),
        .WRITE_REG(WRITE_REG),
        .WRITE_DATA(WRITE_DATA),
        .READ_DATA_1(READ_DATA_1),
        .READ_DATA_2(READ_DATA_2)
    );

    // Clock generation
    initial begin
        CLK = 0;
        forever #5 CLK = ~CLK;
    end

    // Test stimulus
    integer i;
    initial begin
        // Initialize waveform dump
        $dumpfile("register_file_tb.vcd");
        $dumpvars(0, register_file_tb);
        for (i = 0; i < 32; i = i + 1) begin
            $dumpvars(1, dut.REGISTERS[i]);
        end
        
        // Initialize signals
        RST = 0;
        WRITE_ENABLE = 0;
        READ_REG_1 = 0;
        READ_REG_2 = 0;
        WRITE_REG = 0;
        WRITE_DATA = 0;

        // Test 1: Reset
        RST = 1;
        @(posedge CLK);
        RST = 0;
        
        // Test 2: Write to register 1 and read back
        @(posedge CLK);
        WRITE_ENABLE <= 1;
        WRITE_REG <= 5'd1;
        WRITE_DATA <= 32'hAAAA_AAAA;
        @(posedge CLK);
        WRITE_ENABLE <= 0;
        READ_REG_1 <= 5'd1;
        @(posedge CLK);
        if (READ_DATA_1 !== 32'hAAAA_AAAA)
            $display("Test 2 Failed: Expected 0xAAAAAAAA, Got %h", READ_DATA_1);

        // Test 3: Write to register 0 (should be ignored)
        @(posedge CLK);
        WRITE_ENABLE <= 1;
        WRITE_REG <= 5'd0;
        WRITE_DATA <= 32'hFFFF_FFFF;
        @(posedge CLK);
        WRITE_ENABLE <= 0;
        READ_REG_1 <= 5'd0;
        @(posedge CLK);
        if (READ_DATA_1 !== 32'h0)
            $display("Test 3 Failed: Register 0 should always be 0");

        // Test 4: Simultaneous read and write to same register
        @(posedge CLK);
        WRITE_ENABLE <= 1;
        WRITE_REG <= 5'd2;
        WRITE_DATA <= 32'h5555_5555;
        READ_REG_1 <= 5'd2;
        READ_REG_2 <= 5'd1;
        @(posedge CLK);
        if (READ_DATA_2 !== 32'hAAAA_AAAA)
            $display("Test 4 Failed: Incorrect value read from register 1");

        // End simulation
        #20 $finish;
    end

endmodule
