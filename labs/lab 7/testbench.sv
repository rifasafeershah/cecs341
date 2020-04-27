module t_EX_Stage;
  reg	regwrited, memtoregd, memwrited, branchd, alusrce, regdste;
  reg	[2:0] alucontrole;
  reg	[31:0] srcae, writedatad, signimme, pcplus4e;
  reg	[4:0]	rte, rde;
  wire regwritee, memtorege, memwritee, branche, zeroe;
  wire	[31:0] aluoute, writedatae, pcbranche;
  wire	[4:0] writerege; integer i;
  EX_Stage dut(regwrited,memtoregd,memwrited,branchd,
               alucontrole,alusrce,regdste,srcae,
               writedatad,rte,rde,signimme,pcplus4e,
               regwritee,memtorege,memwritee,branche,
               zeroe,aluoute,writedatae,writerege,
               pcbranche);
  initial begin
    srcae = 32'h00001212;	writedatad = 32'h00003434;
    signimme = 32'hffffffff; pcplus4e = 32'h44444444;
    for(i = 0; i < 8; i = i + 1)
      testcase;
    #10 $finish;
  end
  task testcase; begin
    {regwrited, memtoregd, memwrited, branchd, alusrce, regdste} = $random;
    alucontrole = i;
    case(alucontrole)
      0: $display("ALU is performing AND");
      1: $display("ALU is performing OR");
      2: $display("ALU is performing ADD");
      6: $display("ALU is performing SUB");
      7: $display("ALU is performing SLT");
      default: $display("ALU Operation is invalid");
    endcase
    #1 $display("aluoute = %h", aluoute);
    if (zeroe != (!aluoute)) $display("zero flag is malfunctioning");
    if(regwritee != regwrited || memtorege != memtoregd ||
      memwritee != memwrited || branche != branchd || writedatae != writedatad)
      begin $display("Control signals did not pass correctly"); $finish; end
    if(pcbranche != ({signimme[29:0],2'b00}+pcplus4e))begin
      $display("Branch Adder is malfunctioning"); $finish; end
    if(i == 3) i = 5;
  end endtask
endmodule
