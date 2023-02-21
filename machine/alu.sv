
// ALU 8 bit

module alu (
    input logic [7:0] in1, in2,
    input logic [4:0] operation,

    // 00101 - C

    // 10001 - S (lsr)
    // 10000 - S (lsl)

    // input logic 

    output logic [7:0] out,
    output logic zero
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
        default     : out = 8'b11111111;    // error    
    endcase
end
endmodule

module alu_control (
    input logic s_or_c, shift_dir,
    // s_or_c: 0 - C, 1 - S
    // shift_dir: 0 - left, 1 - right
    input logic [3:0] op_in,

    output logic [4:0] op_out
);

always_comb begin
    op_out = 5'b11111;
    if (s_or_c) begin
        if (shift_dir) begin
            op_out = 5'b10001
        end else begin
            op_out = 5'b10000
        end
    end else begin
        // case (op_in)
        //     4'b0000 : op_out = 5'b00000
        //     4'b0001 : op_out = 5'b00001
        //     4'b0010 : op_out = 5'b00010
        //     4'b0011 : op_out = 5'b00011
        //     4'b0100 : op_out = 5'b00100
        //     4'b0101 : op_out = 5'b00101
        //     4'b0110 : op_out = 5'b00110
        //     4'b0111 : op_out = 5'b00111
        // endcase
        op_out[4] = 1'b0
        op_out[3:0] = op_in[3:0]
    end
end
endmodule