reg  [8:0]  shift_reg;

  assign data = shift_reg[7:0];

  always @(negedge ps2_clk or posedge areset) begin
    if(areset)
	    shift_reg <= 9'b0;
	 else
		if(state == RECEIVE_DATA)
	    shift_reg <= 
		    {ps2_dat, shift_reg[8:1]};
  end
