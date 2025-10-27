module PC_reg(clk, rst, freeze, ld_data, input_data, output_data);
    parameter WIDTH = 32;
    input clk, rst, ld_data, freeze;
    input [WIDTH - 1 :0] input_data;
    output reg [WIDTH - 1:0] output_data;

  always @(posedge clk, negedge rst) begin
    if (~rst) output_data <= 32'b0;
    else if (~freeze && ld_data) output_data <= input_data;
  end
endmodule