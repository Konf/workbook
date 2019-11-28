module square_duty_cycle (
  input clk,
  input rst,

  input         enable,
  input  [20:0] full_period,
  input  [20:0] active_period,
  input  [15:0] volume,

  output [15:0] square_wave
);

reg [20:0] counter;

always @(posedge clk or posedge rst) begin
  if(rst)
    counter <= 21'd0;
  else 
    if ((counter >= full_period) || ~enable)
      counter <= 21'd0;
    else
      counter <= counter + 1;
end

reg square;

always @(posedge clk or posedge rst) begin
  if(rst) begin
    square  <= 1'b0;
  end else if (enable) begin
    if (counter >= full_period) 
      square <= 1'b1;
    else if (counter >= active_period)
      square <= 1'b0;
  end
end

assign square_wave = (square && enable) 
                     ? volume : 16'd0;

endmodule