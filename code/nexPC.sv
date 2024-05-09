// next PC

module nextPC #(parameter D=12)(
  input start,
        branch,
        taken,
  input       [D-1:0] start_address,
  input       [D-1:0] target,	// how far/where to jump
  output logic[D-1:0] prog_ctr
);

always_comb begin
  if(start) prog_ctr = start_address;
	else if(branch && taken) prog_ctr = target;
  else prog_ctr = prog_ctr+1;
end

endmodule