
// Register File - 16 file
parameter NUM_REGISTERS = 16;

module reg_file(
    // INPUT
    input            clk, reset,
    // input logic[8:0] instruction;
    input logic[7:0] val_in,                // write-back
    input logic      write_en,
    input logic[3:0] wr_addr, rd_addr1, rd_addr2,

    // OUTPUT
    output logic[7:0] val1_out, val2_out
    // output logic[7:0] rX, rY, rZ, rW, r0, r1, r2, r3, r4, r5, r6, r7, rA, rB, rC, rM;
);

// INTERNAL
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

assign val1_out = registers[rd_addr1];
assign val2_out = registers[rd_addr2];

always_ff @(posedge clk) begin
    if (reset) begin
        for (int i = 0; i < NUM_REGISTERS; i=i+1) registers[i] <= 0;
    end
    else begin
        if (write_en) registers[wr_addr] <= val_in;
    end
end

endmodule