// control decoder
module Control #(parameter opwidth = 3)(
  input[opwidth-1:0] ALUOp,
  output logic branch, ldImmed,
    MemtoReg, MemWrite, RegWrite);

always_comb begin
// defaults
  //RegDst 	  = 'b0;   // 1: not in place  just leave 0
  branch 	  = 'b0;   // 1: branch (jump)
  MemWrite  =	'b0;   // 1: store to memory
  ldImmed	  =	'b0;   // 1: immediate  0: second reg file output
  RegWrite  =	'b1;   // 0: for store or no op  1: most other operations 
  MemtoReg  =	'b1;   // 1: load -- route memory instead of ALU to reg_file data in
// sample values only -- use what you need
case(ALUOp)    // override defaults with exceptions

  'b000:  ldImmed    = 'b1;
  'b001:  
  'b010:  begin
            RegWrite = 'b0;
            MemtoReg = 'b0;
          end
  'b011:  branch     = 'b1;
  'b100:
  'b101:  branch     = 'b1;
  'b110:
  'b111:  begin
            MemWrite = 'b1;  
            RegWrite = 'b0;
          end

// ...

endcase

end
	
endmodule