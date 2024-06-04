`timescale 1ns/1ns
module alu_tb;
 logic taken;
 logic[2:0] ALUOp;
 logic[7:0] inA, inB, rslt;

// Instantiate design under test
alu a(
.ALUOp,
.inA,
.inB,
.rslt,
.taken
);

initial begin
// Initialize Inputs
ALUOp = 'b001;
inA = 'b10100000;
inB = 'b110;

#10;
ALUOp = 'b010;
inA = 'b00010001;
inB = 'b10010000;

#10;
ALUOp = 'b011;
inA = 'b10000000;
inB = 'b00000000;

#10;
ALUOp = 'b100;
inA = 'b00010001;
inB = 'b10010000;

#10;
ALUOp = 'b101;
inA = 'b00000000;
inB = 'b00000000;
#10
// terminate simulation
$stop;
end

// Print input and output signals
initial begin
 $monitor(" opcode=%d,  inA=%d  inB=%d  rslt=%d  taken=%d", ALUOp, inA, inB, rslt, taken);
end

endmodule