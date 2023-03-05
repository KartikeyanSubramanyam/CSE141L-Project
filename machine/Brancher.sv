
// Brancher

module Brancher (
    input logic equal, less, change_flag,
    input logic [2:0] flagIn,               // flag bits to rewrite flag status register if 'change_flag' is 1
    input logic branch_instr,               // whether or not current instruction is a branch
    input logic [5:0] immediate,            // the 6-bit branch immediate
    output logic [8:0] address,             // the 9 bit branch address (immediate << 3)
    output logic branch;                    // whether or not to branch
);

logic [2:0] flag_register;

always_comb begin

end

endmodule