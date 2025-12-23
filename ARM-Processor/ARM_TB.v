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

module ARM_TB;

    // Parameters
    parameter WIDTH = 32;

    // Testbench signals
    reg clk;
    reg rst;
    reg forwarding;

    // Instantiate the modue under test (MUT)
    ARM uut (
        .clk(clk),
        .rst(rst)
        .Frwrd_EN(forwarding)
    );

    // Clock generation: 10ns period
    always #5 clk = ~clk;

    // Test stimulus
    initial begin
        // Initialize signals
        clk = 0;
        forwarding = 0;
        rst = 1;


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
        
        
        #2000;
        rst = 1;
        forwarding = 1;
        


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
        #2000;
        $finish;
    end

endmodule

