module ps2_keyboard( 
          input areset, 
          input clk_50,

          input ps2_clk, 
          input ps2_dat, 
          
          output reg valid_data, 
          output [7:0] data); 