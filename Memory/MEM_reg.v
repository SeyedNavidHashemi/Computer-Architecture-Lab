module MEMReg #(parameter n=32)(clk, rst, MEM_R_EN_in, WB_EN_in, DEST_in, ALU_Res_in, Data_Memory_in,
                                MEM_R_EN_out, WB_EN_out, DEST_out, ALU_Res_out, Data_Memory_out);
    input clk, rst, MEM_R_EN_in, WB_EN_in;
    input[3:0] DEST_in;
    input [n-1:0] ALU_Res_in, Data_Memory_in;

    output reg MEM_R_EN_out, WB_EN_out;
    output reg[3:0] DEST_out;
    output [n-1:0] ALU_Res_out, Data_Memory_out;

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


























output reg mem_r_en_o, wb_en_o, output reg [3:0] dest_o, output reg [n-1:0] alu_res_o,data_mem_o);
	always @(posedge clk,posedge rst) begin
        if(rst) begin
            {mem_r_en_o, wb_en_o}=2'd0;
            {dest_o}={3'd0};
            {alu_res_o,data_mem_o}={2*32'd0};
        end
        else begin
            {mem_r_en_o, wb_en_o}={mem_r_en, wb_en};
            {dest_o}={dest};
            {alu_res_o,data_mem_o}={alu_res,data_mem};
        end
    end