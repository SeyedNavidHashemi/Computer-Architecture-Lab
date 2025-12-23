module mux_4_to_1(op1, op2, op3, op4, select, result);
    parameter WIDTH = 32;
    input [WIDTH-1:0] op1, op2, op3, op4;
    input[1:0] select;
    output [WIDTH-1:0] result;
    
    assign result = (select == 2'b00) ? op1 :
                    (select == 2'b01) ? op2 :
                    (select == 2'b10) ? op3 : op4;
endmodule