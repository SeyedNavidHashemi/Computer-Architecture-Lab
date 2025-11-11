module ControlUnit (Mode, Opcode, S_in, WB_EN, MEM_R_EN, MEM_W_EN, B, S_out, EXE_CMD);
    input[1:0] Mode;
    input[3:0] Opcode;
    input S_in; 
    output reg[3:0] EXE_CMD;
    output reg WB_EN, MEM_R_EN, MEM_W_EN, B, S_out;

    parameter MOV=4'b1101,MVN=4'b1111,ADD=4'b0100,ADC=4'b0101,SUB=4'b0010,SBC=4'b0110,AND=4'b0000,
              ORR=4'b1100,EOR=4'b0001,CMP=4'b1010,TST=4'b1000,LDR=4'b0100,STR=4'b0100;

	always @(*) begin
        {EXE_CMD,WB_EN, MEM_R_EN, MEM_W_EN, B, S_out}=9'b0;
        case (Mode)
            2'b00: begin
                case (Opcode) 
                    MOV: {EXE_CMD, S_out, WB_EN, MEM_R_EN, MEM_W_EN, B}<={4'b0001,S_in,1'b1,1'b0,1'b0,1'b0};
                    MVN: {EXE_CMD, S_out, WB_EN, MEM_R_EN, MEM_W_EN, B}<={4'b1001,S_in,1'b1,1'b0,1'b0,1'b0};
                    ADD: {EXE_CMD, S_out, WB_EN, MEM_R_EN, MEM_W_EN, B}<={4'b0010,S_in,1'b1,1'b0,1'b0,1'b0};
                    ADC: {EXE_CMD, S_out, WB_EN, MEM_R_EN, MEM_W_EN, B}<={4'b0011,S_in,1'b1,1'b0,1'b0,1'b0};
                    SUB: {EXE_CMD, S_out, WB_EN, MEM_R_EN, MEM_W_EN, B}<={4'b0100,S_in,1'b1,1'b0,1'b0,1'b0};
                    SBC: {EXE_CMD, S_out, WB_EN, MEM_R_EN, MEM_W_EN, B}<={4'b0101,S_in,1'b1,1'b0,1'b0,1'b0};
                    AND: {EXE_CMD, S_out, WB_EN, MEM_R_EN, MEM_W_EN, B}<={4'b0110,S_in,1'b1,1'b0,1'b0,1'b0};
                    ORR: {EXE_CMD, S_out, WB_EN, MEM_R_EN, MEM_W_EN, B}<={4'b0111,S_in,1'b1,1'b0,1'b0,1'b0};
                    EOR: {EXE_CMD, S_out, WB_EN, MEM_R_EN, MEM_W_EN, B}<={4'b1000,S_in,1'b1,1'b0,1'b0,1'b0};
                    CMP: {EXE_CMD, S_out, WB_EN, MEM_R_EN, MEM_W_EN, B}<={4'b0100,1'b1,1'b0,1'b0,1'b0,1'b0};
                    TST: {EXE_CMD, S_out, WB_EN, MEM_R_EN, MEM_W_EN, B}<={4'b0110,1'b1,1'b0,1'b0,1'b0,1'b0};
                endcase
            end
            2'b01: begin 
                case (S_in)
                    1'b1: {EXE_CMD, S_out, WB_EN, MEM_R_EN, MEM_W_EN, B}<={4'b0010,1'b1,1'b1,1'b1,1'b0,1'b0};
                    1'b0: {EXE_CMD, S_out, WB_EN, MEM_R_EN, MEM_W_EN, B}<={4'b0010,1'b0,1'b0,1'b0,1'b1,1'b0};
                endcase
            end
            2'b10: begin
                {EXE_CMD, S_out, WB_EN, MEM_R_EN, MEM_W_EN, B}<={4'b0000,1'b0,1'b0,1'b0,1'b0,1'b1};
            end
        endcase
    end


endmodule



















// 	always @(*) begin
//         {exec_cmd,update_s,wb_en,mem_read,mem_write,b_jump}=9'b0;
//         case (mode)
//             2'b00: begin
//                 case (op_code)
//                     MOV: {exec_cmd,update_s,wb_en,mem_read,mem_write,b_jump}<={4'b0001,s,1'b1,1'b0,1'b0,1'b0};
//                     MVN: {exec_cmd,update_s,wb_en,mem_read,mem_write,b_jump}<={4'b1001,s,1'b1,1'b0,1'b0,1'b0};
//                     ADD: {exec_cmd,update_s,wb_en,mem_read,mem_write,b_jump}<={4'b0010,s,1'b1,1'b0,1'b0,1'b0};
//                     ADC: {exec_cmd,update_s,wb_en,mem_read,mem_write,b_jump}<={4'b0011,s,1'b1,1'b0,1'b0,1'b0};
//                     SUB: {exec_cmd,update_s,wb_en,mem_read,mem_write,b_jump}<={4'b0100,s,1'b1,1'b0,1'b0,1'b0};
//                     SBC: {exec_cmd,update_s,wb_en,mem_read,mem_write,b_jump}<={4'b0101,s,1'b1,1'b0,1'b0,1'b0};
//                     AND: {exec_cmd,update_s,wb_en,mem_read,mem_write,b_jump}<={4'b0110,s,1'b1,1'b0,1'b0,1'b0};
//                     ORR: {exec_cmd,update_s,wb_en,mem_read,mem_write,b_jump}<={4'b0111,s,1'b1,1'b0,1'b0,1'b0};
//                     EOR: {exec_cmd,update_s,wb_en,mem_read,mem_write,b_jump}<={4'b1000,s,1'b1,1'b0,1'b0,1'b0};
//                     CMP: {exec_cmd,update_s,wb_en,mem_read,mem_write,b_jump}<={4'b0100,1'b1,1'b0,1'b0,1'b0,1'b0};
//                     TST: {exec_cmd,update_s,wb_en,mem_read,mem_write,b_jump}<={4'b0110,1'b1,1'b0,1'b0,1'b0,1'b0};
//                 endcase
//             end
//             2'b01: begin 
//                 case (s)
//                     1'b1: {exec_cmd,update_s,wb_en,mem_read,mem_write,b_jump}<={4'b0010,1'b1,1'b1,1'b1,1'b0,1'b0};
//                     1'b0: {exec_cmd,update_s,wb_en,mem_read,mem_write,b_jump}<={4'b0010,1'b0,1'b0,1'b0,1'b1,1'b0};
//                 endcase
//             end
//             2'b10: begin
//                 {exec_cmd,update_s,wb_en,mem_read,mem_write,b_jump}<={4'b0000,1'b0,1'b0,1'b0,1'b0,1'b1};
//             end
//         endcase
//     end