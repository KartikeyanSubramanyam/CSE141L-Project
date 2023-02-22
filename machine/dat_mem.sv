// 8-bit wide, 64-word (byte) deep memory array
module dat_mem (
  input[7:0] dat_in,
  input      clk,
  input      wr_en,	          // write enable
  input[7:0] addr,		        // address pointer
  output logic[7:0] dat_out
);

  logic[7:0] core[2**8];       // 2-dim array  8 wide  64 deep

  // reads are combinational; no enable or clock required
  assign dat_out = core[addr];

  // writes are sequential (clocked) -- occur on stores or pushes 
  always @(posedge clk)
    if(wr_en)				  // wr_en usually = 0; = 1 		
      core[addr] <= dat_in; 

endmodule