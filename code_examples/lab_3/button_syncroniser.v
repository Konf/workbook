reg [2:0] button_syncroniser;
wire      button_was_pressed;

always @(posedge clk) begin
  button_syncroniser[0] <= in;
  button_syncroniser[1] <= button_syncroniser[0];
  button_syncroniser[2] <= button_syncroniser[1];
end

assign button_was_pressed <= ~button_syncroniser[2]
                            & button_syncroniser[1];
