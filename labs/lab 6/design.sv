`include "mux2.v"
`include "flopr.v"
`include "adder32.v"
`include "imem.v"
module IF_Stage(input clk, pcsrc, reset, input [31:0] pcbranch,
                output [31:0] instr, output[31:0] pcplus4);
  	wire		[31:0] pc, pcnext;
  assign	pc[31:8] = 0;
  
  /************* next PC Logic **************/
  	//	The program counter
  flopr	pcreg(clk,reset,pcnext[7:0],pc[7:0]);
  
  	//	pc incrcement adder
  adder32 pcadd({24'h0,pc[7:0]},32'h4,pcplus4);
  
  	//	branch mux 
  mux2	#(32) pcbrmux(pcplus4,pcbranch,pcsrc,pcnext);
  
  	/********** Instruction Memory **********/
  imem imem( pc[7:2], instr);
  
endmodule
