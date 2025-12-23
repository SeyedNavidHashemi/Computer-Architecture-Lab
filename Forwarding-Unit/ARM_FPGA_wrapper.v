`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/27/2025 09:15:33 AM
// Design Name: 
// Module Name: ARM_FPGA_wrapper
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


module ARM_FPGA_wrapper(
    input clk,
    input key1
);

// Declare wires for communication between modules
wire deb_out, rst;

// Instantiate a debouncer module
// It cleans the physical key input signal (key1)
debouncer deb_rst (
    .SIGNAL_I(key1),
    .CLK_I(clk),
    .SIGNAL_O(deb_out)
);

// Assign the active-low reset signal from the debouncer output
assign rst = deb_out;

// Instantiate the ARM processor core
// The core receives the clock and the reset signal
ARM ARM_inst (
    .clk(clk),
    .rst(rst)
);

// Instantiate the Integrated Logic Analyzer (ILA) for debugging
// This ILA captures internal signals from the ARM core
ila_0 ila_inst (
    .clk(clk), // input wire clk

    .probe0(rst), // input wire [0:0] probe0
    .probe1(ARM_inst.IF_pc), // input wire [31:0] probe1
    .probe2(ARM_inst.IF_PC_out), // input wire [31:0] probe2
    .probe3(ARM_inst.ID_out), // input wire [31:0] probe3
    .probe4(ARM_inst.Exe_out), // input wire [31:0] probe4
    .probe5(ARM_inst.Mem_out), // input wire [31:0] probe5
    .probe6(ARM_inst.IF_Inst_out) // input wire [31:0] probe6
);

endmodule
