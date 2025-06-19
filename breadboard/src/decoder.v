//-----------------------------------------------------------------------------
//
// Title       : decoder
// Design      : breadboard
// Author      : george07
// Company     : KUET
//
//-----------------------------------------------------------------------------
//
// File        : G:/CSE(4-2)/CSE 4224 DSD LAB/RGB_Controller/breadboard/src/decoder.v
// Generated   : Mon Jan 13 21:41:36 2025
// From        : Interface description file
// By          : ItfToHdl ver. 1.0
//
//-----------------------------------------------------------------------------
//
// Description : 
//
//-----------------------------------------------------------------------------

`timescale 1ps / 1ps

//{{ Section below this comment is automatically maintained
//    and may be overwritten
//{module {decoder}}

module decoder ( q ,t );

input [3:0] q;
wire [3:0] q;
output [10:0] t;
reg [10:0] t;

//}} End of automatically maintained section

	assign t[0]=(~q[0])*(~q[1])*(~q[2])*(~q[3]);
	assign t[1]=(q[0])*(~q[1])*(~q[2])*(~q[3]);
	assign t[2]=(~q[0])*(q[1])*(~q[2])*(~q[3]);
	assign t[3]=(q[0])*(q[1])*(~q[2])*(~q[3]);
	assign t[4]=(~q[0])*(~q[1])*(q[2])*(~q[3]);
	assign t[5]=(q[0])*(~q[1])*(q[2])*(~q[3]);
	assign t[6]=(~q[0])*(q[1])*(q[2])*(~q[3]);
	assign t[7]=(q[0])*(q[1])*(q[2])*(~q[3]);
	assign t[8]=(~q[0])*(~q[1])*(~q[2])*(q[3]);
	assign t[9]=(q[0])*(~q[1])*(~q[2])*(q[3]);

// Enter your statements here //

endmodule
