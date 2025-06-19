`timescale 1ps / 1ps

module ALU (
    input [7:0] A, B,        
    input Subtract,           
    output [7:0] ALU_Out,     
    output CarryOut           
);
    wire [7:0] add_result, sub_result;  
    wire add_cout, sub_bout;            
    wire [7:0] result_temp;             

    // Instantiate 8-bit adder
    addition8bit adder (
        .A(A), 
        .B(B), 
        .Cin(1'b0),           // No initial carry-in
        .Sum(add_result),     // Adder output
        .Cout(add_cout)       // Adder carry-out
    );

    // Instantiate 8-bit subtractor
    subtraction8bit subtractor (
        .A(A),
        .B(B),
        .Cin(1'b1),           // Set Cin to 1 for two's complement
        .Diff(sub_result),    // Subtractor output
        .Bout(sub_bout)       // Subtractor borrow-out
    );

    // Multiplexer for result selection based on Subtract control
    assign result_temp = (Subtract == 1'b0) ? add_result : sub_result;

    // Carry Out Flag
    assign CarryOut = (Subtract == 1'b0) ? add_cout : sub_bout;

    // Assign the final output
    assign ALU_Out = result_temp;

endmodule
