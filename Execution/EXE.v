module EXE_Stage #(parameter n=32) (clk, rst, c, PC, WB_EN_in, MEM_R_EN_in, MEM_W_EN_in, EXE_CMD,
                                    Val1, Val_Rm_in, shift_operand, imm, signed_imm_24, Dest_in,
                                    WB_EN_out, MEM_R_EN_out, MEM_W_EN_out, ALU_res, Val_Rm_out, Dest_out,
                                    Status_bits, branch_address);
    input clk, rst, c, WB_EN_in, MEM_R_EN_in, MEM_W_EN_in, imm;
    input[3:0] EXE_CMD, Dest_in;
    input[11:0] shift_operand;
    input[23:0] signed_imm_24;
    input[n-1:0] PC, Val1, Val_Rm_in;

    output WB_EN_out, MEM_R_EN_out, MEM_W_EN_out;
    output[3:0] Dest_out, Status_bits;
    output[n-1:0] ALU_res, Val_Rm_out, branch_address;

    //OR
    wire or_out;
    or_module OR(.first(MEM_R_EN_in), .second(MEM_W_EN_in), .result(or_out));

    //VAL2GEN
    wire[n-1:0] Val2;
    Val2Generate VAL2GEN(.Val_Rm(Val_Rm_in), .Shift_operand(shift_operand), .imm(imm), .ld_str(or_out), .result(Val2));

    //ALU
    ALU ALU(.Cin(c), .Val1(Val1), .Val2(Val2), .EXE_CMD(EXE_CMD), .ALU_Res(ALU_res), .Status_bits(Status_bits));

    //Adder
    adder Adder(.first(PC), .second({8'b{signed_imm_24[23]}, signed_imm_24}), .result(branch_address));

    //assigns
    assign WB_EN_out = WB_EN_in;
    assign MEM_R_EN_out = MEM_R_EN_in;
    assign MEM_W_EN_out = MEM_W_EN_in;
    assign Val_Rm_out = Val_Rm_in;
    assign Dest_out = Dest_in;

endmodule