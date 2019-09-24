module d_latch_beahv(
  input d,
  input en,
  output reg q);

always @(en, d) begin
  if (en) q <= d;
end

endmodule