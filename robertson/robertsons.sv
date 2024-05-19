/**
 * Written by: Nicholas Lam
 * Date: 05/17/2024
 * Purpose: CSE141L Resources
 * 
 * @file robertsons.sv
 * @brief This module implements a Robertson's algorithm for multiplication.
 * 
 * The `robertsons` module takes two N-bit inputs, q (multiplier) and m (multiplicand),
 * and performs multiplication using Robertson's algorithm. The result is stored in the
 * output port p (product). The module also has a clock input (clk), a reset input (reset),
 * an output port done indicating when the multiplication is complete, and an internal
 * enum state variable to keep track of the operation state (ADD or SUB).
 * 
 * The module uses a local parameter COUNT to define the length of the loop. It also
 * includes internal logic signals and registers to store intermediate values during
 * the multiplication process.
 * 
 * @param N The bit-width of the multiplier and multiplicand.
 * @param clk The clock input.
 * @param reset The reset input.
 * @param q The multiplier input.
 * @param m The multiplicand input.
 * @param done The output indicating when the multiplication is complete.
 * @param p The product output.
 */

module robertsons #(parameter N = 4) (
    input clk,
    input reset,    
    input [N-1:0] q, // multiplier
    input [N-1:0] m, // multiplicand
    output done,
    output [2*N-1:0] p // product
);

    typedef enum logic { ADD, SUB } op_state;
    op_state state; //for debug

    localparam COUNT = N; //length of loop

    logic done_t;
    logic [N-1:0] accumulator;
    logic [N-1:0] accumulator_sum;
    logic sign;

    logic [N-1:0] multiplier;
    logic [N-1:0] multiplicand;
    logic [2*N-1:0] product;

    logic [N-1:0] temp_buffer;

    logic [$clog2(COUNT):0] counter;

    logic sign_new;


    always_ff @ (posedge clk) begin
        if (!reset) begin
            multiplicand <= m;
            sign <= 'b0;
            product <= 'b0;
            done_t <= 'b0;
            counter <= 'b0;
        end else begin
            sign <= sign_new;
            // handles shifting and sign extension (shift out multiplier LSB)
            product <= {sign_new, accumulator_sum, multiplier[N-1:1]};
            counter <= counter + 1;
            if (counter == COUNT - 1) begin
                done_t <= 'b1;
            end
        end
    end

    /**
     * Here's more about the algorithm written out:
     * 1.   Check the LSB of the multiplier: if 1 then add multiplicand to accumulator, else do nothing
     * 2.   Check if the MSB (the sign) of the multiplicand is 1 then we will sign extend for future adds
     * 2.5  Now right shift the accumulator and multiplier right by 1 bit. Also replace the MSB of the accumulator (after shift) with the sign extend bit
     * 3.   continue steps 1-2.5 until the last cycle
     *
     * Now we are at the last cycle:
     * 4.   if the LSB of multiplier is 1, then subtract multiplicand from accumulator
     * 5.   check XOR of MSB of multiplicand and LSB of current multiplier: the result is the MSB of the final product
     * 6.   perform final right shift by 1 bit on accumulator and multiplier, replace the MSB of the product/accumulator to be the result of the XOR
     */
    always_comb begin
        sign_new = 'b0;
        if (counter == 0) begin
            multiplier = q;
        end else begin
            multiplier = product[N-1:0];
        end

        accumulator = product[2*N-1:N];

        temp_buffer = multiplicand & {N{multiplier[0]}};
        // If not in last cycle
        if (counter < (N - 1)) begin
            // Add multiplicand to accumulator if multiplier LSB is 1
            accumulator_sum = accumulator + (temp_buffer);
            // Sign extend bit
            sign_new = (multiplicand[3] & multiplier[0]) | sign;
            state = ADD; // for debug
        end else begin
            // since last cycle, we want to subtract if multiplier LSB is 1
            accumulator_sum = accumulator - (temp_buffer);
            // since last cycle, multiplier LSB is the real MSB of multiplier
            //  if MSB of multiplicand and multiplier are both 1 then our product should be positive
            sign_new = multiplicand[3] ^ multiplier[0];
            state = SUB; // for debug
        end
    end

    assign done = done_t;
    assign p = product;

endmodule