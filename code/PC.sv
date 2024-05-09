// program counter
// supports both relative and absolute jumps
// use either or both, as desired
module PC #(parameter D=12)(
  input clk,
		    //reljump_en,             // rel. jump enable
        //absjump_en,				// abs. jump enable
  input       [D-1:0] prog_ctr_in,	// how far/where to jump
  output logic[D-1:0] prog_ctr_out
);

  always_ff @(posedge clk) rog_ctr_out <= prog_ctr_in;

endmodule