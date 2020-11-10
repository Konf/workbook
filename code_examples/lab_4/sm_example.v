...

localparam IDLE = 3'b000;
localparam CALC_CHECKSUM = 3'b001;
localparam SEND_DATA = 3'b010;
localparam WAIT_ANSWER = 3'b011;
localparam ANALYSE_ANSWER = 3'b100;
localparam TRY_SECOND_TIME = 3'b101;
localparam ERROR = 3'b110;

reg [2:0] state;


always @(posedge clk or posedge rst) begin
    case (state)
      IDLE:
        if (new_data) 
          state <= calc_cheksum;

      CALC_CHECKSUM:
        if (checksum_calc_complete)
          state <= SEND_DATA;
    
      SEND_DATA:
        state <= WAIT_ANSWER;
      
      WAIT_ANSWER:
        if (answer_recived)
          state <= ANALYSE_ANSWER;
        else if (wait_too_long)
          state <= TRY_SECOND_TIME;
      
      ANALYSE_ANSWER:
        if (answer_is_ok)
          state <= IDLE;
        else
          state <= TRY_SECOND_TIME;
      
      TRY_SECOND_TIME:
        if (already_tried)
          state <= ERROR;
        else
          state <= SEND_DATA;
      
      ERROR:
        if (reset_error)
          state <= ERROR;

      default: state <= ERROR;
    endcase
end


...
