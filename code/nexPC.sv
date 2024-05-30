// next PC

module nextPC #(parameter D=12)(
  input start,
        branch,
        taken,
  input       [D-1:0] start_address,
  input       [D-1:0] target,	// how far/where to jump
  input       [D-1:0] prog_ctr_out,
  output logic[D-1:0] prog_ctr_in
);

always_comb begin
  if(start) prog_ctr_in = start_address;
	else if(branch && taken) prog_ctr_in = prog_ctr_out+target;
  else prog_ctr_in = prog_ctr_out+1;
end

endmodule