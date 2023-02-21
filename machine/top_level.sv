// sample top level design
module top_level(
  input        clk, reset, req, 
  output logic done);
  parameter D = 10,               // program counter width
    A = 5;             		        // ALU command bit width
  wire[D-1:0] target, 			      // jump 
              prog_ctr;
  wire        RegWrite;
  wire[7:0]   datA,datB,		      // from RegFile
              muxB, 
			        rslt,               // alu output
              immed,
              mem_data,
              aluOut,
              rM;
  logic sc_in,   				          // shift/carry out from/to ALU
   		  pariQ,                    // registered parity flag from ALU
		    zeroQ;                    // registered zero flag from ALU 
  wire  relj;                     // from control to PC; relative jump enable
  wire  pari,
        zero,
		    sc_clr,
		    sc_en,
        MemWrite,
        ALUSrc,		                // immediate switch
        Branch,
        MemtoR,
        FlagWrite,
        absj;
  wire[A-1:0] ALUOp;
  wire[8:0]   mach_code;          // machine code
  wire[3:0] rd_addrA, rd_addrB, wr_addr;    // address pointers to reg_file
  wire[2:0] Flag;
// fetch subassembly
  PC #(.D(D)) 					          // D sets program counter width
     pc1 (.reset,
          .clk,
		      .absjump_en (absj),
		      .target,
		      .prog_ctr);

// lookup table to facilitate jumps/branches
  // PC_LUT #(.D(D))
  //   pl1 (.addr  (how_high),
  //        .target          );   

// contains machine code
  instr_ROM ir1(.prog_ctr,
                .mach_code);

// control decoder
  Control ctl1(.instr(mach_code),
  .Branch, 
  .MemWrite, 
  .ALUSrc, 
  .RegWrite,     
  .MemtoR,
  .RegWrite,
  .FlagWrite,
  .ALUOp(ALUop),
  .ReadAddr1(rd_addrA),
  .ReadAddr2(rd_addrB),
  .WriteAddr1(wr_addr),
  .Flag(Flag)
  
  );

  // assign rd_addrA = mach_code[2:0];
  // assign rd_addrB = mach_code[5:3];
  // assign alu_cmd  = mach_code[8:6];
  always_comb begin
    case(instr)    // override defaults with exceptions
    'b0000: 
      begin					// store operation
              MemWrite = 'b1;      // write to data mem
              RegWrite = 'b0;      // typically don't also load reg_file
      end
    'b00001:  ALUOp      = 'b000;  // add:  y = a+b
    'b00010:  MemtoReg = 'b1;    // 
    endcase
  end


  reg_file rf_inst(	  // loads, most ops
              .clk,
              .reset
              .write_en   (RegWrite),
              .rd_addr1   (rd_addrA),
              .rd_addr2   (rd_addrB),
              .wr_addr    (wr_addr),                // in place operation
              .val1_out   (datA),
              .val2_out   (datB),
              .regMem     (rM));

  assign muxB = ALUSrc ? immed : datB;

  alu alu_inst(.operation(ALUOp),
            .in1    (datA),
		        .in2    (muxB),                    // input to sc register
		        .out    (aluOut));  

  dat_mem dm_inst(.dat_in(rM),                    // from reg_file
              .clk,
			        .wr_en  (MemWrite),                 // stores
			        .addr   (aluOut),
              .dat_out(mem_data));

// registered flags from ALU
  // always_ff @(posedge clk) begin
  //   pariQ <= pari;
	// zeroQ <= zero;
  //   if(sc_clr)
	//   sc_in <= 'b0;
  //   else if(sc_en)
  //     sc_in <= sc_o;
  // end

  assign done = &instr;
 
endmodule