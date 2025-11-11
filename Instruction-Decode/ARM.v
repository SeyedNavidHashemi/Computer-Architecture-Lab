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

    wire[3:0] EXE_CMD_ID, src2_ID, Dest_out;
    wire[11:0] Shift_operand_ID;
    wire[23:0] Signed_imm_24_ID;
    wire[31:0] PC_ID, Val_Rn_ID, Val_Rm_ID;
    wire S_out_ID, B_out_ID, MEM_W_EN_out_ID, MEM_R_EN_out_ID, WB_EN_out_ID, imm_out_ID;
    
    wire[3:0] EXE_CMD_out_IDR, Dest_out_IDR, SR_in, SR_out;// src2_out_IDR;
    wire[11:0] Shift_operand_out_IDR;
    wire[23:0] Signed_imm_24_out_IDR;
    wire[31:0] PC_out_IDR, Val_Rn_out_IDR, Val_Rm_out_IDR;
    
    ID #(
        .n(32)
    ) ID_stage (
        .clk(clk),
        .rst(rst),
        .Hazard(1'b0),
        .WB_WB_en(1'b0),
        .Inst(IF_Inst_out),
        .PC(IF_PC_out),
        .WB_Value(32'b0),
        .SR(4'b0),
        .WB_Dest(4'b0),
        .PC_out(PC_ID),
        .EXE_CMD(EXE_CMD_ID),
        .S_out(S_out_ID),
        .B_out(B_out_ID),
        .MEM_W_EN_out(MEM_W_EN_out_ID),
        .MEM_R_EN_out(MEM_R_EN_out_ID),
        .WB_EN_out(WB_EN_out_ID),
        .imm_out(imm_out_ID), 
        .Shift_operand(Shift_operand_ID), 
        .Signed_imm_24(Signed_imm_24_ID), 
        .src2(src2_ID),
        .Val_Rn_out(Val_Rn_ID),
        .Val_Rm_out(Val_Rm_ID), 
        .Dest(Dest_out)
    );

    IDReg #(
        .n(32)
    ) ID_reg (
        .clk(clk),
        .rst(rst),
        .Flush(1'b0),
        .S(S_out_ID),
        .B(B_out_ID),
        .imm(imm_out_ID),
        .MEM_R_EN(MEM_R_EN_out_ID),
        .MEM_W_EN(MEM_W_EN_out_ID),
        .WB_EN(WB_EN_out_ID),
        .EXE_CMD(EXE_CMD_ID),
        .SR(SR_in),
        .Dest(Dest_out),
        .Val_Rm(Val_Rm_ID),
        .Val_Rn(Val_Rn_ID),
        .PC(IF_PC_out),
        .Signed_imm_24(Signed_imm_24_ID),
        .Shift_operand(Shift_operand_ID),
        .S_out(S_out_IDR),
        .B_out(B_out_IDR),
        .MEM_R_EN_out(MEM_R_EN_out_IDR),
        .MEM_W_EN_out(MEM_W_EN_out_IDR),
        .WB_EN_out(WB_EN_out_IDR),
        .imm_out(imm_out_IDR),
        .EXE_CMD_out(EXE_CMD_out_IDR),
        .Dest_out(Dest_out_IDR),
        .SR_out(SR_out),
        .Val_Rm_out(Val_Rm_out_IDR),
        .Val_Rn_out(Val_Rn_out_IDR),
        .PC_out(PC_out_IDR),
        .Signed_imm_24_out(Signed_imm_24_out_IDR),
        .Shift_operand_out(Shift_operand_out_IDR)
    );


    Simple_reg #(
        .WIDTH(32)
    ) Exe_reg (
        .clk(clk), 
        .rst(rst),  
        .ld_data(1'b1),
        .input_data(PC_out_IDR), 
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