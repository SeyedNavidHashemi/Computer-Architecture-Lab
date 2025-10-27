module ARM(clk, rst);
    parameter WIDTH = 32;
    input clk, rst;

    wire [WIDTH-1:0] IF_pc, IF_inst, IF_PC_out, IF_Inst_out, ID_out, Exe_out, Mem_out;

    IF_Stage #(
        .WIDTH(32)
    ) IF (
        .clk(clk), 
        .rst(rst), 
        .freeze(1'b0), 
        .Branch_taken(1'b0), 
        .BranchAddr(32'b0), 
        .PC(IF_pc), 
        .Instruction(IF_inst)
    );

    IF_reg #(
        .WIDTH(32)
    ) IF_reg (
        .clk(clk), 
        .rst(rst), 
        .freeze(1'b0), 
        .flush(1'b0),
        .PC_in(IF_pc), 
        .Inst_in(IF_inst),
        .PC_out(IF_PC_out), 
        .Inst_out(IF_Inst_out)
    );

    Simple_reg #(
        .WIDTH(32)
    ) ID_reg (
        .clk(clk), 
        .rst(rst),  
        .ld_data(1'b1),
        .input_data(IF_PC_out), 
        .output_data(ID_out)
    );

    Simple_reg #(
        .WIDTH(32)
    ) Exe_reg (
        .clk(clk), 
        .rst(rst),  
        .ld_data(1'b1),
        .input_data(ID_out), 
        .output_data(Exe_out)
    );

    Simple_reg #(
        .WIDTH(32)
    ) Mem_reg (
        .clk(clk), 
        .rst(rst),  
        .ld_data(1'b1),
        .input_data(Exe_out), 
        .output_data(Mem_out)
    );

endmodule