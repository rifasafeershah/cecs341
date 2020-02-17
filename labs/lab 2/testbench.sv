`timescale 1ns/100ps

module datapathTester();
  reg [2:0] op_code;
  reg clk, reset;
  reg [4:0] rs, rt, rd;
  reg wr_en;
  reg [31:0] d_in;
  wire [31:0] d_out;
  wire c,n,z,p;
  
  integer i;
  
  simple_datapath dut(op_code, clk, reset, rs, rt, rd, wr_en, d_in, d_out, c, n, z, p);
  
  always #5 clk = ~clk;
  
  initial begin
    op_code = 0;
    clk = 0;
    {rs, rt, rd} = 0;
    wr_en = 0;	
    d_in = 0; 
    
    //load registers with values
    dut.rf.rf[0] = 0;
    dut.rf.rf[1] = 32'hFFFF0000;
    dut.rf.rf[2] = 32'h0A0A0A0A;
    dut.rf.rf[3] = 32'd500;
    dut.rf.rf[4] = 32'd1000;
    //load remaining registers with random values
    for(i = 5; i < 32; i = i + 1)
      begin
        dut.rf.rf[i] = i;
      end
    
    $display("Registers Initialized!");
    showRegisterContents();
    //perform ALU operations
    //Test case 1: add $ALUout, $3, $4
    @(negedge clk)
    	op_code = 3'b000;
    	rs = 3'b011;
    	rt = 3'b100;
    @(posedge clk) #1
    	checkOperation();
    //Test case 2: inc $ALUout, $3
    @(negedge clk)
    	op_code = 3'b001;
    	rs = 3'b011;
    @(posedge clk) #1
    	checkOperation();
    //Test case 3: and $ALUout, $1, $2
    @(negedge clk)
    	op_code = 3'b010;
    	rs = 3'b001;
    	rt = 3'b010;
    @(posedge clk) #1
    	checkOperation();
    //Test case 4: or $ALUout, $1, $2
    @(negedge clk)
    	op_code = 3'b011;
    	rs = 3'b001;
    	rt = 3'b010;
    @(posedge clk) #1
    	checkOperation();
    //Test case 5: xor $ALUout, $2, $1
    @(negedge clk)
    	op_code = 3'b100;
    	rs = 3'b010;
    	rt = 3'b001;
    @(posedge clk) #1
    	checkOperation();
    //Test case 6: not $ALUout, $2
    @(negedge clk)
    	op_code = 3'b101;
    	rs = 3'b010;
    @(posedge clk) #1
    	checkOperation();
    //Test case 7: sl $ALUout, $4
    @(negedge clk)
    	op_code = 3'b110;
    	rs = 3'b100;
    @(posedge clk) #1
    	checkOperation();
    //Test case 8: nop 
    @(negedge clk)
    	op_code = 3'b111;
    @(posedge clk) #1
    	checkOperation();
    
    
    $finish;
    
    
  end
  
  task showRegisterContents;
    //look directly into the register file to see contents
    begin
      $display("\tRegister\tContent");
    for(i = 0; i < 32; i = i + 1)
      begin
        #1 $display("%d\t0x%h", i, dut.rf.rf[i]);
      end
    end
  endtask	//end of showRegisterContents task

  task checkOperation;
    begin
      $display("\nChecking test case");
      if(op_code == 0 || op_code == 1 || op_code == 6)
        //display arithmetic operation values in decimal
        $display("srca = %d, srcb = %d",dut.srca, dut.srcb);
      else
        //display logical operation values in hex
        $display("srca = %h, srcb = %h",dut.srca, dut.srcb);
      
      case(op_code)
        0: begin
          $display("add $ALUout, $%d, $%d performed",rs,rt);
          $display("sum = %d",d_out);
          if(d_out == (dut.rf.rf[rs]+dut.rf.rf[rt])) begin
            $display("test passed");
          end
          else begin
            $display("Test Failed!!!");
          end
        end
        1: begin
          $display("increment $ALUout, $%d performed",rs);
          $display("d_out = %d",d_out);
          if(d_out == (dut.rf.rf[rs]+1))
            $display("test passed");
          else begin
            $display("Test Failed!!!");
          end
        end
        2: begin
          $display("and $ALUout, $%d, $%d performed",rs,rt);
          $display("d_out = %h",d_out);
          if(d_out == (dut.rf.rf[rs]&dut.rf.rf[rt]))
            $display("test passed");
          else
            $display("Test Failed!!!");
        end
        3: begin
          $display("or $ALUout, $%d, $%d performed",rs,rt);
          $display("d_out = %h",d_out);
          if(d_out == (dut.rf.rf[rs]|dut.rf.rf[rt]))
            $display("test passed");
          else
            $display("Test Failed!!!");
        end
        4: begin
          $display("xor $ALUout, $%d, $%d performed",rs,rt);
          $display("d_out = %h",d_out);
          if(d_out == (dut.rf.rf[rs]^dut.rf.rf[rt]))
            $display("test passed");
          else
            $display("Test Failed!!!");
        end
        5: begin	$display("not $ALUout, $%d performed",rs);
          $display("d_out = %h",d_out);
          if(d_out == (~dut.rf.rf[rs]))
            $display("test passed");
          else
            $display("Test Failed!!!");
            end
        6: begin	$display("sll $ALUout, $%d, performed",rs);
          $display("d_out = %d",d_out);
          if(d_out == (dut.rf.rf[rs]*2))
            $display("test passed");
          else
            $display("Test Failed!!!");
            end
        7: begin	$display("nop operation performed");
          $display("d_out = %h",d_out);
          if(!d_out)
            $display("test passed");
          else
            $display("Test Failed!!!");
        end
        default: $display("ERROR: Invalid Operation!");
      endcase
    end
  endtask	//end of checkOperation task
endmodule
