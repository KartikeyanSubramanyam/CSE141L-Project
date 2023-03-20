// CSE141L  Winter 2023
// test bench for programs 1
// flip probabilities:
// 75% one error bit
//    condition: flip2[5:4] != 2'b00;
// 25 * (255/256)%  two error bits
//    condition: flip2[5:4] == 2'b00 && flip2[3:0] != flip;
// 25 * (1/256)% no errors (flip2[5:4] == 2'b00 && flip2[3:0] == flip)
//    
module prog1_tb();

bit   clk    ,                   // clock source -- drives DUT input of same name
	  req  ;	                 // req -- start program -- drives DUT input
wire  done;		    	         // ack -- from DUT -- done w/ program

// program 1-specific variables
bit  [11:1] d1_in[15];           // original messages
bit         p0, p8, p4, p2, p1;  // Hamming block parity bits
bit  [15:0] d1_out[15];          // orig messages w/ parity inserted
bit  [15:0] score1, case1;

// your device goes here
// change "top_level" if you called your device something different
// explicitly list ports if your names differ from test bench's
// if you used any parameters, override them here
top_level DUT(.clk, .reset(req), .done);            // replace "proc" with the name of your top level module

initial begin
  $readmemb("program1.bin",DUT.ir_inst.core);

  for(int i=0;i<15;i++)	begin
    d1_in[i] = $random>>4;        // create 15 messages	   '1    '0
// copy 15 original messages into first 30 bytes of memory 
// rename "dm1" and/or "core" if you used different names for these
    DUT.dm1.core[2*i+1]  = {5'b0,d1_in[i][11:9]};
    DUT.dm1.core[2*i]    =       d1_in[i][ 8:1];
  end
  #10ns req   = 1'b1;          // pulse request to DUT
  #10ns req   = 1'b0;
  wait(done);                   // wait for ack from DUT
// generate parity for each message; display result and that of DUT
  $display("start program 1");
  $display();
  for(int i=0;i<15;i++) begin
    p8 = ^d1_in[i][11:5];
    p4 = (^d1_in[i][11:8])^(^d1_in[i][4:2]); 
    p2 = d1_in[i][11]^d1_in[i][10]^d1_in[i][7]^d1_in[i][6]^d1_in[i][4]^d1_in[i][3]^d1_in[i][1];
    p1 = d1_in[i][11]^d1_in[i][ 9]^d1_in[i][7]^d1_in[i][5]^d1_in[i][4]^d1_in[i][2]^d1_in[i][1];
    p0 = ^d1_in[i]^p8^p4^p2^p1;  // overall parity (16th bit)
// assemble output (data with parity embedded)
    $displayb ({d1_in[i][11:5],p8,d1_in[i][4:2],p4,d1_in[i][1],p2,p1,p0});
    $writeb  (DUT.dm1.core[31+2*i]);
    $displayb(DUT.dm1.core[30+2*i]);
    if({DUT.dm1.core[31+2*i],DUT.dm1.core[30+2*i]} == {d1_in[i][11:5],p8,d1_in[i][4:2],p4,d1_in[i][1],p2,p1,p0}) begin
      $display(" we have a match!");
      score1++;
    end
    else
      $display("erroneous output");   
    $display();
    case1++;
  end
  $display("program 1 score = %d out of %d",score1,case1);
  #10ns $stop;
end

always begin
  #5ns clk = 1;            // tic
  #5ns clk = 0;			   // toc
end										

endmodule
										   