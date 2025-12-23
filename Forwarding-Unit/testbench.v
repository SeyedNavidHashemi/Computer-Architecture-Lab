`timescale 1ps / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/20/2025 10:34:28 AM
// Design Name: 
// Module Name: testbench
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module TB_IF_Stage;

    // Parameters
    parameter WIDTH = 32;

    // Testbench signals
    reg clk;
    reg rst;
    reg freeze;
    reg Branch_taken;
    reg [WIDTH-1:0] BranchAddr;

    wire [WIDTH-1:0] PC;
    wire [WIDTH-1:0] Instruction;
    wire [WIDTH-1:0] PC_temp;

    // Instantiate the module under test (MUT)
    IF_Stage uut (
        .clk(clk),
        .rst(rst),
        .freeze(freeze),
        .Branch_taken(Branch_taken),
        .BranchAddr(BranchAddr),
        .PC(PC),
        .Instruction(Instruction),
        .PC_temp(PC_temp)
    );

    // Clock generation: 10ns period
    always #5 clk = ~clk;

    // Test stimulus
    initial begin
        // Initialize signals
        clk = 0;
        rst = 1;
        freeze = 0;
        Branch_taken = 0;
        BranchAddr = 0;

        // Apply reset
        #10;
        rst = 0;
        #10;
        rst = 1;
        #10;

        // Normal operation
        #50;

        // Let PC continue
        #50;

        // Continue normal operation
        #50;

        $finish;
    end

endmodule

