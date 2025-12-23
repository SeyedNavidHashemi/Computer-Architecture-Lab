module Hazard_Detection_Unit(src1, src2, Two_src, MEM_WB_EN, EXE_WB_EN, Mem_Dest, EXE_Dest, Hazard, Forwarding_EN, EXE_MEM_R_EN);
    input  MEM_WB_EN, EXE_WB_EN, Two_src, Forwarding_EN, EXE_MEM_R_EN;
    input[3:0] src1, src2, Mem_Dest, EXE_Dest;
    output reg Hazard;

    always@(*) begin  
        if(Forwarding_EN) begin
            if(EXE_MEM_R_EN)
                if(((src1==EXE_Dest) && (EXE_WB_EN)) || ((src2==EXE_Dest) && (EXE_WB_EN) && (Two_src)) ||
                ((src1==Mem_Dest) && (MEM_WB_EN)) || ((src2==Mem_Dest) && (MEM_WB_EN) && (Two_src)))
                    Hazard = 1'b1;
                else
                    Hazard = 1'b0;
            else
                Hazard = 1'b0;

        end
        else begin
            if(((src1==EXE_Dest) && (EXE_WB_EN)) || ((src2==EXE_Dest) && (EXE_WB_EN) && (Two_src)) ||
            ((src1==Mem_Dest) && (MEM_WB_EN)) || ((src2==Mem_Dest) && (MEM_WB_EN) && (Two_src)))
                Hazard = 1'b1;
            else
                Hazard = 1'b0;
        end    
    end
endmodule
