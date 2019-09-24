module counter_8bit(
  input clk,
  input en,
  input rst,
  output reg [7:0] counter);

always @(posedge clk or posedge rst) begin
  if (rst) counter <= 0;
  else if (en) counter <= counter + 1;
end

endmodule