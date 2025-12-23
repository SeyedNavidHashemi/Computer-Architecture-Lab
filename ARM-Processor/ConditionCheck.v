module ConditionCheck (Cond, SR, CC_out);
    input[3:0] Cond, SR;
    output reg CC_out;


    parameter EQ=4'b0000, NE=4'b0001, CSHS=4'b0010, CCLO=4'b0011, MI=4'b0100, PL=4'b0101, VS=4'b0110;
    parameter VC=4'b0111, HI=4'b1000, LS=4'b1001, GE=4'b1010, LT=4'b1011, GT=4'b1100, LE=4'b1101, AL=4'b1110;
    wire N,val_Z,C,V; 

    assign V=SR[0]; // Overflow Flag
    assign C=SR[1]; // Carry Flag
    assign val_Z=SR[2]; // Zero Flag
    assign N=SR[3]; // Negative Flag
    
    always @(*) begin
        case (Cond)
            EQ: CC_out<=val_Z;
            NE: CC_out<=~val_Z;
            CSHS: CC_out<=C;
            CCLO: CC_out<=~C;
            MI: CC_out<=N;
            PL: CC_out<=~N;
            VS: CC_out<=V;
            VC: CC_out<=~V;
            HI: CC_out<=C&(~val_Z);
            LS: CC_out<=(~C)&val_Z;
            GE: CC_out<=(N==V);
            LT: CC_out<=(N!=V);
            GT: CC_out<=(val_Z==0)&(N==V);
            LE: CC_out<=(val_Z==1)&(N!=V);
            AL: CC_out<=1'b1;
        endcase
    end
endmodule