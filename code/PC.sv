// program counter
// supports both relative and absolute jumps
// use either or both, as desired
module PC #(parameter D=9)(
  input reset,					// synchronous reset
        clk,
		    //reljump_en,             // rel. jump enable
        //absjump_en,				// abs. jump enable
  input       [D-1:0] prog_ctr_in,	// how far/where to jump
  output logic[D-1:0] prog_ctr_out
);
  logic start;
  logic branch;
  logic taken;
  logic [D-1:0]target;
  logic [D-1:0]prog_ctr;
  nextPC np(.*)
  always_ff @(posedge clk)
    if(reset) prog_ctr <= '0;
	  else prog_ctr_out <= prog_ctr_in;

endmodule