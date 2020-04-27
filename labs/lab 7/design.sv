`include "mux2.v"
`include "adder32.v"
`include "sl2.v"
`include "alu.v"

module EX_Stage(
  regwrited,
  memtoregd,
  memwrited,
  branchd,
  alucontrole,
  alusrce,
  regdste,
  srcae,
  writedatad,
  rte,
  rde,
  signimme,
  pcplus4e,
  regwritee,
  memtorege,
  memwritee,
  branche,
  zeroe,
  aluoute,
  writedatae,
  writerege,
  pcbranche
);
  input	regwrited, memtoregd, memwrited,
  		branchd, alusrce, regdste;
  input			[2:0]	alucontrole;
  input			[31:0]	srcae, writedatad, signimme, pcplus4e;
  input			[4:0]	rte, rde;
  output		regwritee, memtorege, memwritee, branche, zeroe;
  output	[31:0] aluoute, writedatae, pcbranche;
  output	[4:0]	writerege;
  
  wire			[31:0] srcbe, signimmshe;
  
  assign	regwritee	=	regwrited,
    			memtorege	=	memtoregd,
    			memwritee	=	memwrited,
    			branche		=	branchd,
    			writedatae	=	writedatad;
  
  alu alu(srcae,srcbe,alucontrole,aluoute,zeroe);
  
  mux2 #(32) srcbmux(writedatae,signimme,alusrce,srcbe);
  
  mux2 #(5) wrmux(rte,rde,regdste,writerege);
  
  sl2	immsh(signimmshe,signimme);
  
  adder32	pcadd2(pcplus4e,signimmshe,pcbranche);
endmodule
