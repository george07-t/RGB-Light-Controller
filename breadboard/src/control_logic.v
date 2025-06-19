`timescale 1ps / 1ps

module control_logic (
    input wire clk,           
    input wire reset,         
    input wire on,            
    input wire [3:0] a,        
    input wire pwm,           
    input wire [7:0] mr,      
    input wire [7:0] mg,      
    input wire [7:0] mb,        
    output reg [7:0] outr,     
    output reg [7:0] outg,    
    output reg [7:0] outb     
);

    // State encoding (4 bits for 16 states)
    parameter OFF = 4'b0000;
    parameter ON = 4'b0001;
    parameter BRIGHTNESS_UP = 4'b0010;
    parameter BRIGHTNESS_DOWN = 4'b0011;
    parameter COLOR_RED = 4'b0100;
    parameter COLOR_GREEN = 4'b0101;
    parameter COLOR_BLUE = 4'b0110;
    parameter FADE_IN = 4'b0111;
    parameter FADE_OUT = 4'b1000;
    parameter BLINKING = 4'b1001;

    // Wires for the current state and next state
    reg [3:0] current_state;
    reg [3:0] next_state;

    // D Flip-Flops for state storage
    always @(posedge clk or posedge reset) begin
        if (reset)
            current_state <= OFF;  // Reset state to OFF
        else
            current_state <= next_state;
    end

    // Next-state logic based on inputs
    always @(*) begin
        next_state = current_state;

        // State transitions based on inputs
        case (current_state)
            OFF: next_state = (on) ? ON : OFF;    
            ON: next_state = (a == 4'b0011) ? BRIGHTNESS_UP : 
                             (a == 4'b0100) ? BRIGHTNESS_DOWN : 
                             (a == 4'b0101) ? COLOR_RED : 
                             (a == 4'b0110) ? COLOR_GREEN : 
                             (a == 4'b0111) ? COLOR_BLUE : 
                             (a == 4'b1000) ? FADE_IN : 
                             (a == 4'b1001) ? FADE_OUT : 
                             (a == 4'b1010) ? BLINKING : 
                             ON;  // Default stay ON

            BRIGHTNESS_UP: next_state = (a == 4'b0011) ? BRIGHTNESS_UP : ON;
            BRIGHTNESS_DOWN: next_state = (a == 4'b0100) ? BRIGHTNESS_DOWN : ON;
            COLOR_RED: next_state = (a == 4'b0101) ? COLOR_RED : ON;
            COLOR_GREEN: next_state = (a == 4'b0110) ? COLOR_GREEN : ON;
            COLOR_BLUE: next_state = (a == 4'b0111) ? COLOR_BLUE : ON;
            FADE_IN: next_state = (a == 4'b1000) ? FADE_IN : ON;
            FADE_OUT: next_state = (a == 4'b1001) ? FADE_OUT : ON;
            BLINKING: next_state = (a == 4'b1010) ? BLINKING : ON;
            default: next_state = OFF; // Default to OFF state
        endcase
    end

    // Output logic based on state
    always @(*) begin
        // Default outputs (initialize to 0)
        outr = 0;
        outg = 0;
        outb = 0;

        // Set outputs based on the state
        case (current_state)
            BRIGHTNESS_UP: begin
                outr = (outr < 8'hFF) ? outr + 1 : outr;
                outg = (outg < 8'hFF) ? outg + 1 : outg;
                outb = (outb < 8'hFF) ? outb + 1 : outb;
            end
            BRIGHTNESS_DOWN: begin
                outr = (outr > 8'h00) ? outr - 1 : outr;
                outg = (outg > 8'h00) ? outg - 1 : outg;
                outb = (outb > 8'h00) ? outb - 1 : outb;
            end
            COLOR_RED: begin
                outr = mr;  // Set red intensity
                outg = 8'h00; // Zero for green
                outb = 8'h00; // Zero for blue
            end
            COLOR_GREEN: begin
                outr = 8'h00; // Zero for red
                outg = mg;  // Set green intensity
                outb = 8'h00; // Zero for blue
            end
            COLOR_BLUE: begin
                outr = 8'h00; // Zero for red
                outg = 8'h00; // Zero for green
                outb = mb;  // Set blue intensity
            end
            FADE_IN: begin
                outr = (outr < 8'hFF) ? outr + 1 : outr;
                outg = (outg < 8'hFF) ? outg + 1 : outg;
                outb = (outb < 8'hFF) ? outb + 1 : outb;
            end
            FADE_OUT: begin
                outr = (outr > 8'h00) ? outr - 1 : outr;
                outg = (outg > 8'h00) ? outg - 1 : outg;
                outb = (outb > 8'h00) ? outb - 1 : outb;
            end
            BLINKING: begin
                outr = pwm ? 8'hFF : 8'h00;
                outg = pwm ? 8'hFF : 8'h00;
                outb = pwm ? 8'hFF : 8'h00;
            end
            default: begin
                outr = 8'h00;
                outg = 8'h00;
                outb = 8'h00;
            end
        endcase
    end
endmodule
