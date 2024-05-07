// next PC

module nextPC #(parameter D=9)(
  input start,
        start_addr,
        branch,
        raken,
        target
  input       [D-1:0] target,	// how far/where to jump
  output logic[D-1:0] prog_ctr
);

  always_ff @(posedge clk)
    if(reset) prog_ctr <= '0;
	  else if(reljump_en) prog_ctr <= prog_ctr + target;
    else if(absjump_en) prog_ctr <= target;
	  else prog_ctr <= prog_ctr + 'b1;

endmodule