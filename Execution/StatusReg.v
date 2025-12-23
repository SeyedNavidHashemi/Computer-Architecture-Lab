module StatusReg(clk, rst, Status_bits, S, SR);
    input clk, rst, S;
    input [3:0] Status_bits
    output reg [3:0] SR;

  always @(negedge clk, negedge rst) begin
    if (~rst) SR <= 4'b0;
    else if (S) SR <= Status_bits;
  end
endmodule