`timescale 1ns/100ps
`define datasize  4
module alu_tester();
  reg [`datasize-1:0] a,b;
  reg [2:0] aluop;
  wire [`datasize-1:0] y;
  wire c,n,z,p;
  
  alu #(`datasize) dut(a,b,aluop,y,c,n,z,p);
  
  integer i,j,k,l, seed1, seed2;
  
  initial begin
    seed1 = 10*$random;
    seed2 = 10*$random;
    {a,b,aluop,i,j,k,l} = 0;
    for(i = 0; i < 8; i = i + 1)
      begin
        for(j = 0; j < 3; j = j + 1)
          begin
            for(k = 0; k < 3; k = k + 1)
              begin
                aluop = i;
                a = $random(seed1);
                b = $random(seed2);
                #1 $display("Test Case %d",l);
                #1 $display("aluop = %b\ta = %b\t b = %b\ty = %b",aluop,a,b,y);
                #1 $display("c = %b, n = %b, z = %b, p = %b",c,n,z,p);
                #1 $display("");
                l = l + 1;
                #1 $display("");
              end
          end
      end
  end
endmodule
