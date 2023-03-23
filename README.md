# CSE141L Project
## Eric Lui, Akhilan Ganesh, Kartikeyan Subramanyam

All three testbenches run as intended, and all the results match the solutions.

------------------------
## Executing Testbench Instructions using Quartus 21.1 and Questa - Intel FPGA Starter Edition 2021.2
1. Create a new project using the project wizard on Quartus 21.1 with a new folder in the same directory as all the provided files as the working directory.
2. As for the top_level of the machine, you should be using the top_level.sv file located within the machine folder.
3. The files needed to be included in the project are as follows: `machine/top_level.sv`, `machine/reg_file.sv`, `machine/PC.sv`, `machine/instr_ROM.sv`, `machine/dat_me.sv`, `machine/Control.sv`, `machine/Branch.sv`, and `machine/alu.sv`.
4. For the devices, selecting any of the Intel Arria II devices will suffice.
5. Afterwards, select Intel Questa FPGA as the simulator and SystemVerilog as the code implementation.
6. Once the project has been created, click files and set the `machine/top_level.sv` as the top-level entity.
7. The project then needs to be compiled by clicking the *Compile Design* button to prepare for simulation.
8. Once the project has compiled all the files successfully, click *Tools* and *Run Simulation Tool* > *RTL Simulation*.
9. Locate the `.bin` files for programs 1, 2, and 3 inside the `programs` directory. You may also run the assembler on the `.s` files in the same directory to produce new `.bin` files. Move the appropriate `.bin` files into the `simulation/modelsim` directory located in your Quartus project folder.
10. After Questa opens, you need to compile the testbenches. The testbenches are located inside `machine/testbenches`. For this section, it is best to compile `prog1_tb`, `prog2_tb`, `prog3_tb`, `prog3_tb2`, and `prog3_tb3` together by selecting all of them together.
11. Once all the testbenches have been compiled, you can simulate all of the testbenches. This is done opening the work library and right clicking the desired testbench to run and selecting *Simulate*.
12. After simulation has finished, click the *Run -all* button and the results of the testbench are located in the *Transcript*.

---------------------
## Assembler Instructions
1. Install Python.
2. Open terminal at the top directory of the project.
3. Run `python assembler/assembler.py programs/program1.s programs/program1.bin` to compile program1.s in the programs directory to program1.bin (machine code) in the programs directory. You may also consult `python assembler/assembler.py --help`.

------------------------
## Module Descriptions

*Note: There is no LUT in our machine implementation.*

### 1. Top Level
Module file name: `machine/top_level.sv`

The top level module connects all the other modules together. To start with, we pass the reset, clock, branch_enable, and branch_target wires into the program counter in order to get back the program counter value on a 10 bit wire, which is then passed into the ROM. 

The ROM returns the machine_code wire, which is the input wire for control. The output wires of control are primarily read addresses and write addresses, along with a variety of flags, such as MemWrite, Branch, RegWrite, etc. Of all these flags, the most notable are Branch (to be implemented), ALUSrc and Immed. 

We also get the relevant outputs from the register file (val1 and val2, since we do two memory reads per cycle, along with the memory address of rM which is our load/store register) by passing into it the clk, reset, write_enable flag, the val_in, and the relevant addresses for reads and write. 

We made a mux 'muxB' to decide whether the second input to the ALU is an immediate, or whether it is our second computational register; datB (which represents rY, since rX is the default first input). We have a second mux 'muxOut' to choose either the aluOut or the 6 bit immediate encoded in our machine code, depending on the Immed flag from Control. 

The ALUop, datA and the result muxB is passed into the ALU, and the output ‘aluOut’ is the result of the relevant computation. 

For the data memory module, we pass in the value to be stored, clock, write_enable flag, and the memory address as inputs, and get dat_out as output, if relevant.

There is a third mux that we create to connect the register file and data memory. The mux chooses either the output of data memory or just the memory address to be written to, depending on the control flag MemtoReg. 

### 2. Program Counter
Module file name: `machine/PC.sv`

The program counter module in the architecture helps the program know what instruction will be read next. In the PC module, it has a synchronous reset with the clock and allows for absolute jumping. For every positive clock edge, it will check if the program should be reset and if it does, then the program counter will be reset to the beginning at 0. Otherwise, it will check if there is a need to jump to a target address if absolute jumping is enabled. If both of these are not enabled, then the PC module will simply tell the machine to move onto the next instruction by incrementing the program counter by 1.

### 3. Instruction Memory
Module file name: `machine/instr_ROM.sv`

The instruction memory module takes in a 10 bit wide parameter. Using this 10 bit wide parameter, it will have an address to point at. This address will contain the machine code that is to be translated into the instruction it should be. This is done by initially loading in the program at “mach_code.txt” with each instruction line being read in as core[prog_ctr] where prog_ctr is the address. It is then outputted from the module as mach_code with combinational logic so that it changes immediately upon a new instruction being read in.

### 4. Control Decoder
Module file name: `machine/Control.sv`

The control decoder module takes in the opcode given to it by the parameter and reads in the instruction in order to determine what control signals should be set. The following control signals are in this module: ReadAddr1, ReadAddr2, WriteAddr, Branch, MemWrite, ALUSrc, RegWrite, MemtoReg, ALUOp, FlagWrite, Flag, and Immed. Each control signal will be explained below.

For ReadAddr1, it reads inside the register of the first operand of the operation. As for ReadAddr2, it reads inside the register of the second operand of the operation. WriteAddr contains the information regarding which register is being written into for the operation performed. For ReadAddr1, ReadAddr2, and WriteAddr, they will be 4 bits wide because it is used to signify the registers: r0, r1, r2, r3, r4, r5, r6, r7, rX, rY, rZ, rW, rA, rB, rC, rM. 

For Branch, it will be 1 bit wide with 1 signifying a branch instruction and 0 otherwise. MemWrite is also 1 bit wide and signifies the instruction read requires storing to memory. ALUSrc and Immed are also 1 bit wide. ALUSrc is 1 when the immediate is the input into the ALU rather than the second register file being used as an input into the ALU. On the other hand, the Immed is 1 when the immediate is used instead of the ALU output and 0 when the ALU output should be used instead. RegWrite is also 1 bit wide and is 1 when an operation requires writing to a register, while it is 0 when there is a store operation or no operation needed at all. MemtoReg, a 1 bit wide signal, is 1 when there is a load which requires routing memory instead of sending data from the ALU to a register file. On the other hand, MemtoReg is 0 when there is no load and memory does not need to be sent to a register file. 

ALUOp signifies what ALU operation is being done in the instruction: and, or, not, xor, xrb, add, sub, lsl (logical shift left), or lsr (logical shift right). The final two control signals: FlagWrite and Flag correspond to the branch flags in our architecture. FlagWrite is 1 bit wide and is 1 when the flag needs to be updated, but it is 0 when there is no need to update the flag bits. Meanwhile, Flag is 3 bits wide and describes what flag has been flagged: sbfne, sbfeq, sbflt, sbfle, or sbfjp. 

### 5. Register File
Module file name: `machine/reg_file.sv`

The register file takes in as input the clock, reset, val_in (value to be written into specific register), write_enable flag, and the write and read addresses for the registers. Since we are using a 16 registers, thats the size of the registers array created in the register file. Depending on the input read addresses, we read from two of the registers passed in, and output both those values, along with the address for the load/store register rM. If the reset flag is true, we reset all the register values, else if the write_enable flag is true, we store the value passed in as input into the address specified by the write_addr.

### 6. ALU (Arithmetic Logic Unit)
Module file name: `machine/alu.sv`

The ALU takes in the two values it must perform the computation on, along with the operation code. Based on the ALU opcode, the ALU performs logical left-shift, logical right-shift, logical and, logical or, logical xor, logical within-byte xor, logical not, addition or subtraction, and returns the result as output. When instructions such as ‘mov’ or ‘sb’ run, the ALU operation is set to ‘and’ and a register will be and’ed with itself in order to push the value through the ALU unchanged.

### 7. Data Memory
Module file name: `machine/data_mem.sv`

The data memory module takes in the data to be stored (‘dat_in’), clock, write_enable flag, and the address at which to store to or load from. We store the input value depending on the write_enable flag, and always return some data specified by the input memory address. Our data memory is a 64 value array, each value 8 bit wide.

### 8. Branch Module
Module file name: `machine/Branch.sv`

The branch module handles the timing and targets of branching in a program. The module takes in a Branch signal from the control decoder which notes when the current instruction is a branch. The branch module computes the target address for a branch from the branch instruction's 6-bit immediate (converted by appending 3 ground bits to get a 9-bit address).

The branch module stores an internal 3-bit branch flag register, which determines what branch condition (relational operator) applies given the values in rX and rY (these registers will always be used for checking branch conditions). The following conditions are possible: jp (always jump), le (rX less than or equal to rY), lt (rX less than rY), eq (rX equal to rY), ne (rX not equal to rY).

Two ALU combinational signals 'less' and 'equal' are inputs to the branch module to determine whether the branch condition is satisfied. 