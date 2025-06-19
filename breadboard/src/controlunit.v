`timescale 1ps / 1ps

module controlunit (
    input up, 
    input down, 
    input [2:0] color,
    input [1:0] fade,
    input preset, 
    input on, 
    input clk,
    input [9:0] t,            // Current state signal from the decoder
    output reg [7:0] r,       // Red color value (0-255)
    output reg [7:0] g,       // Green color value (0-255)
    output reg [7:0] b        // Blue color value (0-255)
);
    reg [9:0] tout;           // Holds the decoded active state
    wire [3:0] q;             // Encoded state signal (4-bit binary)

    // Instantiate the sequential circuit (sequenceckt)
    sequenceckt sc (
        .t(t),
        .up(up),
        .down(down),
        .color(color),
        .fade(fade),
        .preset(preset),
        .on(on),
        .clk(clk),
        .q(q)
    );

    // Instantiate the decoder (dec)
    decoder dec (
        .q(q),
        .t(tout)
    );

    // Internal brightness level and default RGB values
    reg [7:0] brightness_level;

    // ALU outputs
    wire [7:0] alu_r_out, alu_g_out, alu_b_out;

    // Instantiate ALUs for R, G, and B
    ALU alu_r (
        .A(r),
        .B(brightness_level),
        .Subtract(0), // 0 for addition, 1 for subtraction
        .ALU_Out(alu_r_out),
        .CarryOut()   // Unused in this case
    );

    ALU alu_g (
        .A(g),
        .B(brightness_level),
        .Subtract(0),
        .ALU_Out(alu_g_out),
        .CarryOut()
    );

    ALU alu_b (
        .A(b),
        .B(brightness_level),
        .Subtract(0),
        .ALU_Out(alu_b_out),
        .CarryOut()
    );

    // Initialize outputs
    initial begin
        r = 8'b00000000;
        g = 8'b00000000;
        b = 8'b00000000;
        brightness_level = 8'b00001010; // Default brightness (mid-level)
    end

    // State-dependent behavior
    always @(posedge clk) begin
        case (tout)
            10'b0000000001: begin // Brightness_Up (0001)
                brightness_level <= brightness_level + 8'd5;
                r <= alu_r_out;
                g <= alu_g_out;
                b <= alu_b_out;
                $display("Brightness UP: R = %d, G = %d, B = %d", r, g, b);
            end

            10'b0000000010: begin // Brightness_Down (0010)
                brightness_level <= brightness_level - 8'd5;
                r <= alu_r_out;
                g <= alu_g_out;
                b <= alu_b_out;
                $display("Brightness Down: R = %d, G = %d, B = %d", r, g, b);
            end

            10'b0000100000: begin // Fade_In (0110)
                integer i; 	
                brightness_level <= 8'b00000000;
                for (i = 0; i <= 120; i = i + 5) begin
                    #1; // Simulated delay
                    r <= i;
                    g <= i;
                    b <= i;
                    $display("Fade IN: Brightness = %d, R = %d, G = %d, B = %d", i, r, g, b);
                end
            end

            10'b0001000000: begin // Fade_Out (0111)
                integer i; 
                brightness_level <= 8'd120; // Start brightness at 120
                for (i = 120; i >= 0; i = i - 5) begin
                    #1; // Simulated delay
                    r <= i;
                    g <= i;
                    b <= i;
                    $display("Fade OUT: Brightness = %d, R = %d, G = %d, B = %d", i, r, g, b);
                end
            end

            10'b0010000000: begin // Preset_1 (1000)
                integer i; 
                brightness_level <= 8'd128;
                repeat (5) begin
                    #1; // Delay for simulation purposes

                    // Turn RGB values ON
                    r <= 8'd128; // Moderate red
                    g <= 8'd64;  // Low green
                    b <= 8'd0;   // No blue
                    $display("Preset 1 ON: R = %d, G = %d, B = %d", r, g, b);

                    #1; // Delay for simulation purposes

                    // Turn RGB values OFF
                    r <= 8'd0;
                    g <= 8'd0;
                    b <= 8'd0;
                    $display("Preset 1 OFF: R = %d, G = %d, B = %d", r, g, b);
                end
            end

            default: begin
                // Default state: Turn off the light
                r <= 8'd0;
                g <= 8'd0;
                b <= 8'd0;
                $display("Default State: Light OFF");
            end
        endcase

        // Debug output
        $display("At time %0t: tout = %b, Brightness = %d, R = %d, G = %d, B = %d", 
                 $time, tout, brightness_level, r, g, b);
    end
endmodule
