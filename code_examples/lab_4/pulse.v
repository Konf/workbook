...

wire green_light;
wire yellow_light;
wire blink_en;
wire blink;

assign green_light  = (state == green)  | 
                      (state == green_blinking);
assign yellow_light = (state == yellow) |
                      (state == yellow_blinking);
assign blinking_en  = (state == green_blinking) |
                      (state == yellow_blinking);

//код, описывающий поведение схемы пульсации
//выход схемы – сигнал blink
always @(posedge clk) begin
  if (blinking_en = '1') then
  ... // опустим описание
end


assign green  = green_light & blink;
assign yellow = yellow_light & blink;

...