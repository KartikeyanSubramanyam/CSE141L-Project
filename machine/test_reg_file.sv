

module test_reg_file();

reg clk, reset, done;

logic[7:0] val_in, val1_out, val2_out;

logic write_en;

logic[3:0] wr_addr, rd_addr1, rd_addr2;

// Generate the clock signal
initial begin
    clk = 1'b0;
    forever #1 clk = ~clk;
end

// Generate the reset signal
initial begin
    reset = 1'b1;
    #1
    reset = 1'b0;
    #7
    reset = 1'b1;
end

// Generate the done signal
initial begin
    done = 1'b0;
    #10 done = 1'b1;
end

// Instance
reg_file rf_inst (
    .clk(clk),
    .reset(reset),
    .val_in(val_in),
    .val1_out(val1_out),
    .val2_out(val2_out),
    .write_en(write_en),
    .wr_addr(wr_addr),
    .rd_addr1(rd_addr1),
    .rd_addr2(rd_addr2)
);


// Test stimulus
initial begin
    // monitor output wires
    $monitor("out1: %b, out2: %b", val1_out, val2_out);

    // generate inputs
    write_en = 1'b1;
    val_in = 34;
    wr_addr = 0;
    rd_addr1 = 0;
    rd_addr2 = 1;
    #2
    val_in = 10;
    wr_addr = 1;
    rd_addr1 = 1;
    rd_addr2 = 0;
    #2
    val_in = val1_out + val2_out;
    wr_addr = 2;
    #3
    write_en = 0;
    val_in = 0;
    wr_addr = 0;
    rd_addr1 = 0;
    rd_addr2 = 2;
end

endmodule