    module IDReg #(parameter n=32)(clk, rst, Flush, S, B, imm, MEM_R_EN, MEM_W_EN, WB_EN, EXE_CMD, SR, Dest
                              , Val_Rm, Val_Rn, PC, Signed_imm_24, Shift_operand, S_out, B_out, MEM_R_EN_out
                              , MEM_W_EN_out, WB_EN_out, imm_out, EXE_CMD_out, Dest_out, SR_out, Val_Rm_out
                              , Val_Rn_out, PC_out, Signed_imm_24_out, Shift_operand_out, src1_in, src2_in, src1_out, src2_out);
                              
    input clk, rst, Flush, S, B, imm, MEM_R_EN, MEM_W_EN, WB_EN;
    input [3:0] EXE_CMD, SR, Dest, src1_in, src2_in;
    input[n-1:0] Val_Rm, Val_Rn, PC;
    input[23:0] Signed_imm_24;
    input [11:0] Shift_operand; 
    
    output reg S_out, B_out, MEM_R_EN_out, MEM_W_EN_out, WB_EN_out, imm_out;
    output reg [3:0] EXE_CMD_out, Dest_out, SR_out, src1_out, src2_out; 
    output reg[n-1:0] Val_Rm_out, Val_Rn_out, PC_out; 
    output reg[23:0] Signed_imm_24_out;
    output reg [11:0] Shift_operand_out;

    always @(posedge clk,negedge rst) begin
            if(~rst) begin
                {S_out, B_out, MEM_R_EN_out, MEM_W_EN_out, WB_EN_out, imm_out}<=6'd0;
                {EXE_CMD_out, Dest_out, SR_out} <= {3*4'b0};
                {Val_Rm_out, Val_Rn_out, PC_out}<={3*32'b0};
                {Signed_imm_24_out}<={24'b0};
                {Shift_operand_out} <= {12'b0};
                {src1_out, src2_out} <= {2*4'b0};
            end
            else
                case (Flush)
                    1'b1: begin
                        {S_out, B_out, MEM_R_EN_out, MEM_W_EN_out, WB_EN_out, imm_out}<=6'd0;
                        {EXE_CMD_out, Dest_out, SR_out} <= {3*4'b0};
                        {Val_Rm_out, Val_Rn_out, PC_out}<={3*32'b0};
                        {Signed_imm_24_out}<={24'b0};
                        {Shift_operand_out} <= {12'b0};
                        {src1_out, src2_out} <= {2*4'b0};
                    end
                    1'b0: begin
                        {S_out, B_out, MEM_R_EN_out, MEM_W_EN_out, WB_EN_out, imm_out}<={S, B, MEM_R_EN, MEM_W_EN, WB_EN, imm};
                        {EXE_CMD_out, Dest_out, SR_out} <= {EXE_CMD, Dest, SR};
                        {Val_Rm_out, Val_Rn_out, PC_out}<={Val_Rm, Val_Rn, PC};
                        {Signed_imm_24_out}<={Signed_imm_24};
                        {Shift_operand_out} <= {Shift_operand};
                        {src1_out, src2_out} <= {src1_in, src2_in};
                    end
                endcase
        end

endmodule







































