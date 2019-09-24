reg a;
reg b;

always @(posedge clk) begin
  if (in < 5) a <= in;
end

always @(posedge clk) begin
  if (n > 5) begin
      b <= in;
      a <= in – 5; //ошибка!!!
  end
  else b <= a;
end