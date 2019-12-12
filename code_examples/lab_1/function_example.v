module function(
  input x0,
  input x1,
  input x2,
  output reg y);

wire [2:0] x_bus;
assign x_bus = {x2, x1, x0};

always @(x_bus) begin
  case (x_bus)
    3'b000:  y = 1'b0;
    3'b010:  y = 1'b0;
    3'b101:  y = 1'b0;
    3'b110:  y = 1'b0;
    3'b111:  y = 1'b0;
    default: y = 1'b1;
  endcase
end

endmodule