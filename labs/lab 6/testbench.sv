module t_IF;
  reg clk, pcsrc, reset;
  reg [31:0] pcbranch;
  wire [31:0] instr, pcplus4;
  IF_Stage dut(clk, pcsrc, reset, pcbranch, instr, pcplus4);
  integer i;
  always #5 clk = ~clk;
  initial begin
    clk=1;
    reset =1;
    #1 reset =0;
    for(i = 0; i < 64; i = i + 1) dut.imem.RAM[i] = $random;
    for(i = 0; i < 10; i = i + 1) testcase;
    #1 $finish;
  end
  task testcase;
    begin
    @(negedge clk) {clk, pcsrc, reset, pcbranch} = $random;
    reset = 0;
    @(posedge clk) $display("Test Case %d", i);
      #1 $display("pcsrc = %h\tpcbranch = %h", pcsrc, pcbranch);
    $display("pc = %h\tinstr = %h", dut.pc,instr);
      $display("pcnext = %h\t reset = %h", dut.pcnext, dut.reset);
  end
  endtask
endmodule
