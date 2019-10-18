...

localparam YELLOW          = 3'b000;
localparam YELLOW_BLINKING = 3'b001;
localparam GREEN           = 3'b010;
localparam GREEN_BLINKING  = 3'b011;
localparam RED             = 3'b100;
localparam RED_AND_YELLOW  = 3'b101;

reg [2:0] state;

always @(posedge clk or posedge rst) begin
  if (end_work) state <= YELLOW_BLINKING;
  else begin
    case (state)
      YELLOW_BLINKING: if (start_work) 
        state <= GREEN;
      GREEN: if (passed_90_seconds) 
        state <= GREEN_BLINKING;
      GREEN_BLINKING: if (passed_5_seconds)
        state <= YELLOW;
      YELLOW: if (passed_2_seconds)
        state <= RED;
      RED: if (passed_25_seconds)
        state <= RED_AND_YELLOW;
      RED_AND_YELLOW: if (passed_5_seconds)
        state <= GREEN;
      default: 
        state <= YELLOW_BLINKING;
    endcase
  end
end

...