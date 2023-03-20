
// Branch

module Branch (
    input clk,                              // input clock
    input reset,
    input logic equal, less, w_flag,
    input logic [2:0] flag_in,              // flag bits to rewrite flag status register if 'change_flag' is 1
    input logic branch_instr,               // whether or not current instruction is a branch
    input logic [5:0] immediate,            // the 6-bit branch immediate
    output logic [9:0] address,             // the 9 bit branch address (immediate << 3)
    output logic branch                    // whether or not to branch
);

logic [2:0] flag_register;

// Check for every posedge clk to update the flag_register
always_ff @(posedge clk) begin
    // Updates flag_register only if the w_flag is triggered
    if (w_flag)
        flag_register <= flag_in;
    if (reset)
        flag_register <= 3'b0;
end

// Checking the flag_register bits; Use equal, less, and branch_instr in order to determine if we branch
// Add 3 zeroes to the end of the immediate to get the address and save it into address
always_comb begin
    // Runs if next instruction is not a branch instruction
    address = {1'b0, immediate, 3'b0};
    branch = 0;
    // Runs if next instruction is a branch instruction
    if (branch_instr) begin
        branch = 1'b1;
        case (flag_register)
            3'b100: branch = 1'b1;
            3'b000: branch = !equal;
            3'b001: branch = equal;
            3'b010: branch = less;
            3'b011: branch = less | equal;
        endcase
    end
end

endmodule