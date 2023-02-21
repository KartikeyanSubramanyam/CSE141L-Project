module PC_LUT #(parameter D=12)(
  input       [ 1:0] addr,	   // target 4 values
  output logic[D-1:0] target);

  always_comb case(addr)
    0: target = -5;   // go back 5 spaces
	1: target = 20;   // go ahead 20 spaces
	2: target = '1;   // go back 1 space   1111_1111_1111
	default: target = 'b0;  // hold PC  
  endcase

endmodule

/*

	   pc = 4    0000_0000_0100	  4
	             1111_1111_1111	 -1

                 0000_0000_0011   3

				 (a+b)%(2**12)


   	  1111_1111_1011      -5
      0000_0001_0100     +20
	  1111_1111_1111      -1
	  0000_0000_0000     + 0


  */
