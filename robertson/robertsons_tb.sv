
include "robertsons.sv";
`timescale 1ns/1ns

module robertsons_tb;

    localparam N = 4;
    logic clk, reset, done;
    logic signed [N-1:0] q, m;
    logic signed [2*N-1:0] p;
    logic signed [2*N-1:0] p_signed;


    robertsons dut (
        .clk(clk), 
        .reset(reset), 
        .q(q), 
        .m(m), 
        .done(done), 
        .p(p)
    );

    initial begin
        // test negative multiplier, negative multiplicand
        q = -4; 
        m = -7;
        p_signed = q * m;
        reset = 1; 
        #10;
        reset = 0; 
        #10; 
        reset = 1; 

        @(posedge done);
        $display("Checking output values and comparing with expected results");
        if (p === p_signed) begin
            $display("Test Passed: Output p is equal to expected result");
        end else begin
            $display("Test Failed: Output p is " , p, " Expected: ", p_signed);
        end

        // test negative multiplier, positive multiplicand
        q = -4;
        m = 3;
        p_signed = q * m;
        reset = 1;
        #10;
        reset = 0;
        #10;
        reset = 1;

        @(posedge done);
        $display("Checking output values and comparing with expected results");
        if (p === p_signed) begin
            $display("Test Passed: Output p is equal to expected result");
        end else begin
            $display("Test Failed: Output p is " , p, " Expected: ", p_signed);
        end
        #15;

        // test positive multiplier, negative multiplicand
        q = 4;
        m = -7;
        p_signed = q * m;
        reset = 1;
        #5;
        reset = 0;
        #5;
        reset = 1;

        @(posedge done);
        $display("Checking output values and comparing with expected results");
        if (p === p_signed) begin
            $display("Test Passed: Output p is equal to expected result");
        end else begin
            $display("Test Failed: Output p is " , p, " Expected: ", p_signed);
        end
        #15;

        // test positive multiplier, positive multiplicand
        q = 4;
        m = 3;
        p_signed = q * m;
        reset = 0;
        #15;
        reset = 1;
        #5;

        @(posedge done);
        $display("Checking output values and comparing with expected results");
        if (p === p_signed) begin
            $display("Test Passed: Output p is equal to expected result");
        end else begin
            $display("Test Failed: Output p is " , p, " Expected: ", p_signed);
        end
        #15;

        // test zero multiplier, positive multiplicand
        q = 0;
        m = 3;
        p_signed = q * m;
        reset = 0;
        #15;
        reset = 1;
        #5;

        @(posedge done);
        $display("Checking output values and comparing with expected results");
        if (p === p_signed) begin
            $display("Test Passed: Output p is equal to expected result");
        end else begin
            $display("Test Failed: Output p is " , p, " Expected: ", p_signed);
        end
        #15;

        // test positive multiplier, zero multiplicand
        q = 4;
        m = 0;
        p_signed = q * m;
        reset = 0;
        #15;
        reset = 1;
        #5;
        
        @(posedge done);
        $display("Checking output values and comparing with expected results");
        if (p === p_signed) begin
            $display("Test Passed: Output p is equal to expected result");
        end else begin
            $display("Test Failed: Output p is " , p, " Expected: ", p_signed);
        end

        $stop; // Exit simulation
    end

    // Clock generation
    always begin
        clk = 0;
        #5;
        clk = 1;
        #5;
    end
endmodule