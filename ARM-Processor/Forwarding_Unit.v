module Forwarding_Unit(src1, src2, MEM_WB_EN, Forwarding_EN, MEM_Dest, WB_Dest, WB_WB_EN, Sel_src1, Sel_src2);
    input MEM_WB_EN, WB_WB_EN, Forwarding_EN;
    input [3:0] src1, src2, WB_Dest, MEM_Dest;
    output reg [1:0] Sel_src1, Sel_src2;

    always @(*) begin
        if(Forwarding_EN == 1'b0)begin
            Sel_src1 = 2'b00;
            Sel_src2 = 2'b00;
        end
        else begin
            Sel_src1 = (src1 == MEM_Dest && MEM_WB_EN) ? 2'd1 : (src1 == WB_Dest && WB_WB_EN) ? 2'd2 : 2'd0;
            Sel_src2 = (src2 == MEM_Dest && MEM_WB_EN) ? 2'd1 : (src2 == WB_Dest && WB_WB_EN) ? 2'd2 : 2'd0;
        end
    end

endmodule