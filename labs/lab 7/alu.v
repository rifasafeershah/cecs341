module alu(srca, srcb, alucontrol, aluout, zero);
  input [31:0] srca, srcb;
  input	 [2:0]		alucontrol;
  output	[31:0] aluout;
  output 	zero;
  
  assign	aluout =  (alucontrol == 0) ?  srca  &   srcb   :
    (alucontrol == 1)  ?  srca   |   srcb	:
    (alucontrol == 2)  ?  srca	 +   srcb   :
    (alucontrol == 6)  ?  srca   -   srcb	:
    (alucontrol == 7)  ?  (srca < srcb)  :
    32'hx, //default aluout value
    zero	= 	!aluout;
endmodule
