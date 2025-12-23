module adder(first, second, result);
    parameter WIDTH = 32;
    input [WIDTH-1:0]first, second;
    output [WIDTH-1:0]result;

    assign result = first + second;
endmodule