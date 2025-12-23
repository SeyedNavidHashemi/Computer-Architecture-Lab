module RegisterFile (clk, rst, src1, src2, WB_Dest, WB_Value, WB_WB_EN, Val_RN, Val_RM);
    input clk, rst, WB_WB_EN;
    input [3:0] src1, src2, WB_Dest;
    input [31:0] WB_Value;
    output [31:0] Val_RN, Val_RM;

    reg [31:0] registers [0:14];

    integer i;

    always @(negedge clk, negedge rst) begin
        if (~rst) begin
            for (i = 0; i < 15; i = i + 1) begin
                registers[i] <= i;
//                registers[i] <= 0;
            end
        end
        else if (WB_WB_EN) begin
            registers[WB_Dest] <= WB_Value;
        end
    end
    
    assign Val_RN = registers[src1];
    assign Val_RM = registers[src2];
    
endmodule