module PC_LUT #(parameter B=3)(
  input[B:0]          how_high,	   // target 4 values
  output logic[B+2:0] target);

  always_comb case(how_high)
    0: target = 2;   // go forward 2 spaces
    1: target = -2;  // go back 2 spaces
	2: target = 4;   
	3: target = -4;
	4: target = 8;
	5: target = -8;
	6: target = 16;
	7: target = -16;
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
