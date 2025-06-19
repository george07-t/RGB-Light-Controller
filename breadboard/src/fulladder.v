
`timescale 1ps / 1ps


//fulladder

module fulladder (
    input A,        
    input B,        
    input Cin,      
    output Sum,     
    output Cout     
);
    
    // Internal signals for intermediate calculations
    wire sum_ab;    // Sum of A and B (without Cin)
    
    // Sum of A and B using XOR
    assign sum_ab = A ^ B;
    
    // Sum output is the XOR of sum_ab and Cin
    assign Sum = sum_ab ^ Cin;
    
    // Carry-out is generated using the carry logic
    assign Cout = (A & B) | (Cin & sum_ab);
    
endmodule
