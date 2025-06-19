
`timescale 1ps / 1ps


//memory

module memory8bit (
    input [7:0] data_in,       
    input write_enable,        
    input clk,                
    output [7:0] data_out      
);
    // Intermediate wires for D flip-flop outputs
    wire [7:0] q;
    wire [7:0] qBar;

    // Logic for write enable gating (hardware-based)
    wire [7:0] din;
    assign din[0] = (write_enable & data_in[0]) | (~write_enable & q[0]);
    assign din[1] = (write_enable & data_in[1]) | (~write_enable & q[1]);
    assign din[2] = (write_enable & data_in[2]) | (~write_enable & q[2]);
    assign din[3] = (write_enable & data_in[3]) | (~write_enable & q[3]);
    assign din[4] = (write_enable & data_in[4]) | (~write_enable & q[4]);
    assign din[5] = (write_enable & data_in[5]) | (~write_enable & q[5]);
    assign din[6] = (write_enable & data_in[6]) | (~write_enable & q[6]);
    assign din[7] = (write_enable & data_in[7]) | (~write_enable & q[7]);

    // Instantiate D flip-flops for each bit
    dflipflop dff0 (
        .din(din[0]),
        .clk(clk),
        .q(q[0]),
        .qBar(qBar[0])
    );

    dflipflop dff1 (
        .din(din[1]),
        .clk(clk),
        .q(q[1]),
        .qBar(qBar[1])
    );

    dflipflop dff2 (
        .din(din[2]),
        .clk(clk),
        .q(q[2]),
        .qBar(qBar[2])
    );

    dflipflop dff3 (
        .din(din[3]),
        .clk(clk),
        .q(q[3]),
        .qBar(qBar[3])
    );

    dflipflop dff4 (
        .din(din[4]),
        .clk(clk),
        .q(q[4]),
        .qBar(qBar[4])
    );

    dflipflop dff5 (
        .din(din[5]),
        .clk(clk),
        .q(q[5]),
        .qBar(qBar[5])
    );

    dflipflop dff6 (
        .din(din[6]),
        .clk(clk),
        .q(q[6]),
        .qBar(qBar[6])
    );

    dflipflop dff7 (
        .din(din[7]),
        .clk(clk),
        .q(q[7]),
        .qBar(qBar[7])
    );

    // Combine D flip-flop outputs into data_out
    assign data_out = q;

endmodule
