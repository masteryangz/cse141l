// combinational -- no clock
// sample -- change as desired
module alu(
  input[2:0] ALUOp,    // ALU instructions
  input[7:0] inA, inB,	 // 8-bit wide data path
  //input      sc_i,       // shift_carry in
  output logic[7:0] rslt,
  //output logic sc_o,     // shift_carry out
  // reduction XOR (output)
	output logic taken     // NOR (output)
);
//logic[inB-1:0] shift;
always_comb begin 
  rslt = 'b0;            
  //sc_o = 'b0;    
  taken = 'b0;
  case(ALUOp)
/*
    3'b001: begin//lsf
		  shift = inA[inB-1:0];
		  rslt = {shift, inA[7:inB]};
	  end
*/
    3'b000: //ld
      rslt = inB;
    3'b001: rslt = inA >>> 1;
    3'b010: rslt = inA + inB;
	  3'b011: //pos
	    if(inA[7]==1) taken = 1;
      /*begin
		rslt[7:1] = ina[6:0];
		rslt[0]   = sc_i;
		sc_o      = ina[7];
      end*/
    3'b100: // bitwise XOR
	    rslt = inA ^ inB;
	  3'b101: //beq
	    if(inA==0) taken = 1;
    3'b110: //lw
      rslt = inB;
    3'b111: //sw
      rslt = inB;
  endcase
end
   
endmodule