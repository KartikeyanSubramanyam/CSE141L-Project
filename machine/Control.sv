// control decoder
module Control #(parameter opwidth = 9)(
  input [opwidth-1:0] instr,    // opcode signifies what instruction it is
  output logic Branch, MemtoReg, MemWrite, ALUSrc, RegWrite,
  output logic[3:0] ReadAddr1, ReadAddr2, WriteAddr,
  output logic[4:0] ALUOp);	   // for up to 32 ALU operations

always_comb begin
  // defaults
    ReadAddr1 = 'b0000;   // Read from rX
    ReadAddr2 = 'b0001;   // Read from rY
    WriteAddr = 'b0000    // defaults addr to rX
    Branch 	  = 'b0;      // 1: branch (jump)
    MemWrite  =	'b0;      // 1: store to memory
    ALUSrc 	  =	'b0;      // 1: immediate  0: second reg file output
    RegWrite  =	'b1;      // 0: for store or no op  1: most other operations 
    MemtoReg  =	'b0;      // 1: load -- route memory instead of ALU to reg_file data in
    ALUOp	    = 'b11111;  // default value or ERROR
end
  // Contains each instruction bits situation needed
  if (instr == 'b111111111) begin   // DONE operation
    ReadAddr1 = 'b0000;   // Read from rX
    ReadAddr2 = 'b0001;   // Read from rY
    WriteAddr = 'b0000    // defaults addr to rX
    Branch = 'b0;                   // don't jump
    MemWrite = 'b0;                 // don't write to mem
    ALUSrc = 'b0;                   // defaults to second reg file output
    RegWrite = 'b0;                 // no op
    MemtoReg = 'b0;                 // routes ALU to reg_file
    ALUOp    = 'b11111              // sets to default value of ALU operations
  end
  else if (instr == 'b111111110) begin    // nop operation
    ReadAddr1 = 'b0000;   // Read from rX
    ReadAddr2 = 'b0001;   // Read from rY
    WriteAddr = 'b0000    // defaults addr to rX
    Branch = 'b0;                   // don't jump
    MemWrite = 'b0;                 // don't write to mem
    ALUSrc = 'b0;                   // defaults to second reg file output
    RegWrite = 'b0;                 // no op
    MemtoReg = 'b0;                 // routes ALU to reg_file
    ALUOp    = 'b11111              // sets to default value of ALU operations
  end
  else if (instr[8:5] == 'b1110 && instr[4:3] != 'b11) begin // Computational Operations
    ReadAddr1 = 4'b0000;            // Read from rX
    ReadAddr2 = 4'b0001;            // Read from rY
    WriteAddr = {2'b00, instr[1:0]}; // Writes into rX, rY, rZ, or rW
    Branch = 'b0;                   // don't jump  
    RegWrite = 'b1;                 // writes to register
    MemtoReg = 'b0;                 // does not send from memory to reg
    MemWrite = 'b0;                 // don't write to mem
    ALUSrc = 'b0;                   // defaults to second reg file output
    case (instr[4:2])
    'b000:                         // logical add operation
      ALUOp = 'b00100;             // sets to add operation
    'b001:                         // logical sub operation
      ALUOp = 'b00101;             // sets to sub operation
    'b010:                         // logical and operation
      ALUOp = 'b00000;             // sets to and operation
    'b011:                         // logical or operation
      ALUOp = 'b00001;             // sets to or operation
    'b100:                         // logical not operation
      ALUOp = 'b00010;             // sets to not operation
    'b101:                         // logical xor operation
      ALUOp = 'b00011;             // sets to xor operation
    default:                       // ERROR
      ALUOp = 'b11111;             // ERROR, no such operation
    endcase
  end
  else if (instr[8:5] == 'b1110 && instr[4:3] == 'b11) begin  // set branch flag operations
    ReadAddr1 = 4'b0000;            // Read from rX
    ReadAddr2 = 4'b0001;            // Read from rY
    WriteAddr = 'b00000;            // does not write
    Branch = 'b1;                   // branch is set here  
    RegWrite = 'b0;                 // does not write to register
    MemtoReg = 'b0;                 // does not send from mem to reg
    MemWrite = 'b0;                 // don't write to mem
    ALUSrc = 'b0;                   // defaults to second reg file output      
  else if (instr[8:6] == 'b110) begin
    instr[5]
  end


end
	
endmodule