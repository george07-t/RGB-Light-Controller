
`timescale 1ps / 1ps



module memoryunit(
    input [7:0] r_in, g_in, b_in,   
    input write_enable_r,           
    input write_enable_g,           
    input write_enable_b,           
    input clk,                     
    output [7:0] r_out, g_out, b_out 
);

    // Instantiate memory module for R (Red)
    memory8bit memory_r (
        .data_in(r_in),
        .write_enable(write_enable_r),
        .clk(clk),
        .data_out(r_out)
    );

    // Instantiate memory module for G (Green)
    memory8bit memory_g (
        .data_in(g_in),
        .write_enable(write_enable_g),
        .clk(clk),
        .data_out(g_out)
    );

    // Instantiate memory module for B (Blue)
    memory8bit memory_b (
        .data_in(b_in),
        .write_enable(write_enable_b),
        .clk(clk),
        .data_out(b_out)
    );

endmodule

