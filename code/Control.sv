// control decoder
module Control #(parameter opwidth = 3)(
  input[opwidth-1:0] instr,
  output[1:0] how_high,
  output logic RegDst, branch, 
     MemtoReg, MemWrite, ALUSrc, RegWrite,
  output logic[opwidth-1:0] ALUOp);	   // for up to 8 ALU operations

always_comb begin
// defaults
  RegDst 	  = 'b0;   // 1: not in place  just leave 0
  branch 	  = 'b0;   // 1: branch (jump)
  how_high  =  0;    // index at LUT
  MemWrite  =	'b0;   // 1: store to memory
  ALUSrc 	  =	'b0;   // 1: immediate  0: second reg file output
  RegWrite  =	'b1;   // 0: for store or no op  1: most other operations 
  MemtoReg  =	'b0;   // 1: load -- route memory instead of ALU to reg_file data in
  ALUOp	    = instr; // y = a+0;
// sample values only -- use what you need
case(instr)    // override defaults with exceptions
  'b0000:  begin					// store operation
               MemWrite = 'b1;      // write to data mem
               RegWrite = 'b0;      // typically don't also load reg_file
			 end
  'b00001:  ALUOp      = 'b000;  // add:  y = a+b
  'b00010:  MemtoReg = 'b1;    //load 
// ...
endcase

end
	
endmodule