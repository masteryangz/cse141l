module PC_testbench #(parameter D=12);
    logic clock, start, branch, taken;
    logic[D-1:0] program_counter, next_program_counter, start_address, target;

    //initiat a PC
    PC PC1(
        .clk(clock),
        .prog_ctr_in(next_program_counter),
        .prog_ctr_out(program_counter)
    );
    nextPC nextPC1(
        .start(start),
        .branch(branch),
        .taken(taken),
        .start_address(start_address),
        .target(target),
        .prog_ctr_out(program_counter),
        .prog_ctr_in(next_program_counter)
    );

    initial begin
        // Initialize Inputs
        clock = 0;
        start = 1;
        branch = 0;
        taken = 0;
        target = 16;
        start_address = 0;
        program_counter = 0;

        #10;
        //test normal incrementing
        start = 0;
        #30;

        //test only branch (suppose nothing happen)
        branch = 1;
        #10;

        //test both branch and taken, suppose at 16
        taken = 1;
        #10;

        //reset increment target to 2
        target = 2;
        #10;

        //test only test,(suppose nothing happen)
        branch = 0;
        #10;

        //test normal incrementing
        taken = 0;
        #30;

        //restart to address 128
        start = 1;
        start_address = 128;
        #10

        //back to normal
        start = 0;
        #10
        $stop;
        
    end

    always@(clock) begin
        #10ns clock <= !clock;
    end


    initial begin
        $monitor(" time=%0t, clk=%b  pc=%d",$time, start, clock, next_program_counter);
    end


endmodule