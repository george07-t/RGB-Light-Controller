`timescale 1ps / 1ps

module ALU_tb;
    reg [7:0] A, B;
    reg Subtract;
    wire [7:0] ALU_Out;
    wire CarryOut;

    // Instantiate the ALU
    ALU uut (
        .A(A),
        .B(B),
        .Subtract(Subtract),
        .ALU_Out(ALU_Out),
        .CarryOut(CarryOut)
    );

    initial begin
        // Test case: Addition
        A = 8'b00001100; B = 8'b00000010; Subtract = 0; #10;
        $display("A = %b, B = %b, Subtract = %b, ALU_Out = %b, CarryOut = %b", A, B, Subtract, ALU_Out, CarryOut);

        // Test case: Subtraction
        A = 8'b00001100; B = 8'b00000010; Subtract = 1; #10;
        $display("A = %b, B = %b, Subtract = %b, ALU_Out = %b, CarryOut = %b", A, B, Subtract, ALU_Out, CarryOut);


        $stop;
    end
endmodule
