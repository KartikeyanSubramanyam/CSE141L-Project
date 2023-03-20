
// ALU 8 bit

module alu (
    input logic [7:0] in1, in2,
    input logic [4:0] operation,

    output logic [7:0] out,
    output logic equal, less
);

always_comb begin
    case(operation)
        5'b10000    : out = in1 << in2;     // LSL     
        5'b10001    : out = in1 >> in2;     // LSR
        5'b00000    : out = in1 & in2;      // and
        5'b00001    : out = in1 | in2;      // or
        5'b00010    : out = (!in1);         // not
        5'b00011    : out = in1 ^ in2;      // xor
        5'b00100    : out = in1 + in2;      // add
        5'b00101    : out = in1 - in2;      // sub
        5'b00110    : out = ^in1;
        default     : out = 8'b11111111;    // error
    endcase
    equal = in1 == in2;
    less  = in1 <  in2;
end
endmodule