`timescale 1ns/100ps

module regfile #(parameter width = 8)
  ( input clk,
    input we3,
   	input [4:0] ra1, ra2, wa3,
   	input [width-1:0] wd3,
   	output [width-1:0] rd1, rd2);
  
  reg [31:0] rf [31:0];
  // three ported register file
  // read two ports combinationally
  // write third port on rising edge of clk
  // register 0 hardwired to 0
  // note: for pipelined processor, write third port
  // on falling edge of clk
  always @(negedge clk)
    if (we3) rf[wa3] <= wd3;
  
  assign rd1=(ra1 !=0) ? rf[ra1] : 0;
  assign rd2=(ra2 !=0) ? rf[ra2] : 0;
endmodule
