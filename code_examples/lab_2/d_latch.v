module d_latch_behav(
  input d,
  input en,
  output reg q);

always @(en, d) begin
  if (en) q <= d;
end

endmodule
