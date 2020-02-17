`timescale 1ns/100ps

//resettable flip flop with load enable
module flopr #(parameter width = 8)
  ( input clk, reset, load,
   input [width-1:0] d,
   output reg [width-1:0] q);
  
  always @(posedge clk, posedge reset)
    begin
      if (reset) q = 0;
      else if(load) q = d;
    end
endmodule
