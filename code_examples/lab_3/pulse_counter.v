//регистр счётчика
reg [16:0] pulse_counter = 17'd0;

//описание компаратора
wire hundredth_of_second_passed =
              (pulse_counter == 17'd259999);

//описание счётчика
always @(posedge clk or posedge reset) begin
   // асинхронный сброс
  if (reset) pulse_counter <= 0;

   // сигнал разрешения работы счётчика
  else if (device_running |
              hundredth_of_second_passed)

       // синхронный сброс по достижению максимума
      if (hundredth_of_second_passed)
        pulse_counter <= 0;

       // увеличение счётчика на единицу
      else pulse_counter <= pulse_counter + 1;
end
