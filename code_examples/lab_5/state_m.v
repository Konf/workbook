reg [1:0] state;

localparam IDLE                   = 2'd0;
localparam RECEIVE_DATA           = 2'd1;
localparam CHECK_PARITY_STOP_BITS = 2'd2;

  
always @(negedge ps2_clk or posedge areset)
  if(areset)
    state <= IDLE;
  else
  begin
   case (state)
   IDLE:
    begin
        if(!ps2_dat)
          state = RECEIVE_DATA;
    end
   RECEIVE_DATA:
    begin
      if (count_bit == 8)
        state = 
         CHECK_PARITY_STOP_BITS;  
    end
   CHECK_PARITY_STOP_BITS:
    begin
      state = IDLE;  
    end   
  default:
    begin
      state = IDLE;
    end
  endcase
end
