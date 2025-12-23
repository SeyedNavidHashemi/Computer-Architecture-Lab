module ARM(clk, rst);
    parameter WIDTH = 32;
    input clk, rst;

    wire [WIDTH-1:0] IF_pc, IF_inst, IF_PC_out, IF_Inst_out, ID_out, Exe_out, Mem_out, branch_address_EXE;

    wire B_out_IDR, Hazard;

    wire MEM_R_EN_out_MEMR, WB_EN_out_MEMR;
    wire[3:0] DEST_out_MEMR;
    wire[31:0] ALU_Res_out_MEMR, Data_Memory_out_MEMR, WB_Value;


    IF_Stage #(
        .WIDTH(32)
    ) IF (
        .clk(clk), 
        .rst(rst), 
        .freeze(Hazard), 
        .Branch_taken(B_out_IDR), 
        .BranchAddr(branch_address_EXE), 
        .PC(IF_pc), 
        .Instruction(IF_inst)
    );

    IF_reg #(
        .WIDTH(32)
    ) IF_reg (
        .clk(clk), 
        .rst(rst), 
        .freeze(Hazard), 
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
    wire S_out_ID, B_out_ID, MEM_W_EN_out_ID, MEM_R_EN_out_ID, WB_EN_out_ID;
    
    wire MEM_R_EN_out_IDR, MEM_W_EN_out_IDR, WB_EN_out_IDR, imm_out_ID, Two_src;
    wire[3:0] EXE_CMD_out_IDR, Dest_out_IDR, SR_out;// src2_out_IDR;
    wire[11:0] Shift_operand_out_IDR;
    wire[23:0] Signed_imm_24_out_IDR;
    wire[31:0] PC_out_IDR, Val_Rn_out_IDR, Val_Rm_out_IDR;
    
    ID #(
        .n(32)
    ) ID_stage (
        .clk(clk),
        .rst(rst),
        .Hazard(Hazard),
        .WB_WB_en(WB_EN_out_MEMR),
        .Inst(IF_Inst_out),
        .PC(IF_PC_out),
        .WB_Value(WB_Value),
        .SR(Status_Reg_out),
        .WB_Dest(DEST_out_MEMR),
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
        .Two_src(Two_src)
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
        .SR(Status_Reg_out),
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

    wire WB_EN_out_EXE, MEM_R_EN_out_EXE, MEM_W_EN_out_EXE;
    wire[3:0] Dest_out_EXE, Status_bits_EXE;
    wire[31:0] ALU_res_EXE, Val_Rm_out_EXE;

    EXE_Stage #(
        .n(32)
    ) EXE_stage (
        .clk(clk),
        .rst(rst),
        .c(SR_out[1]),
        .PC(PC_out_IDR),
        .WB_EN_in(WB_EN_out_IDR),
        .MEM_R_EN_in(MEM_R_EN_out_IDR),
        .MEM_W_EN_in(MEM_W_EN_out_IDR),
        .EXE_CMD(EXE_CMD_out_IDR),
        .Val1(Val_Rn_out_IDR),
        .Val_Rm_in(Val_Rm_out_IDR),
        .shift_operand(Shift_operand_out_IDR),
        .imm(imm_out_IDR),
        .signed_imm_24(Signed_imm_24_out_IDR),
        .Dest_in(Dest_out_IDR),
        .WB_EN_out(WB_EN_out_EXE),
        .MEM_R_EN_out(MEM_R_EN_out_EXE),
        .MEM_W_EN_out(MEM_W_EN_out_EXE),
        .ALU_res(ALU_res_EXE),
        .Val_Rm_out(Val_Rm_out_EXE),
        .Dest_out(Dest_out_EXE),
        .Status_bits(Status_bits_EXE),
        .branch_address(branch_address_EXE)
        );


    wire WB_EN_out_EXER, MEM_R_EN_out_EXER, MEM_W_EN_out_EXER;
    wire[3:0] Dest_out_EXER;
    wire[31:0] ALU_Res_out_EXER, Val_Rm_out_EXER;

    EXEReg #(
        .n(32)
    ) EXE_reg (
        .clk(clk),
        .rst(rst),
        .WB_EN_in(WB_EN_out_EXE),
        .MEM_R_EN_in(MEM_R_EN_out_EXE), 
        .MEM_W_EN_in(MEM_W_EN_out_EXE), 
        .ALU_Res_in(ALU_res_EXE), 
        .Val_Rm_in(Val_Rm_out_EXE), 
        .Dest_in(Dest_out_EXE),
        .WB_EN_out(WB_EN_out_EXER), 
        .MEM_R_EN_out(MEM_R_EN_out_EXER), 
        .MEM_W_EN_out(MEM_W_EN_out_EXER), 
        .ALU_Res_out(ALU_Res_out_EXER), 
        .Val_Rm_out(Val_Rm_out_EXER), 
        .Dest_out(Dest_out_EXER)
        );

    MEMReg #(
        .n(32)
    ) MEM_reg (
        .clk(clk),
        .rst(rst), 
        .MEM_R_EN_in(MEM_R_EN_out_EXER), 
        .WB_EN_in(WB_EN_out_EXER), 
        .DEST_in(Dest_out_EXER), 
        .ALU_Res_in(ALU_Res_out_EXER), 
        .Data_Memory_in(32'b11111111111111111111111111111111),
        .MEM_R_EN_out(MEM_R_EN_out_MEMR), 
        .WB_EN_out(WB_EN_out_MEMR), 
        .DEST_out(DEST_out_MEMR), 
        .ALU_Res_out(ALU_Res_out_MEMR),
        .Data_Memory_out(Data_Memory_out_MEMR)
        );

    mux_2_to_1 WB_stage(
        .op1(ALU_Res_out_MEMR), 
        .op2(Data_Memory_out_MEMR), 
        .select(MEM_R_EN_out_MEMR), 
        .result(WB_Value));

    StatusReg Status_Register (
        .clk(clk), 
        .rst(rst), 
        .Status_bits(Status_bits_EXE), 
        .S(S_out_IDR), 
        .SR(Status_Reg_out)
        );
    wire[3:0] Status_Reg_out;

    Hazard_Detection_Unit hazard_detection_unit(
        .src1(IF_Inst_out[19:16]), 
        .src2(src2_ID), 
        .Two_src(Two_src),
        .MEM_WB_EN(WB_EN_out_EXER), 
        .EXE_WB_EN(WB_EN_out_EXE),
        .Mem_Dest(Dest_out_EXER), 
        .EXE_Dest(Dest_out_EXE), 
        .Hazard(Hazard)
        );
endmodule