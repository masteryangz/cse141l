// sample top level design
module top_level(
  input        clk, start, 
  output logic done);
  parameter D = 12,                   // program counter width
            A = 3;             		    // ALU command bit width
  logic[D-1:0] target, 			          // jump 
              prog_ctr_in,
              prog_ctr_out;
  logic        RegWrite;
  logic[7:0]   datA,datB,		          // from RegFile
              muxB, 
			     rslt;                   // alu output
  //logic       sc_in,   				        // shift/carry out from/to ALU
  // 		     pariQ,              	  // registered parity flag from ALU
  //		        zeroQ;                  // registered zero flag from ALU 
  logic        branch,                 // from control to PC; relative jump enable
              taken,
              RegDst,
              pari,
		        sc_clr,
		        sc_en,
              MemWrite,
              MemtoReg,
              ALUSrc;		              // immediate switch
  logic[A-1:0] ALUOp;
  logic[8:0]   mach_code;              // machine code
  logic[2:0]   rd_addrA, rd_addrB;      // address pointers to reg_file
  logic[2:0]   how_high;
  logic[D-1:0] start_address;
  logic[7:0] dat_out;
  assign start_address = 0;
  assign rd_addrA = mach_code[2:0];
  assign rd_addrB = mach_code[5:3];
  assign ALUOp = mach_code[8:6];
// fetch subassembly
  PC #(.D(D)) 					  // D sets program counter width
     pc1 (.clk              ,
		      .prog_ctr_in      ,
          .prog_ctr_out     );

// lookup table to facilitate jumps/branches
  PC_LUT #(.D(D))
    pl1 (.how_high,
         .target          );   

  nextPC #(.D(D))
    np (.start,
        .branch,
        .taken,
        .start_address,
        .target,
        .prog_ctr_in);
// contains machine code
  instr_ROM ir1(.prog_ctr_out,
                .mach_code);

// control decoder
  Control ctl1(
  .ALUOp    ,
  .RegDst   , 
  .branch   , 
  .how_high ,
  .MemWrite , 
  .ALUSrc   , 
  .RegWrite ,     
  .MemtoReg);
  assign muxB = MemtoReg? dat_out : rslt;
  reg_file #(.pw(3)) rf1(.dat_in(muxB),
              .clk,
              .wr_en   (RegWrite),
              .rd_addrA(rd_addrA),
              .rd_addrB(rd_addrB),
              .wr_addr (rd_addrA),      // in place operation
              .datA_out(datA),
              .datB_out(datB)); 



  alu alu1(.ALUOp,
           .inA(datA),
		     .inB(muxB),
		       //.sc_i(sc),   // output from sc register
		     .rslt,
		       //.sc_o,       // input to sc register
		       //.pari,
           .taken);  

  dat_mem dm1(.dat_in(datB)  ,  // from reg_file
             .clk           ,
			    .wr_en(MemWrite),  // stores
			    .addr(datA),
             .dat_out);

// registered flags from ALU
  always_ff @(posedge clk) begin
    //pariQ <= pari;
	 //zeroQ <= zero;
    //if(sc_clr) sc_in <= 'b0;
    //else if(sc_en) sc_in <= sc_o;
  end

  assign done = prog_ctr_out == 128;
 
endmodule