module Val2Generate(Val_Rm, Shift_operand, imm, ld_str, result);
    input imm, ld_str;
    input [11:0] Shift_operand;
    input [31:0] Val_Rm;
    output reg [31:0] result;

    wire[3:0] rotate_imm = Shift_operand[11:8];
    wire[7:0] immed_8 = Shift_operand[7:0];
    wire[4:0] shift_imm = Shift_operand[11:7];
    wire[1:0] shift = Shift_operand[6:5];

    integer i;
    always @(Val_Rm, Shift_operand, imm, ld_str) begin
        result = 32'b0;
        //mode 3
        if (ld_str) begin  
            result = {20*{Shift_operand[11]}, Shift_operand};
        end

        //mode 1
        else if (imm) begin 
            result = {24'b0, immed_8};
            for (i = 0; i < 2 * rotate_imm; i = i + 1) begin
                result = {result[0], result[31:1]};
            end
        end

        //mode 2
        else begin 
            case (shift)
                    // LSL
                    2'b00: result = Val_Rm << shift_imm;    
                    // LSR           
                    2'b01: result = Val_Rm >> shift_imm; 
                    // ASR              
                    2'b10: result = $signed(Val_Rm) >>> shift_imm;  
                    // ROR   
                    2'b11: begin                                    
                        result = Val_Rm;
                        for (i = 0; i < shift_imm; i = i + 1) begin
                            result = {result[0], result[31:1]};
                        end
                    end
            endcase
        end    
    end
endmodule