module example_lab6 (
  input clk,
  input rst,
  input [7:0] data,
  input we,
  output full,
  output transmit_lane);

localparam IDLE = 2'b00;
localparam LOAD = 2'b01;
localparam TRANSMIT = 2'b10;
localparam WAIT_TRASNACTION_TO_COMPLETE = 2'b11;

reg [1:0] state;
wire [7:0] data_from_fifo_for_transmitter;
wire fifo_is_empty;
wire fifo_re;
reg transmitter_is_busy;
reg start_transaction;

always @(posedge clk) begin
  case (state) is
    IDLE: 
      if (fifo_is_empty | 
          transmitter_is_busy) 
        state <= IDLE;
      else state <= LOAD;
      
    LOAD: state <= TRANSMIT;
    TRANSMIT: state <= IDLE;
  endcase
end

assign fifo_re = (state == LOAD);
assign start_transaction = (state == TRANSMIT);

fifo fifo_input_buffer(
  .we(we),
  .re(fifo_re),
  .data_in(data),
  .data_out(data_from_fifo_for_transmitter),
  .empty(fifo_is_empty),
  .full(full)
);
  
tansmitter my_transmitter(
  .start(start),
  .busy(busy),
  .data(data_from_fifo_for_transmitter),
  .tx(transmit_lane)
);

end
