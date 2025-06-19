
`timescale 1ps / 1ps

module pwmgen (
    input clk,              // 100 MHz clock input
    input [7:0] RED,        // 8-bit RED value (0-255)
    output PWM_OUT          // PWM signal for RED LED
);
    reg [3:0] DUTY_CYCLE = 0;       // Duty cycle (0-9 for 0%-100%)
    reg [3:0] counter_PWM = 0;      // Counter for 10 MHz PWM generation

    // Map RED value to DUTY_CYCLE (0-9)
    always @(posedge clk) begin
        DUTY_CYCLE <= (RED * 10) / 255;  // Scale RED to 0-9 for 10% steps
    end

    // Generate 10 MHz PWM signal
    always @(posedge clk) begin
        counter_PWM <= counter_PWM + 1;
        if (counter_PWM >= 9)
            counter_PWM <= 0;
    end

    assign PWM_OUT = (counter_PWM < DUTY_CYCLE) ? 1 : 0;
endmodule
