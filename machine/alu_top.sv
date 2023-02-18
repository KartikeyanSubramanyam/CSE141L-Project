
// ALU top 8 bit

module alu_top (

    input logic clk, reset,
    input logic [7:0] in1, in2,
    input logic [3:0] opcode,
    input logic s_or_c,

    output logic [7:0] out
);

logic [7:0] alu_out;
logic carry_in, carry_out;
logic [4:0] operation;

alu_control() control_inst (
    .s_or_c(s_or_c),
    .shift_dir(opcode[3]),
    .op_in(opcode),
    .op_out(operation)
);

alu() alu_inst (
    .in1(in1),
    .in2(in2),
    .carry_in(carry_in),
    .operation(operation),
    .out(alu_out),
    .carry_out(carry_out)
);

always_ff @(posedge clk) begin
    carry_in <= carry_out;
    if (reset) begin
        out <= 0;
    end else begin
        out <= alu_out;
    end
end
endmodule