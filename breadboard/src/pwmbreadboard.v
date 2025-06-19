`timescale 1ps / 1ps

module pwmbreadboard;
    reg clk;                 // Clock signal
    reg [7:0] RED;           // 8-bit RED input value
    wire PWM_OUT;            // PWM output signal
    reg [7:0] increment_value; // Increment value (as an 8-bit binary number)
    reg Subtract;            // Control signal for subtraction (decrement)
    wire [7:0] alu_out;      // ALU output
    wire carry_out;          // ALU carry out

    // Instantiate the PWM generator
    pwmgen pwm_gen(
        .clk(clk),
        .RED(RED),
        .PWM_OUT(PWM_OUT)
    );

    // Instantiate the ALU
    ALU alu(
        .A(RED),             // Input A: current RED value
        .B(increment_value), // Input B: increment value
        .Subtract(Subtract), // Perform subtraction (Subtract = 1 for subtraction, 0 for addition)
        .ALU_Out(alu_out),   // ALU result
        .CarryOut(carry_out) // Carry Out from ALU
    );

    // Generate a 100 MHz clock
    initial begin
        clk = 0;
        forever #10 clk = ~clk;  // Toggle clock every 5 ps for 100 MHz
    end

    // Testbench logic to increment or decrement RED
    initial begin
        RED = 8'b01100100;       // Initial RED value (100 in decimal)
        increment_value = 8'b00001010; // Increment by 10 (binary)

        $display("Initial RED value: %d", RED);

        // Increment RED by 10
        $display("Incrementing RED by 10");
        Subtract = 0;  // Set Subtract signal to 0 for addition
        #10;            // Wait for 10 time units
        RED = alu_out;  // Perform addition through ALU

        // Display current values after increment
        $display("Time: %0t | RED: %d | Increment: %d | PWM_OUT: %b", $time, RED, increment_value, PWM_OUT);
        $display("Updated RED value after increment: %d", RED);

        // Now, decrement RED by 10
        $display("Decrementing RED by 10");
        Subtract = 1;  // Set Subtract signal to 1 for subtraction	
        #10;            // Wait for 10 time units
        RED = alu_out;  // Perform subtraction through ALU

        // If RED goes below 0, clamp it to 0
        if (RED < 8'b00000000)
            RED = 8'b00000000;

        // Display current values after decrement
        $display("Time: %0t | RED: %d | Decrement: %d | PWM_OUT: %b", $time, RED, increment_value, PWM_OUT);
        $display("Updated RED value after decrement: %d", RED);

        $stop;  // Stop the simulation
    end
endmodule
