module MEMReg #(parameter n=32)(clk, rst, MEM_R_EN_in, WB_EN_in, DEST_in, ALU_Res_in, Data_Memory_in,
                                MEM_R_EN_out, WB_EN_out, DEST_out, ALU_Res_out, Data_Memory_out);
    input clk, rst, MEM_R_EN_in, WB_EN_in;
    input[3:0] DEST_in;
    input [n-1:0] ALU_Res_in, Data_Memory_in;

    output reg MEM_R_EN_out, WB_EN_out;
    output reg[3:0] DEST_out;
    output reg [n-1:0] ALU_Res_out, Data_Memory_out;

    always @(posedge clk,negedge rst) begin
            if(~rst) begin
                {MEM_R_EN_out, WB_EN_out}<=2'b0;
                DEST_out <= 4'b0;
                {ALU_Res_out, Data_Memory_out}<={2*32'b0};
            end
            else
                MEM_R_EN_out <= MEM_R_EN_in;
                WB_EN_out <= WB_EN_in;
                DEST_out <= DEST_in;
                ALU_Res_out <= ALU_Res_in;
                Data_Memory_out <= Data_Memory_in;
        end
endmodule