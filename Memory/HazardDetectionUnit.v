module Hazard_Detection_Unit(src1, src2, Two_src, MEM_WB_EN, EXE_WB_EN, Mem_Dest, EXE_Dest, Hazard);
    input  MEM_WB_EN, EXE_WB_EN, Two_src;
    input[3:0] src1, src2, Mem_Dest, EXE_Dest;
    output reg Hazard;

    always@(*) begin 
        Hazard = 1'b0; 
        if((src1==EXE_Dest) && (src1==EXE_WB_EN)) || ((src2==EXE_Dest) && (src2==EXE_WB_EN) && Two_src) ||
           ((src1==Mem_Dest) && (src1==MEM_WB_EN)) || ((src2==Mem_Dest && (src2==MEM_WB_EN) && Two_src))
            Hazard = 1'b1;
        else
            Hazard = 1'b0;    
    end
endmodule
            








