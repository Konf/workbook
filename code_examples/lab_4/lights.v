...

localparam yellow          = 3'b000;
localparam yellow_blinking = 3'b001;
localparam green           = 3'b010;
localparam green_blinking  = 3'b011;
localparam red             = 3'b100;
localparam red_and_yellow  = 3'b101;

reg [2:0] state, next_state;

always @(posedge clk or posedge rst) begin
  if (rst) state <= yellow_blinking;
  else     state <= next_state;
end


always @(*) begin
  if (end_work) next_state <= yellow_blinking;
  else begin
    case (state)
      yellow_blinking: if (start_work) 
        next_state <= green;
      green: if (passed_90_seconds) 
        next_state <= green_blinking;
      green_blinking: if (passed_5_seconds)
        next_state <= yellow;
      yellow: if (passed_2_seconds)
        next_state <= red;
      red: if (passed_25_seconds)
        next_state <= red_and_yellow;
      red_and_yellow: if (passed_5_seconds)
        next_state <= green;
      others: 
        next_state <= yellow_blinking;
    endcase
  end
end


...