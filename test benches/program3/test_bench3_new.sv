// program 3    CSE141L   double precision two's comp. multiplication
module test_bench;

// connections to DUT: clock, start (request), done (acknowledge) 
  bit  clk,
       start = 'b1;			          // request to DUT
  wire done;                          // acknowledge from DUT

  logic signed[15:0]  Tmp[32];	      // caches all 32 2-byte operands
  logic signed[31:0] Prod[16];	      // caches all 16 4-byte products
  
  top_level D1(.clk  (clk  ),	              // your design goes here
		 .start(start),
		 .done (done )); 

always begin
    #50ns clk = 'b1;
    #50ns clk = 'b0;
end

// number of tests
int itrs = 10;

  initial begin
// load operands for program 3 into data memory
// 32 double-precision operands go into data_mem [0:63]
// first operand = {data_mem[0],data_mem[1]}  
    for(int loop_ct=0; loop_ct<itrs; loop_ct++) begin
        #100ns;
        case(loop_ct)
      //   0: $readmemb("C:/Users/y1499/OneDrive/Desktop/cse141l/test_files/test0.txt",D1.dm.core);
	    // 1: $readmemb("C:/Users/y1499/OneDrive/Desktop/cse141l/test_files/test1.txt",D1.dm.core);
      //   2: $readmemb("C:/Users/y1499/OneDrive/Desktop/cse141l/test_files/test2.txt",D1.dm.core);
	    // 3: $readmemb("C:/Users/y1499/OneDrive/Desktop/cse141l/test_files/test3.txt",D1.dm.core);
      //   4: $readmemb("C:/Users/y1499/OneDrive/Desktop/cse141l/test_files/test4.txt",D1.dm.core);
      //   5: $readmemb("C:/Users/y1499/OneDrive/Desktop/cse141l/test_files/test5.txt",D1.dm.core);
      //   6: $readmemb("C:/Users/y1499/OneDrive/Desktop/cse141l/test_files/test6.txt",D1.dm.core);
	    // 7: $readmemb("C:/Users/y1499/OneDrive/Desktop/cse141l/test_files/test7.txt",D1.dm.core);
      //   8: $readmemb("C:/Users/y1499/OneDrive/Desktop/cse141l/test_files/test8.txt",D1.dm.core);
      //   9: $readmemb("C:/Users/y1499/OneDrive/Desktop/cse141l/test_files/test9.txt",D1.dm.core);

          0: $readmemb("D:/cse141l/test_files/test0.txt", D1.dm.core);
  1: $readmemb("D:/cse141l/test_files/test1.txt", D1.dm.core);
  2: $readmemb("D:/cse141l/test_files/test2.txt", D1.dm.core);
  3: $readmemb("D:/cse141l/test_files/test3.txt", D1.dm.core);
  4: $readmemb("D:/cse141l/test_files/test4.txt", D1.dm.core);
  5: $readmemb("D:/cse141l/test_files/test5.txt", D1.dm.core);
  6: $readmemb("D:/cse141l/test_files/test6.txt", D1.dm.core);
  7: $readmemb("D:/cse141l/test_files/test7.txt", D1.dm.core);
  8: $readmemb("D:/cse141l/test_files/test8.txt", D1.dm.core);
  9: $readmemb("D:/cse141l/test_files/test9.txt", D1.dm.core);
        endcase
        for(int i=0; i<32; i++) begin
          Tmp[i] = {D1.dm.core[2*i],D1.dm.core[2*i+1]};	  // load values into mem, copy to Tmp array
          $display("%d:  %d",i,Tmp[i]);
	    end
        // 	compute correct answers
        for(int j=0; j<16; j++) 			              // pull pairs of operands from memory
	        #1ns Prod[j] = Tmp[2*j+1]*Tmp[2*j];		      // compute prod.
	    #200ns start = 'b0; 							  
        #200ns wait (done);						          // avoid false done signals on startup
	    for(int k=0; k<16; k++)
	      if({D1.dm.core[64+4*k],D1.dm.core[65+4*k],D1.dm.core[66+4*k],D1.dm.core[67+4*k]} == Prod[k])
	        $display("Yes! %d * %d = %d",Tmp[2*k+1],Tmp[2*k],Prod[k]);
	      else
	        $display("Boo! %d * %d should = %d",Tmp[2*k+1],Tmp[2*k],Prod[k]);    
        // check results in data_mem[66:67] and [68:69] (Minimum and Maximum distances, respectively)
   
      #200ns start = 'b1;
	    #200ns start = 'b0;
	    if(loop_ct==itrs-1) $stop;
    end
    
  end

endmodule
