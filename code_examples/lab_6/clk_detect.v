reg [9:0] ps2_clk_detect;

always@(posedge clk_50 or posedge areset)
begin
  if(areset)
    ps2_clk_detect <= 10'd0;
  else
    ps2_clk_detect <= {ps2_clk, ps2_clk_detect[9:1]};
end

wire ps2_clk_negedge = &ps2_clk_detect[4:0] &&
                       &(~ps2_clk_detect[9:5]);