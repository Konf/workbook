module d_flipflop_beahv(
  input d,
  input clk,
  input rst,
  input en,
  output reg q);

always @(posedge clk or posedge rst) begin
  if (rst) q <= 0;
  else if (en) q <= d;
end

endmodule