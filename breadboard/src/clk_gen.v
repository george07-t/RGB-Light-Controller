//-----------------------------------------------------------------------------
//
// Title       : clk_gen
// Design      : breadboard
// Author      : george07
// Company     : KUET
//
//-----------------------------------------------------------------------------
//
// File        : G:/CSE(4-2)/CSE 4224 DSD LAB/RGB_Controller/breadboard/src/clk_gen.v
// Generated   : Mon Jan 13 21:37:58 2025
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
//{module {clk_gen}}

module clk_gen (sc ,clk);
				input sc;
reg sc;
output clk;
reg clk;   

always @(posedge sc or negedge sc)
begin
	while (sc)
		begin
			#1 clk=0;
			#1 clk=1;
		end	 
end
endmodule
