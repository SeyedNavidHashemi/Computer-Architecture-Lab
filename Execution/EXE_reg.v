module EXEReg #(parameter n=32)(clk, rst, WB_EN_in, MEM_R_EN_in, MEM_W_EN_in, ALU_Res_in, Val_Rm_in, Dest_in,
                                WB_EN_out, MEM_R_EN_out, MEM_W_EN_out, ALU_Res_out, Val_Rm_out, Dest_out);

    input clk, rst, WB_EN_in, MEM_R_EN_in, MEM_W_EN_in;
    input[3:0] Dest_in;
    input[n-1:0] ALU_Res_in, Val_Rm_in;

    output reg WB_EN_out, MEM_R_EN_out, MEM_W_EN_out;
    output reg[3:0] Dest_out;
    output reg[n-1:0] ALU_Res_out, Val_Rm_out;
   
    always @(posedge clk,negedge rst) begin
            if(~rst) begin
                {WB_EN_out, MEM_R_EN_out, MEM_W_EN_out}<=3'b0;
                Dest_out <= 4'b0;
                {ALU_Res_out, Val_Rm_out}<={2*32'b0};
            end
            else
                WB_EN_out <= WB_EN_in;
                MEM_R_EN_out <= MEM_R_EN_in;
                MEM_W_EN_out <= MEM_W_EN_in;
                Dest_out <= Dest_in;
                ALU_Res_out <= ALU_Res_in;
                Val_Rm_out <= Val_Rm_in;
        end

endmodule







































