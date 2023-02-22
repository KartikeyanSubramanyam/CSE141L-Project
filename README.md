# CSE141L-Project
Team Members: Eric Lui, Akhilan Ganesh, Kartikeyan Subramanyam

Module Descriptions:
Top Level
Module file name: top_level.sv
Functionality Description
The top level module connects all the other modules together. To start with, we pass the reset, clock, branch_enable, and branch_target wires into the program counter in order to get back the program counter value on a 10 bit wire, which is then passed into the ROM. 

The ROM returns the machine_code wire, which is the input wire for control. The output wires of control are primarily read addresses and write addresses, along with a variety of flags, such as MemWrite, Branch, RegWrite, etc. Of all these flags, the most notable are Branch (to be implemented), ALUSrc and Immed. 

We also get the relevant outputs from the register file (val1 and val2, since we do two memory reads per cycle, along with the memory address of rM which is our load/store register) by passing into it the clk, reset, write_enable flag, the val_in, and the relevant addresses for reads and write. 

We made a mux ‘muxB’ to decide whether the second input to the ALU is an immediate, or whether it is our second computational register; datB (which represents rY, since rX is the default first input). We have a second mux to choose either the ALUoutput or the 6 bit immediate encoded in our machine code, depending on the Immed flag from Control. 

The ALUop, datA and the result muxB is passed into the ALU, and the output ‘aluOut’ is the result of the relevant computation. 

For DataMem, we pass in the value to be stored, clock, write_enable flag, and the memory address as inputs, and get dat_out as output, if relevant.

There is a third mux that we create to connect the RegFile and DataMem. The mux chooses either the output of DataMem or just the memory address to be written to, depending on the control flag MemtoReg. 

Program Counter
Module file name: PC.sv
Module testbench file name: N/A for now
Functionality Description
The PC module in the architecture helps the program know what instruction will be read next. In the PC module, it has a synchronous reset with the clock and allows for absolute jumping. For every positive clock edge, it will check if the program should be reset and if it does, then the program counter will be reset to the beginning at 0. Otherwise, it will check if there is a need to jump to a target address if absolute jumping is enabled. If both of these are not enabled, then the PC module will simply tell the machine to move onto the next instruction by incrementing the program counter by 1.

Instruction Memory
Module file name: instr_ROM.sv
Functionality Description
The instruction memory module takes in a 10 bit wide parameter. Using this 10 bit wide parameter, it will have an address to point at. This address will contain the machine code that is to be translated into the instruction it should be. This is done by initially loading in the program at “mach_code.txt” with each instruction line being read in as core[prog_ctr] where prog_ctr is the address. It is then outputted from the module as mach_code with combinational logic so that it changes immediately upon a new instruction being read in.

Control Decoder
Module file name: Control.sv
Functionality Description
This Control Decoder module takes in the opcode given to it by the parameter and reads in the instruction in order to determine what control signals should be set. The following control signals are in this module: ReadAddr1, ReadAddr2, WriteAddr, Branch, MemWrite, ALUSrc, RegWrite, MemtoReg, ALUOp, FlagWrite, Flag, and Immed. For ReadAddr1, it reads inside the register of the first operand of the operation. As for ReadAddr2, it reads inside the register of the second operand of the operation. WriteAddr contains the information regarding which register is being written into for the operation performed. For ReadAddr1, ReadAddr2, and WriteAddr, they will be 4 bits wide because it is used to signify the registers: r0, r1, r2, r3, r4, r5, r6, r7, rX, rY, rZ, rW, rA, rB, rC, rM. For Branch, it will be 1 bit wide with 1 signifying a jump and 0 signifying there is no jump. MemWrite is also 1 bit wide and signifies the instruction read requires storing to memory. ALUSrc and Immed are also 1 bit wide. ALUSrc is 1 when the immediate is the input into the ALU rather than the second register file being used as an input into the ALU. On the other hand, the Immed is 1 when the immediate is used instead of the ALU output and 0 when the ALU output should be used instead. RegWrite is also 1 bit wide and is 1 when an operation requires writing to a register, while it is 0 when there is a store operation or no operation needed at all. MemtoReg, a 1 bit wide signal, is 1 when there is a load which requires routing memory instead of sending data from the ALU to a register file. On the other hand, MemtoReg is 0 when there is no load and memory does not need to be sent to a register file. ALUOp signifies what ALU operation is being done in the instruction: and, or, not, xor, add, sub, lsl (logical shift left), or lsr (logical shift right). The final two control signals: FlagWrite and Flag correspond to the branch flags in our architecture. FlagWrite is 1 bit wide and is 1 when the flag needs to be updated, but it is 0 when there is no need to update the flag bits. Meanwhile, Flag is 3 bits wide and describes what flag has been flagged: sbfne, sbfeq, sbflt, sbfle, or sbfjp. 

Register File
Module file name: reg_file.sv
Module testbench file name: test_reg_file.sv
Functionality Description
The RegFile takes in as input the clock, reset, val_in (value to be written into specific register), write_enable flag, and the write and read addresses for the registers. Since we are using a 16 registers, thats the size of the registers array created in RegFile. Depending on the input read addresses, we read from two of the registers passed in, and output both those values, along with the address for the load/store register rM. If the reset flag is true, we reset all the register values, else if the write_enable flag is true, we store the value passed in as input into the address specified by the write_addr.

ALU (Arithmetic Logic Unit)
Module file name: alu.sv
Module testbench file name: N/A for now
Functionality Description
The ALU takes in the two values it must perform the computation on, along with the operation code. Based on the ALU opcode, the ALU performs logical left-shift, logical right-shift, logical and, logical or, logical xor, logical not, addition or subtraction, and returns the result as output. When instructions such as ‘mov’ or ‘sb’ run, the ALU operation is set to ‘and’ and a register will be and’ed with itself in order to push the value through the ALU unchanged.

Data Memory
Module file name: data_mem.sv
Functionality Description
The DataMem module takes in the data to be stored (‘dat_in’), clock, write_enable flag, and the address at which to store to or load from. We store the input value depending on the write_enable flag, and always return some data specified by the input memory address. Our data memory is a 64 value array, each value 8 bit wide.
