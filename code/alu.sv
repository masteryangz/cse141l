// combinational -- no clock
// sample -- change as desired
module alu(
  input[2:0] ALUOp,    // ALU instructions
  input[7:0] inA, inB,	 // 8-bit wide data path
  //input      sc_i,       // shift_carry in
  output logic[7:0] rslt,
  //output logic sc_o,     // shift_carry out
  // reduction XOR (output)
			           taken     // NOR (output)
);
logic[inB-1:0] shift;
always_comb begin 
  rslt = 'b0;            
  //sc_o = 'b0;    
  taken = 'b0;
  case(ALUOp)
    3'b001: begin//lsf
		assign shift = inA[inB-1:0];
		assign rslt = {shift, inA[7:inB]};
	 end
	 3'b011: //pos
	    if(inA>0) assign taken = 1;
      /*begin
		rslt[7:1] = ina[6:0];
		rslt[0]   = sc_i;
		sc_o      = ina[7];
      end*/
    3'b100: // bitwise XOR
	    rslt = inA ^ inB;
	 3'b101: //beq
	    if(inA==0) assign taken = 1;
  endcase
end
   
endmodule