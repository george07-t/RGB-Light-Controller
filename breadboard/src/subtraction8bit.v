`timescale 1ps / 1ps

module subtraction8bit (
    input [7:0] A,     
    input [7:0] B,      
    input Cin,          
    output [7:0] Diff,  
    output Bout        
);

    // Internal wire to hold carry-out for each Full Adder
    wire C1, C2, C3, C4, C5, C6, C7, C8;

    // Ensure the subtraction is properly implemented as A - B = A + (~B) + 1
    // Two's complement of B: Invert B and add 1 (Cin = 1 for initial borrow in)
    fulladder FA0 (
        .A(A[0]), .B(~B[0]), .Cin(Cin),   // First Full Adder
        .Sum(Diff[0]), .Cout(C1)
    );

    fulladder FA1 (
        .A(A[1]), .B(~B[1]), .Cin(C1),    // Second Full Adder
        .Sum(Diff[1]), .Cout(C2)
    );

    fulladder FA2 (
        .A(A[2]), .B(~B[2]), .Cin(C2),    // Third Full Adder
        .Sum(Diff[2]), .Cout(C3)
    );

    fulladder FA3 (
        .A(A[3]), .B(~B[3]), .Cin(C3),    // Fourth Full Adder
        .Sum(Diff[3]), .Cout(C4)
    );

    fulladder FA4 (
        .A(A[4]), .B(~B[4]), .Cin(C4),    // Fifth Full Adder
        .Sum(Diff[4]), .Cout(C5)
    );

    fulladder FA5 (
        .A(A[5]), .B(~B[5]), .Cin(C5),    // Sixth Full Adder
        .Sum(Diff[5]), .Cout(C6)
    );

    fulladder FA6 (
        .A(A[6]), .B(~B[6]), .Cin(C6),    // Seventh Full Adder
        .Sum(Diff[6]), .Cout(C7)
    );

    fulladder FA7 (
        .A(A[7]), .B(~B[7]), .Cin(C7),    // Eighth Full Adder
        .Sum(Diff[7]), .Cout(C8)
    );

    // Final borrow-out is the carry-out of the MSB addition
    assign Bout = ~C8;

endmodule
