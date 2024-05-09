// program counter
// supports both relative and absolute jumps
// use either or both, as desired
module PC #(parameter D=12)(
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
  always_comb begin
    start = reset;
    if(prog_ctr_in[D-1:D-4]==101 || prog_ctr_in[D-1:D-4]==011) begin
      branch = 1;
      taken = 1;
      target = '0;
    end
  end
  nextPC np(.*)
  always_ff @(posedge clk)
    if(reset) prog_ctr <= '0;
	  else prog_ctr_out <= prog_ctr;

endmodule