`timescale 1ps / 1ps

module dflipflop(
    input din, 
    input clk, 
    output reg q, 
    output qBar
);
    // Initialize q to 0
    initial q = 0;

    // Sequential logic to update q on the rising edge of clk
    always @(posedge clk) begin
        q <= din; 
    end

    // Continuous assignment for qBar
    assign qBar = ~q;

endmodule
