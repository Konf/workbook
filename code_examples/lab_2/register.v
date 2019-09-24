module register_behav(
  input [7:0] d,
  input clk,
  input rst,
  input en,
  output reg [7:0] q);

always @(posedge clk or posedge rst) begin
  if (rst) q <= 0;
  else if (en) q <= d;
end

endmodule