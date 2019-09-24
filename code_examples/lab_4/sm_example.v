...

localparam idle = 3'b000;
localparam calc_checksum = 3'b001;
localparam send_data = 3'b010;
localparam wait_answer = 3'b011;
localparam analyse_answer = 3'b100;
localparam try_second_time = 3'b101;
localparam error = 3'b110;

reg [2:0] state, next_state;

always @(posedge clk or posedge rst) begin
  if (rst) state <= idle;
  else state <= next_state;
end

always @(*) begin
    case (state)
      idle:
        if (new_data) 
          next_state <= calc_cheksum;

      calc_cheksum:
        if (checksum_calc_complete)
          next_state <= send_data;
    
      send_data:
        next_state <= wait_answer;
      
      wait_answer:
        if (answer_recived)
          next_state <= analyse_answer;
        else if (wait_too_long)
          next_state <= try_second_time;
      
      analyse_answer:
        if (answer_is_ok)
          next_state <= idle;
        else
          next_state <= try_second_time;
      
      try_second_time:
        if (already_tried)
          next_state <= error;
        else
          next_state <= send_data;
      
      error:
        if (reset_error)
          next_state <= error;

      others: next_state <= error;
    endcase
end

...