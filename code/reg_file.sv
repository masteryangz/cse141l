// cache memory/register file
// default address pointer width = 4, for 16 registers
module reg_file #(parameter pw=3)(
  input[7:0] dat_in,
  input      clk,
  input      wr_en,           // write enable
  input[pw-1:0] wr_addr,		  // write address pointer
              rd_addrA,		  // read address pointers
			  rd_addrB,
  output logic[7:0] datA, // read data
                    datB);

  logic[7:0] core[2**pw];    // 2-dim array  8 wide  16 deep
  assign core[0] = 0;
  assign core[1] = 0;
  assign core[2] = 0;
  assign core[3] = 0;
  assign core[4] = 0;
  assign core[5] = -1;
  assign core[6] = 1;
  assign core[7] = 64;
  

// reads are combinational
  assign datA = core[rd_addrA];
  assign datB = core[rd_addrB];

// writes are sequential (clocked)
  always_ff @(posedge clk)
    if(wr_en) core[wr_addr] <= dat_in; 

endmodule