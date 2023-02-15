
// Register File - 16 file
module reg_file();

const int NUM_REGISTERS = 16;

// INPUT
input            clk, reset, start;
// input logic[8:0] instruction;
input logic[7:0] val_in;                // write-back
input logic      write_en;
input logic[3:0] reg_dest, reg1_out, reg2_out;

// OUTPUT
output logic[7:0] val1_out, val2_out;

// INTERNAL
logic done;
logic[7:0] registers[NUM_REGISTERS];
logic[7:0] rX, rY, rZ, rW, r0, r1, r2, r3, r4, r5, r6, r7, rA, rB, rC, rM;


assign rX = registers[4'b0000];
assign rY = registers[4'b0001];
assign rZ = registers[4'b0010];
assign rW = registers[4'b0011];
assign r0 = registers[4'b0100];
assign r1 = registers[4'b0101];
assign r2 = registers[4'b0110];
assign r3 = registers[4'b0111];
assign r4 = registers[4'b1000];
assign r5 = registers[4'b1001];
assign r6 = registers[4'b1010];
assign r7 = registers[4'b1011];
assign rA = registers[4'b1100];
assign rB = registers[4'b1101];
assign rC = registers[4'b1110];
assign rM = registers[4'b1111];


always_ff @(posedge clk, posedge reset) begin
    if (reset) begin
        done <= 0;
        for (int i = 0; i < NUM_REGISTERS; i=i+1) registers[i] <= 0;
        val1_out <= 0;
        val2_out <= 0;
    end
    else begin
        if (write_en) registers[reg_dest] <= val_in;
        val1_out <= registers[reg1_out];
        val2_out <= registers[reg2_out];
    end
end