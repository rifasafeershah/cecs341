`include "mux2.v"

module WB_Stage(
  input regwritem, memtoregm,
  input 	[31:0]	aluoutw, readdata,
  input		[4:0]		writeregm,
  output				regwritew,
  output	[4:0]		writeregw,
  output	[31:0]	resultw);
  
  assign	regwritew = regwritem,
    		writeregw = writeregm;
  //register data input selection mux
  mux2 #(32)	resmux(aluoutw,readdata,memtoregm,resultw);
endmodule
