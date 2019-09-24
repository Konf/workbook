module bus_or(
  input  [7:0] x,
  input  [7:0] y,
  output [7:0] result);

assign result = x | y;

endmodule