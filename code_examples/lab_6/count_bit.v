reg  [3:0]  count_bit;

always @(posedge clk_50 or posedge areset) begin
  if(areset)
    count_bit <= 4'b0;
  else if (ps2_clk_negedge) begin
    if(state == RECEIVE_DATA)
      count_bit <= count_bit + 4'b1;
    else
      count_bit <= 4'b0;
  end
end