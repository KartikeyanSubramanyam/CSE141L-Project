// control decoder
module Control #(parameter opwidth = 9)(
  input [opwidth-1:0] instr,    // opcode signifies what instruction it is
  output logic Branch, MemtoReg, MemWrite, ALUSrc, RegWrite, FlagWrite, Immed,
  output logic[2:0] Flag,
  output logic[3:0] ReadAddr1, ReadAddr2, WriteAddr,
  output logic[4:0] ALUOp);	   // for up to 32 ALU operations

always_comb begin
  // defaults
  ReadAddr1 = 'b1000;   // Read from rX
  ReadAddr2 = 'b1001;   // Read from rY
  WriteAddr = 'b0000;    // defaults addr to rX
  Branch 	  = 'b0;      // 1: branch (jump)
  MemWrite  =	'b0;      // 1: store to memory
  ALUSrc 	  =	'b0;      // 1: immediate as input into ALU  0: second reg file output as input into ALU
  RegWrite  =	'b0;      // 0: for store or no op  1: most other operations 
  MemtoReg  =	'b0;      // 1: load -- route memory instead of ALU to reg_file data in
  ALUOp	    = 'b11111;  // default value or ERROR
  FlagWrite = 'b0;      // 1: update flag   0: keep flag bits the same
  Flag      = 'b000;    // flag bits
  Immed     = 'b0;      // 1: immediate as ALU output 0: ALU output
    
  // Contains each instruction bits situation needed
  if (instr[8] == 0) begin         // mov operation
    ReadAddr1 = instr[3:0];
    ReadAddr2 = instr[3:0];
    WriteAddr = instr[7:4];
    ALUOp = 'b00000;
    RegWrite = 'b1;
  end
  else if (instr[8:6] == 'b100) begin // b instruction
    Branch = 'b1;                 // instruction jumps
    Immed = 'b1;                 // immediate needed to branch
  end
  else if (instr[8:6] == 'b101) begin // li instruction
    Immed = 'b1;                 // sets to immediate
    RegWrite = 'b1;               // writes to register
    WriteAddr = 'b1111;           // writes to register rM
  end
  else if (instr[8:6] == 'b110) begin // LSL and LSR operations
    WriteAddr = {2'b10, instr[4:3]};       // sets register destination
    ALUSrc = (instr[2:0] == 0) ? 0 : 1;
    RegWrite = 'b1;                 // writes to register
    case(instr[5])
    'b0:                            // lsl operation
      ALUOp = 'b10000;              // sets ALU op to LSL
    'b1:                            // lsr operation
      ALUOp = 'b10001;              // sets ALU op to LSR
    endcase
  end
  else if (instr[8:4] == 'b11110) begin  // lb and sb operations
    ReadAddr1 = {1'b0, instr[2:0]};       // Read from register given by last 3 bits
    ReadAddr2 = {1'b0, instr[2:0]};       // Read from register given by last 3 bits
    ALUOp = 'b00000;              // "and" where it is reading from
    case(instr[3])
      'b0:                         // lb instruction
      begin
        WriteAddr = 'b1111;           // writes to register rM
        RegWrite = 'b1;               // write to register
        MemtoReg = 'b1;               // load (route memory to reg file)
      end
      'b1:                         // sb instruction
      begin
        MemWrite = 'b1;               // write to memory rM
      end
    endcase
  end
  else if (instr[8:5] == 'b1110 && instr[4:3] == 'b11) begin  // set branch flag operations
    FlagWrite = 'b1;                // Writes Flag
    case(instr[2:0])
    'b000:                          
      Flag = instr[2:0];            //sbfne flag
    'b001:                          
      Flag = instr[2:0];            // sbfeg flag
    'b010:
      Flag = instr[2:0];            // sbflt flag
    'b011:
      Flag = instr[2:0];            // sbfle flag
    'b100:
      Flag = instr[2:0];            // sbfjp flag
    endcase
  end 
  else if (instr[8:5] == 'b1110 && instr[4:3] != 'b11) begin // Computational Operations
    WriteAddr = {2'b10, instr[1:0]}; // Writes into rX, rY, rZ, or rW  
    RegWrite = 'b1;                 // writes to register
    case(instr[4:2])
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
  else if (instr[8:4] == 'b11111) begin // Extra Computational Operations
    WriteAddr = {2'b10, instr[1:0]}; // Writes into rX, rY, rZ, or rW  
    RegWrite = 'b1;                 // writes to register
    case(instr[3:2])
    'b00:                          // xor byte operation
      ALUOp = 'b00110;             // sets to xor byte operation
    default:
      ALUOp = 'b11111;
    endcase
  end

end
	
endmodule