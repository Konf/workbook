module square_duty_cycle_tb ();

  reg clk;
  reg rst;

  reg         enable;
  reg  [20:0] full_period;
  reg  [20:0] active_period;
  reg  [15:0] volume;


  wire [15:0] square_wave;


  initial begin
  	clk = 0;
  	
  	forever
  	#20 clk = ~clk;

  end


  initial begin
  	
  	rst = 0;
	enable = 0;
  	full_period = 10;
    active_period = 2;

	volume = 16'hff;
	#100
	rst = 1;
	#40
	rst = 0;
	#40
	enable = 1;
	#3000
	enable = 0;

  end


square_duty_cycle UUT(
  .clk (clk),
  .rst (rst),

  .enable (enable),
  .full_period (full_period),
  .active_period (active_period),
  .volume (volume),

  .square_wave (square_wave)
);

endmodule