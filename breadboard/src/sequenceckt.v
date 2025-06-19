`timescale 1ps / 1ps

module sequenceckt  (
    t,
    up, 
    down, 
    color, 
    fade, 
    preset, 
    on, 
    clk,
    q
);

    input [10:0] t;
    input up, down, on;
    input [2:0] color;
    input [1:0] fade, preset;
    input clk;
    output reg [3:0] q;  // Output register q to hold the state
    reg [3:0] d;         // Register d to calculate next-state values

    // Calculate d values based on inputs and current state t
    always @(posedge clk) begin
        d[3] = (t[3] & (fade == 2'b01)) | (t[5] & (preset == 2'b01)) | (t[5] & (preset == 2'b10));
        d[2] = (t[2] & (color == 3'b010)) | (t[2] & (color == 3'b100));
        d[1] = (t[1] & down) | (t[2] & (color == 3'b001)) | (t[6] & (fade == 2'b10));
        d[0] = (t[0] & up);
        
        // Flip-flops to store the value of d to q
        q[3] <= d[3];
        q[2] <= d[2];
        q[1] <= d[1];
        q[0] <= d[0];
        
        // Display intermediate calculations of d for debugging purposes
        $display("At time %0t:", $time);
        $display("t[3:0] = %b", t[3:0]);
        $display("d[3:0] = %b", d[3:0]);
    end

    // Optionally, you can display q values after they change
    always @(q) begin
        $display("State q[3:0] = %b", q[3:0]);
    end

endmodule
