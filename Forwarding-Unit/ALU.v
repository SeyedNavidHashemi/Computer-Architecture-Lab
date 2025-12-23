module ALU(Cin, Val1, Val2, EXE_CMD, ALU_Res, Status_bits);
    input Cin;
    input [3:0] EXE_CMD;
    input [31:0] Val1, Val2;
    output [3:0] Status_bits;
    output reg [31:0] ALU_Res;

    reg [32:0] temp_res;
    reg C;
    reg V;
    wire Z; 
    wire N; 

    wire [31:0] Cin_ext = {{31{1'b0}}, Cin};
    wire [31:0] not_Cin_ext = {{31{1'b0}}, ~Cin};

    assign Status_bits = {N, Z, C, V};
    wire [3:0] new_SR;
    assign new_SR = {Z, C, N, V};

    always @(*) begin
        {C, V} = 2'b0;
        case(EXE_CMD)
            4'b0001 : begin // MOV 
                ALU_Res = Val2;
                C = 0; 
                V = 0;
            end

            4'b1001 : begin // MVN 
                ALU_Res = ~Val2;
                C = 0; 
                V = 0;
            end

            4'b0010 : begin // ADD
                temp_res = {1'b0, Val1} + {1'b0, Val2};
                ALU_Res = temp_res[31:0];
                C = temp_res[32]; 
                V = (Val1[31] == Val2[31]) && (ALU_Res[31] != Val1[31]); 
            end

            4'b0011 : begin // ADC
                temp_res = {1'b0, Val1} + {1'b0, Val2} + Cin_ext;
                ALU_Res = temp_res[31:0];
                C = temp_res[32]; 
                V = (Val1[31] == Val2[31]) && (ALU_Res[31] != Val1[31]); 
            end

            4'b0100 : begin // SUB
                temp_res = {Val1[31], Val1} - {Val2[31], Val2};
                ALU_Res = temp_res[31:0];
                C = temp_res[32];
                V = (Val1[31] != Val2[31]) && (ALU_Res[31] != Val1[31]); 
            end

            4'b0101 : begin // SBC 
                temp_res = {Val1[31], Val1} - {Val2[31], Val2} - not_Cin_ext;
                ALU_Res = temp_res[31:0];
                C = temp_res[32];
                V = (Val1[31] != Val2[31]) && (ALU_Res[31] != Val1[31]); 
            end

            4'b0110 : begin // AND
                ALU_Res = Val1 & Val2;
                C = 0; 
                V = 0;
            end

            4'b0111 : begin // ORR
                ALU_Res = Val1 | Val2;
                C = 0; 
                V = 0;
            end

            4'b1000 : begin // EOR 
                ALU_Res = Val1 ^ Val2;
                C = 0; 
                V = 0;
            end

            4'b0100 : begin // CMP
                temp_res = {1'b0, Val1} - {1'b0, Val2};
                ALU_Res = temp_res[31:0];
                C = ~temp_res[32];
                V = (Val1[31] == Val2[31]) && (ALU_Res[31] != Val1[31]); 
            end
            
            4'b0110 : begin // TST
                ALU_Res = Val1 & Val2;
                C = 0; 
                V = 0;
            end
            
            default : begin
                ALU_Res = 32'd0;
                C = 0; 
                V = 0;
            end
        endcase
    end

    assign Z = (ALU_Res == 32'd0) ? 1'b1 : 1'b0;
    assign N = ALU_Res[31];

endmodule































