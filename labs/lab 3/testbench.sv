`timescale 1ns/1ps
module t_controller();
  reg [5:0] op,funct; reg zero;
  wire memtoreg,memwrite,pcsrc,alusrc,regdst,regwrite,jump;
  wire [2:0] alucontrol;
  
  controller dut(op,funct,zero,memtoreg,memwrite,
                 pcsrc,alusrc,regdst,regwrite,jump,alucontrol);
  integer i; reg [5:0] funct_codes [4:0];
  
  initial begin
    funct_codes[0] = 6'b100000; //add
    funct_codes[1] = 6'b100010; //sub
    funct_codes[2] = 6'b100100; //and
    funct_codes[3] = 6'b100101; //or
    funct_codes[4] = 6'b101010; //slt
  end
  
  initial begin
    $display("Testing R-Type instructions");
    op = 0;
    for(i = 0; i < 5; i = i + 1)
      begin
        funct = funct_codes[i]; #1 showsignals();
      end
    funct = 6'bx;     //funct field doesn't matter for remaining instructions
    op = 6'b100011; #1 $display("lw"); showsignals();
    op = 6'b101011; #1 $display("sw"); showsignals();
    op = 6'b000100; zero = 1; #1 $display("beq (branch taken)"); showsignals();
    				zero = 0; #1 $display("beq (branch NOT taken)"); showsignals();
    op = 6'b001000; #1 $display("addi"); showsignals();
    op = 6'b000010; #1 $display("j"); showsignals();
    $display("end simulation"); $finish;
  end
  task showsignals; begin
    $display("%b", {memtoreg,memwrite,pcsrc,alusrc,regdst,regwrite,jump,alucontrol});
  end endtask
endmodule
