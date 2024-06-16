module PC_LUT #(parameter D=12)(
  input[2:0]          how_high,	   // target 4 values
  output logic[D-1:0] target);

  always_comb case(how_high)
    0: target = 2;  
    1: target = 10;//6;
	2: target = 22;//k loop
	3: target = -30;//-26back to k loop
	4: target = 314;//184j loop
	5: target = -316;//-173back to j loop
	6: target = 346;//216i loop
	7: target = -352;//-209back to i loop
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
