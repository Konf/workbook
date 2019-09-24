module latch_struct(
  input nR,
  input nS,
  output Q,
  output nQ);

assign Q = ~(nS & nQ);
assign nQ = ~(nR & Q);

endmodule