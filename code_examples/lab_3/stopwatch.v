module stopwatch (
  input start_stop,
  input reset,
  input clk,
  output [6:0] hex0,  // индикатор сотых долей секунды
  output [6:0] hex1,  // десятых долей секунды
  output [6:0] hex2,  // секунд
  output [6:0] hex3); // десятков секунд

//  Часть I – синхронизация обработки
//  нажатия кнопки «Старт/Стоп»
reg [2:0] button_syncroniser;
      wire button_was_pressed;

always @(posedge clk) begin
  button_syncroniser[0] <= start_stop;
  button_syncroniser[1] <= button_syncroniser[0];
  button_syncroniser[2] <= button_syncroniser[1];
end

assign button_was_pressed = ~ button_syncroniser[2]
                            & button_syncroniser[1];


//  Часть II – выработка признака «device_running »
//  Самостоятельная работа студента!
reg device_running;



//  Часть III - счётчик импульсов
//  и признак истечения 0,01 сек
reg [16:0] pulse_counter =  17'd0;
wire hundredth_of_second_passed =
      (pulse_counter ==  17'd259999);
always @(posedge clk or posedge reset) begin
  if (reset) pulse_counter <= 0;
      //асинхронный сброс
  else if (  device_running |
             hundredth_of_second_passed)
      if (hundredth_of_second_passed)
             pulse_counter <= 0;
      else pulse_counter <= pulse_counter + 1;
end


//  Часть IV - основные счётчики
reg [3:0] hundredths_counter = 4'd0;
wire tenth_of_second_passed =
       ((hundredths_counter == 4'd9) &
         hundredth_of_second_passed);
always @(posedge clk or posedge reset) begin
  if (reset) hundredths_counter <= 0;
  else if (hundredth_of_second_passed)
         if (tenth_of_second_passed)
              hundredths_counter <= 0;
         else hundredths_counter <=
              hundredths_counter + 1;
end


reg [3:0] tenths_counter =  4'd0;
wire second_passed = ((tenths_counter == 4'd9) &
                       tenth_of_second_passed);
always @(posedge clk or posedge reset) begin
  if (reset) tenths_counter <= 0;
  else if (tenth_of_second_passed)
      if (second_passed) tenths_counter <= 0;
      else tenths_counter <= tenths_counter + 1;
end

reg [3:0] seconds_counter = 4'd0;
wire ten_seconds_passed =
       ((seconds_counter == 4'd9) &
         second_passed);
always @(posedge clk or posedge reset) begin
  if (reset) seconds_counter <= 0;
  else if (second_passed)
      if (ten_seconds_passed) seconds_counter <= 0;
      else seconds_counter <= seconds_counter + 1;
end

reg [3:0] ten_seconds_counter = 4'd0;
always @(posedge clk or posedge reset) begin
  if (reset) ten_seconds_counter <= 0;
  else if (ten_seconds_passed)
      if (ten_seconds_counter == 4'd9)
              ten_seconds_counter <= 0;
      else ten_seconds_counter <=
              ten_seconds_counter + 1;
end




//  Часть V - дешифраторы для отображения
//  содержимого основных регистров
//  на семисегментных индикаторах
reg [6:0] decoder_ten_seconds;
always @(*) begin
  case (ten_seconds_counter)
      4'd0:    decoder_ten_seconds =  7'b0000001;
      4'd1:    decoder_ten_seconds =  7'b1001111;
      4'd2:    decoder_ten_seconds =  7'b0010010;
      4'd3:    decoder_ten_seconds =  7'b0000110;
      4'd4:    decoder_ten_seconds =  7'b1001100;
      4'd5:    decoder_ten_seconds =  7'b0100100;
      4'd6:    decoder_ten_seconds =  7'b0100000;
      4'd7:    decoder_ten_seconds =  7'b0001111;
      4'd8:    decoder_ten_seconds =  7'b0000000;
      4'd9:    decoder_ten_seconds =  7'b0000100;
      default: decoder_ten_seconds =  7'b1111111;
  endcase
end

assign hex3 = decoder_ten_seconds;

reg [6:0] decoder_seconds;
always @(*) begin
  case (seconds_counter)
      4'd0:    decoder_seconds =  7'b0000001;
      4'd1:    decoder_seconds =  7'b1001111;
      4'd2:    decoder_seconds =  7'b0010010;
      4'd3:    decoder_seconds =  7'b0000110;
      4'd4:    decoder_seconds =  7'b1001100;
      4'd5:    decoder_seconds =  7'b0100100;
      4'd6:    decoder_seconds =  7'b0100000;
      4'd7:    decoder_seconds =  7'b0001111;
      4'd8:    decoder_seconds =  7'b0000000;
      4'd9:    decoder_seconds =  7'b0000100;
      default: decoder_seconds =  7'b1111111;
   endcase
end

assign hex2 = decoder_seconds;

reg [6:0] decoder_tenths;
always @(*) begin
  case (tenths_counter)
      4'd0:    decoder_tenths = 7'b0000000;
      4'd1:    decoder_tenths = 7'b1001111;
      4'd2:    decoder_tenths = 7'b0010010;
      4'd3:    decoder_tenths = 7'b0000110;
      4'd4:    decoder_tenths = 7'b1001100;
      4'd5:    decoder_tenths = 7'b0100100;
      4'd6:    decoder_tenths = 7'b0100000;
      4'd7:    decoder_tenths = 7'b0001111;
      4'd8:    decoder_tenths = 7'b0000000;
      4'd9:    decoder_tenths = 7'b0000100;
      default: decoder_tenths = 7'b1111111;
   endcase
end

assign hex1 = decoder_tenths;

reg [6:0] decoder_hundredths;
always @(*) begin
  case (hundredths_counter)
      4'd0:    decoder_hundredths = 7'b0000000;
      4'd1:    decoder_hundredths = 7'b1001111;
      4'd2:    decoder_hundredths = 7'b0010010;
      4'd3:    decoder_hundredths = 7'b0000110;
      4'd4:    decoder_hundredths = 7'b1001100;
      4'd5:    decoder_hundredths = 7'b0100100;
      4'd6:    decoder_hundredths = 7'b0100000;
      4'd7:    decoder_hundredths = 7'b0001111;
      4'd8:    decoder_hundredths = 7'b0000000;
      4'd9:    decoder_hundredths = 7'b0000100;
      default: decoder_hundredths = 7'b1111111;
  endcase
end

assign hex0 = decoder_hundredths;

endmodule
