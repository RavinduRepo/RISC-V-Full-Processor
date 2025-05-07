module register_file (
    input wire CLK,                    // Clock signal
    input wire RST,                    // Reset signal
    input wire WRITE_ENABLE,           // Write enable signal
    input wire [4:0] READ_REG_1,        // Read register 1 address
    input wire [4:0] READ_REG_2,        // Read register 2 address
    input wire [4:0] WRITE_REG,        // Write register address
    input wire [31:0] WRITE_DATA,      // Data to write
    output wire [31:0] READ_DATA_1,     // Data from read register 1
    output wire [31:0] READ_DATA_2      // Data from read register 2
);

    // Register array with initialization
    reg [31:0] REGISTERS [31:0];
    integer i;     // Declare loop variable outside the procedural block for Verilog compatibility

    initial begin
        for (i = 0; i < 32; i = i + 1)
            REGISTERS[i] = 32'b0;
    end

    // Read logic
    assign READ_DATA_1 = (READ_REG_1 != 0) ? REGISTERS[READ_REG_1] : 32'b0; // R0 is always 0
    assign READ_DATA_2 = (READ_REG_2 != 0) ? REGISTERS[READ_REG_2] : 32'b0;

    // Synchronous reset and write logic
    always @(posedge CLK) begin
        if (RST) begin
            for (i = 0; i < 32; i = i + 1)
                REGISTERS[i] <= 32'b0;
        end
        else if (WRITE_ENABLE && WRITE_REG != 0)
            REGISTERS[WRITE_REG] <= WRITE_DATA;
    end

endmodule
