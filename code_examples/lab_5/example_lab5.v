module example_lab5 (
  input clk,
  input rst,
  input [7:0] data,
  input we,
  output full,
  output transmit_lane);

localparam idle = 2'b00;
localparam load = 2'b01;
localparam transmit = 2'b10;
localparam wait_trasnaction_to_complete = 2'b11;

reg [1:0] state;
wire [7:0] data_from_fifo_for_transmitter;
wire fifo_is_empty;
wire fifo_re;
reg transmitter_is_busy;
reg start_transaction;

always @(posedge clk) begin
  case (state) is
    idle: 
      if (fifo_is_empty | 
          transmitter_is_busy) 
        state <= idle;
      else state <= load;
    load: state <= transmit;
    transmit: state <= idle;
  endcase
end

assign fifo_re = (state == load);
assign start_transaction = (state == transmit);

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

endmodule