`include "dmem.v"
module MEM_Stage(
  						clk,
  						regwritee,
  						memtorege,
  						memwritem,
  						branchm,
  			`include "dmem.v"
module MEM_Stage(
  						clk,
  						regwritee,
  						memtorege,
  						memwritem,
  						branchm,
  						zerom,
  						aluoute,
  						writedatam,
  						writerege,
  						pcsrcm,
  						pcbranche,
  						regwritem,
  						memtoregm,
  						aluoutm,
  						readdatam,
  						writeregm,
  						pcbranchm
						);
  input clk, regwritee, memtorege, memwritem, branchm, zerom;
  input [31:0] aluoute, pcbranche, writedatam;
  input [4:0]	writerege;
  output pcsrcm, regwritem, memtoregm;
  output [31:0] aluoutm, readdatam, pcbranchm;
  output [4:0] writeregm;
  
  assign	regwritem = regwritee, memtoregm = memtorege,
    		pcsrcm =	branchm & zerom, aluoutm = aluoute,
    		writeregm = writerege, pcbranchm = pcbranche;
  
  dmem dmem(clk,memwritem,aluoutm,writedatam,readdatam);
endmodule			zerom,
  						aluoute,
  						writedatam,
  						writerege,
  						pcsrcm,
  						pcbranche,
  						regwritem,
  						memtoregm,
  						aluoutm,
  						readdatam,
  						writeregm,
  						pcbranchm
						);
  input clk, regwritee, memtorege, memwritem, branchm, zerom;
  input [31:0] aluoute, pcbranche, writedatam;
  input [4:0]	writerege;
  output pcsrcm, regwritem, memtoregm;
  output [31:0] aluoutm, readdatam, pcbranchm;
  output [4:0] writeregm;
  
  assign	regwritem = regwritee, memtoregm = memtorege,
    		pcsrcm =	branchm & zerom, aluoutm = aluoute,
    		writeregm = writerege, pcbranchm = pcbranche;
  
  dmem dmem(clk,memwritem,aluoutm,writedatam,readdatam);
endmodule
