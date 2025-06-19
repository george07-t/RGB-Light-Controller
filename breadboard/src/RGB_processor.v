module RGB_processor (
    input clk,s,
    input [7:0] r_in, g_in, b_in,    
    input write_enable_init,         
    output reg [7:0] r_out, g_out, b_out 
);

    reg [7:0] memory_r, memory_g, memory_b; 
    wire [7:0] alu_out_r, alu_out_g, alu_out_b; 

    // ALU instantiations for R, G, B
    ALU alu_r (
        .A(memory_r), 
        .B(8'b00001010), 
        .Subtract(s), 
        .ALU_Out(alu_out_r), 
        .CarryOut()
    );

    ALU alu_g (
        .A(memory_g), 
        .B(8'b00001010), 
        .Subtract(s), 
        .ALU_Out(alu_out_g), 
        .CarryOut()
    );

    ALU alu_b (
        .A(memory_b), 
        .B(8'b00001010), 
        .Subtract(s), 
        .ALU_Out(alu_out_b), 
        .CarryOut()
    );

    always @(posedge clk) begin
    memory_r = write_enable_init ? r_in : alu_out_r;
	memory_g = write_enable_init ? g_in : alu_out_g;
	memory_b = write_enable_init ? b_in : alu_out_b;


        // Output the updated values
        r_out <= memory_r;
        g_out <= memory_g;
        b_out <= memory_b;
    end
endmodule
