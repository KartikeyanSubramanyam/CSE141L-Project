// sample top level design
module top_level(
  input        clk, reset, 
  output logic done);
  parameter D = 10;               // program counter width;
  wire[D-1:0] target, 			      // jump 
              prog_ctr;
  wire[8:0] mach_code;            // machine code
  wire[7:0]   datA,datB,		      // from RegFile
              muxB, muxR,
              mem_data,
              aluOut, muxOut,
              rM;
  wire[4:0] ALUOp;
  wire[3:0] rd_addrA, rd_addrB, wr_addr;    // address pointers to reg_file
  wire[2:0] Flag;
  wire      aluEqual, aluLess;
  wire      absjump_en;
  
  // Control Signals:
  wire  RegWrite,
        MemWrite,
        ALUSrc,		                // immediate switch
        Branch,
        MemtoReg,
        FlagWrite,
        Immed;
  
  // fetch subassembly
  PC #(.D(D)) 					          // D sets program counter width
     pc1 (.reset,
          .clk,
		      .absjump_en,
		      .target,
		      .prog_ctr);

  // lookup table to facilitate jumps/branches
    // PC_LUT #(.D(D))
    //   pl1 (.addr  (how_high),
    //        .target          );   

  // contains machine code
  instr_ROM #(.D(D)) ir_inst(
    .prog_ctr,
    .mach_code
  );

  // control decoder
  Control ctl_inst(
    .instr(mach_code),
    .Branch, 
    .MemWrite, 
    .ALUSrc, 
    .RegWrite,     
    .MemtoReg,
    .FlagWrite,
    .ALUOp,
    .ReadAddr1(rd_addrA),
    .ReadAddr2(rd_addrB),
    .WriteAddr(wr_addr),
    .Flag,
    .Immed
  );

  reg_file rf_inst(	  // loads, most ops
    .clk,
    .reset,
    .val_in     (muxR),
    .write_en   (RegWrite),
    .rd_addr1   (rd_addrA),
    .rd_addr2   (rd_addrB),
    .wr_addr    (wr_addr),                // in place operation
    .val1_out   (datA),
    .val2_out   (datB),
    .regMem     (rM)
  );

  alu alu_inst(
    .operation(ALUOp),
    .in1    (datA),
    .in2    (muxB),                    // input to sc register
    .out    (aluOut),
    .equal  (aluEqual),
    .less   (aluLess)
  );  

  dat_mem dm1(
    .dat_in(rM),                    // from reg_file
    .clk,
    .wr_en  (MemWrite),                 // stores
    .addr   (muxOut),
    .dat_out(mem_data)
  );

  Branch br_inst(
    .clk,
    .equal       (aluEqual),
    .less        (aluLess),
    .w_flag      (FlagWrite),
    .flag_in     (Flag),
    .branch_instr(Branch),
    .immediate   (muxOut[5:0]),
    .address     (target),
    .branch      (absjump_en)
  );

  assign muxR = MemtoReg ? mem_data : muxOut;
  // If ALUSrc, use immediate
  assign muxB = ALUSrc ? {5'b0, mach_code[2:0]} : datB;

  assign muxOut = Immed ? {2'b0, mach_code[5:0]} : aluOut;

  assign done = &mach_code;
 
endmodule