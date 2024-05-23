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
  RegWrite  =	'b1;   // 0: for store or jump  1: most other operations 
  MemtoReg  =	'b0;   // 1: load -- route memory instead of ALU to reg_file data in
// sample values only -- use what you need

//////////////// IMPORTANT: currently using LBD ISA ver 1.0////////////////////////
case(ALUOp)    // override defaults with exceptions

  'b000:  ldImmed    = 'b1;
  'b011:  begin
            branch   = 'b1;
            RegWrite = 'b0; 
  end
  'b101:  begin
            branch   = 'b1;
            RegWrite = 'b0;
  end
  'b110:  MemtoReg   = 'b1;
  'b111:  begin
            MemWrite = 'b1;
            RegWrite = 'b0;
  end

// ...

endcase

end
	
endmodule