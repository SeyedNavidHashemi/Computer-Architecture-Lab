module ID #(parameter n=32) (clk, rst, Hazard, WB_WB_en, Inst, PC, WB_Value, SR, WB_Dest,
                             PC_out, EXE_CMD, S_out, B_out, MEM_W_EN_out,
                            MEM_R_EN_out, WB_EN_out, imm_out, Shift_operand, Signed_imm_24, src2, Val_Rn_out, Val_Rm_out, Dest);

input clk, rst, Hazard, WB_WB_en;
input[3:0] SR, WB_Dest;
input[31:0] Inst, PC, WB_Value;

output S_out, B_out, MEM_W_EN_out, MEM_R_EN_out, WB_EN_out, imm_out;
output[3:0] EXE_CMD, Dest, src2;
output[11:0] Shift_operand;
output[23:0] Signed_imm_24;
output[31:0] PC_out, Val_Rn_out, Val_Rm_out;

wire s, mem_read, mem_write, wb_en, b_jump, update_s, cc_out, cu_mux_sel, imm;
wire[3:0] Opcode, Cond, exe_cmd, out_mux_RF, Rn, Rd, Rm;
wire[1:0] Mode;


assign Dest = Inst[15:12];
assign Signed_imm_24 = Inst[23:0];
assign imm_out = Inst[25];
assign Shift_operand = Inst[11:0];
assign s = Inst[20];
assign Opcode = Inst[24:21];
assign Mode = Inst[27:26];
assign Cond = Inst[31:28];
assign Rn = Inst[19:16];
//     assign src1 = instr[19:16];
assign src2 = out_mux_RF;
assign Rd = Inst[15:12];
assign Rm = Inst[3:0];
assign PC_out = PC;
assign imm_out = imm;
// assign two_src = (~imm) | mem_write;

mux_2_to_1 #(4) MUX_RF(.op1(Rm), .op2(Rd), .select(mem_write), .result(out_mux_RF));

RegisterFile RF(.clk(clk), .rst(rst), .src1(Rn), .src2(out_mux_RF), .WB_Dest(WB_Dest), .WB_Value(WB_Value), .WB_WB_EN(WB_WB_en), .Val_RN(Val_Rn_out), .Val_RM(Val_Rm_out));

ControlUnit CU(.Mode(Mode), .Opcode(Opcode), .S_in(s), .WB_EN(wb_en), .MEM_R_EN(mem_read), .MEM_W_EN(mem_write), .B(b_jump), .S_out(update_s), .EXE_CMD(exe_cmd));

ConditionCheck CC(.Cond(Cond), .SR(SR), .CC_out(cc_out));

assign cu_mux_sel = (~cc_out) | Hazard;
assign {EXE_CMD, S_out, B_out, MEM_W_EN_out, MEM_R_EN_out, WB_EN_out} = cu_mux_sel ? {9'b0} : {exe_cmd, update_s, b_jump, mem_write, mem_read, wb_en};

endmodule