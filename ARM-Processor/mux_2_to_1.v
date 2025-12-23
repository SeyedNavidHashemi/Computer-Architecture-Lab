module mux_2_to_1(op1, op2, select, result);
    parameter WIDTH = 32;
    input [WIDTH-1:0] op1, op2;
    input select;
    output [WIDTH-1:0] result;
    
    assign result = (select == 1'b1) ? op2 : op1;
endmodule