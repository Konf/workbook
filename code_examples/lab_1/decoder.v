module decoder(
  input  [2:0] x,
  output [3:0] y);

reg [3:0] decoder_output;
always @(x) begin
  case (x)
    3'b000: decoder_output = 4'b0100;
    3'b001: decoder_output = 4'b1010;
    3'b010: decoder_output = 4'b0111;
    3'b011: decoder_output = 4'b1100;
    3'b100: decoder_output = 4'b1001;
    3'b101: decoder_output = 4'b1101;
    3'b110: decoder_output = 4'b0000;
    3'b111: decoder_output = 4'b0010;
  endcase
end

assign y = decoder_output;

endmodule