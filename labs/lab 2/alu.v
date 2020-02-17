`timescale 1ns/100ps
module alu #(parameter width = 8)
  (
    input [width-1:0] a,b,
    input [2:0] aluop,
    output reg [width-1:0] y,
    output reg c,n,z,p
  );
  
  always @(a,b,aluop)
    begin
      {y,c,n,z,p} = 0; //c = carry , n = sign , z = zero , p = parity
      case(aluop)
        0: {c,y} = a + b; //addition
        1: {c,y} = a + 1; //increment
        2: y = a & b; //and
        3: y = a | b; //or
        4: y = a ^ b; //exclusive or
        5: y = !a; //not a
        6: {c,y} = a << 1; //logical shift left
        7: y = 0; //no operation
        default: y = 32'bZ;
      endcase
      n = y[width-1]; 
      z = !y;
      p = ^y;
    end
endmodule
