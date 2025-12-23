module IF_Stage(clk, rst, freeze, Branch_taken, BranchAddr, PC, Instruction, PC_temp);
    parameter WIDTH = 32;
    input clk, rst, freeze, Branch_taken;
    input [WIDTH-1:0] BranchAddr;
    output [WIDTH-1:0] PC, PC_temp, Instruction;

    wire [WIDTH-1:0] mux_out, pc_out, adder_out, inst_out;

    mux_2_to_1 #(
        .WIDTH(32)
    ) mux (
        .op1(adder_out),
        .op2(BranchAddr),
        .select(Branch_taken),
        .result(mux_out)
    );

    PC_reg#(
        .WIDTH(32)
    ) pc (
        .clk(clk),
        .rst(rst),
        .freeze(freeze), 
        .ld_data(1'b1), 
        .input_data(mux_out), 
        .output_data(pc_out)
    );
    
    adder#(
        .WIDTH(32)
    ) adder (
        .first(32'd1), 
        .second(pc_out), 
        .result(adder_out)
    );
    assign PC = adder_out;
    dist_mem_gen_0 your_instance_name (
  .a(pc_out[10:0]),      // input wire [10 : 0] a
  .spo(Instruction)  // output wire [31 : 0] spo
);

    assign PC_temp = pc_out;
endmodule