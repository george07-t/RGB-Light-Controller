module rgb_processor_tb;
    reg clk, s;
    reg [7:0] r_in, g_in, b_in; 
    reg write_enable_init;
    wire [7:0] r_out, g_out, b_out; 

    // Instantiate the RGB processor
    RGB_processor uut (
        .clk(clk),
        .r_in(r_in),
        .g_in(g_in),
        .b_in(b_in),
        .write_enable_init(write_enable_init),
        .r_out(r_out),
        .g_out(g_out),
        .b_out(b_out),
        .s(s)
    );

    // Clock generation (50% duty cycle)
    initial begin
        clk = 0;											 
        forever #5 clk = ~clk;
    end

    // Test sequence
    initial begin
        // Initialize inputs
      r_in = 8'b00000000; 
        g_in = 8'b00000000; 
        b_in = 8'b00000000;
        write_enable_init = 1;
        s = 0; // Addition mode

        #10; // Wait for the write to take effect

        // Disable initial write
        write_enable_init = 0;

        // Monitor the RGB outputs in binary
        $monitor("Time: %0t | R_Out: %b | G_Out: %b | B_Out: %b", $time, r_out, g_out, b_out);

        // Allow addition to complete
        #20;

        // Switch to subtraction mode
        s = 1;

        // Allow subtraction to complete
        #20;

        // Finish simulation
        $finish;
    end
endmodule
