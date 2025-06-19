`timescale 1ps / 1ps

module brad_board;

    // Signal declarations
    reg up;
    reg down;
    reg [2:0] color;
    reg [1:0] fade;
    reg preset;
    reg on;
    reg clk;               // Clock signal
    reg [9:0] t;           // Current state signal
    wire [7:0] r, g, b;    // RGB outputs

    // Instantiate the controlunit
    controlunit cu (
        .up(up),
        .down(down),
        .color(color),
        .fade(fade),
        .preset(preset),
        .on(on),
        .clk(clk),
        .t(t),
        .r(r),
        .g(g),
        .b(b)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // Toggle clock every 5 time units (clock period = 10)
    end

    // Initialization and testing
    initial begin
        // Initialize signals
        up = 0;
        down = 0;
        color = 3'b000; // Default color
        fade = 2'b00;   // No fade
        preset = 0;
        on = 0;
        t = 10'b0000000001; // Initial state

        // Simulation scenario
        #10 on = 1; // Turn on the control unit
        $display("At time %0t: ON signal activated", $time);

        #10 up = 1; // Brightness Up
        $display("At time %0t: Brightness Up initiated", $time);

        #20 up = 0;
        $display("At time %0t: Brightness Up completed", $time);

        #10 down = 1; // Brightness Down
        $display("At time %0t: Brightness Down initiated", $time);

        #20 down = 0;
        $display("At time %0t: Brightness Down completed", $time);

        #10 color = 3'b101; // Change color to Red-Green
        $display("At time %0t: Color set to %b", $time, color);

        #10 fade = 2'b01; // Fade In
        $display("At time %0t: Fade In initiated", $time);

        #30 fade = 2'b10; // Fade Out
        $display("At time %0t: Fade Out initiated", $time);

        #50 preset = 1; // Activate Preset
        $display("At time %0t: Preset activated", $time);

        #30 preset = 0;
        $display("At time %0t: Preset deactivated", $time);

        #20 on = 0; // Turn off the control unit
        $display("At time %0t: ON signal deactivated", $time);

        #10 $finish; // End simulation
    end

    // Display output values at every positive clock edge
    always @(posedge clk) begin
        $display("At time %0t: t = %b, R = %d, G = %d, B = %d", $time, t, r, g, b);
    end

endmodule
