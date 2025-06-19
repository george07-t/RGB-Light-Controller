`timescale 1ps / 1ps

module membreadboard;
    // Testbench signals
    reg [7:0] r_in, g_in, b_in;   // Input data for R, G, B
    reg write_enable_r, write_enable_g, write_enable_b; // Write enable signals
    reg clk;                      // Clock signal
    wire [7:0] r_out, g_out, b_out; // Output data for R, G, B

    // Instantiate the memory_unit
    memoryunit uut (
        .r_in(r_in),
        .g_in(g_in),
        .b_in(b_in),
        .write_enable_r(write_enable_r),
        .write_enable_g(write_enable_g),
        .write_enable_b(write_enable_b),
        .clk(clk),
        .r_out(r_out),
        .g_out(g_out),
        .b_out(b_out)
    );

    // Clock generation (50% duty cycle)
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // 10ps clock period
    end

    // Test sequence
    initial begin
        // Initialize signals
        r_in = 8'b00000000;
        g_in = 8'b00000000;
        b_in = 8'b00000000;
        write_enable_r = 0;
        write_enable_g = 0;
        write_enable_b = 0;

        // Monitor the output
        $monitor("Time: %0t | R: %b | G: %b | B: %b", $time, r_out, g_out, b_out);

        // Write values to R, G, and B
        #10 r_in = 8'b11110000; write_enable_r = 1;
        #10 write_enable_r = 0;

        #10 g_in = 8'b10101010; write_enable_g = 1;
        #10 write_enable_g = 0;

        #10 b_in = 8'b11001100; write_enable_b = 1;
        #10 write_enable_b = 0;

        // Change inputs but without enabling write (should not affect outputs)
        #10 r_in = 8'b00001111; g_in = 8'b01010101; b_in = 8'b00110011;

        // Write new values to R, G, and B
        #10 r_in = 8'b10000001; write_enable_r = 1;
        #10 write_enable_r = 0;

        #10 g_in = 8'b01000010; write_enable_g = 1;
        #10 write_enable_g = 0;

        #10 b_in = 8'b00100011; write_enable_b = 1;
        #10 write_enable_b = 0;

        // Finish simulation
        #20 $finish;
    end
endmodule
