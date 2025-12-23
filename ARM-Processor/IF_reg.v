module IF_reg(
    clk, rst, freeze, flush,
    PC_in, Inst_in,
    PC_out, Inst_out
    );
    parameter WIDTH = 32;
    input clk, rst, freeze, flush;
    input [WIDTH-1:0] PC_in, Inst_in;
    output reg [WIDTH-1:0] PC_out, Inst_out;

    always @(posedge clk or negedge rst) begin
        if(~rst) begin
            PC_out <= 32'b0;
            Inst_out <= 32'b0;
        end
        else if(flush) begin
            PC_out <= 32'b0;
            Inst_out <= 32'b0;
        end
        else if(~freeze) begin
            PC_out <= PC_in;
            Inst_out <= Inst_in;
        end
    end
endmodule
