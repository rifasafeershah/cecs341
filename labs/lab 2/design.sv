`timescale 1ns/100ps

`include "regfile.v"
`include "flopr.v"
`include "alu.v"

`define datasize 32
module simple_datapath(
  input [2:0]	op_code,
  input 		clk, reset,
  input [4:0]	rs, rt, rd,
  input 		wr_en,
  input [`datasize - 1:0] d_in,
  output [`datasize - 1:0] d_out,
  output c, n, z, p
    );
    
  wire [`datasize-1:0] srca, srcb, aluout; //rfDataOut1, rfDataOut2, 
  
  regfile #(`datasize) rf (clk, wr_en, rs, rt, rd, d_in,  	srca, srcb);	//fill in the port list
  alu #(`datasize) a1 (srca, srcb, op_code, aluout, c, n, z, p);	//fill in the port list
  flopr #(`datasize) ALUout (clk, reset, 1, aluout, d_out);
  
endmodule
