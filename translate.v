`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   15:38:48 12/26/2013
// Design Name:   top_module
// Module Name:   X:/memory-reg/memory-reg/translate_test.v
// Project Name:  memory-reg
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: top_module
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module translate_test;

	// Inputs
	reg CLK;
	reg RSTn;

	reg[15:0] IR;

	wire[15:0] DATA1_OUT;
	wire[15:0] DATA2_OUT;
	wire[15:0] DATA3_OUT;
	wire[3:0] ALU_SEL;

	// Instantiate the Unit Under Test (UUT)
	
	top_module uut (
		.CLK(CLK), 
		.RSTn(RSTn), 
		.DATA1_OUT(DATA1_OUT),
		.DATA2_OUT(DATA2_OUT),
		.DATA3_OUT(DATA3_OUT),
		.ALU_SEL(ALU_SEL),
		.IR(IR)
		
	);

	initial begin
		// Initialize Inputs
		CLK = 1;
		RSTn = 0;

		// Wait 100 ns for global reset to finish
		#100;
		RSTn = 1;
		#200 IR= 16'b1100_0000_0001_0001;
		#200 IR= 16'b1100_0001_0001_0010;
		#200 IR= 16'b1100_0010_0001_0011;
		#200 IR= 16'b1100_0011_0001_0100;
		#200 IR= 16'b1100_0100_0001_0101;
		#200 IR= 16'b0011_0000_0000_0000;
		#200 IR= 16'b0011_0001_0000_0001;
		#200 IR= 16'b0111_0000_0011_0000;
		#200 IR= 16'b1000_1000_0000_0001;
		#200 IR= 16'b0110_1100_0011_0010;
		#200 IR= 16'b1010_0001_0011_0010;
		#200 IR= 16'b1011_1111_1111_0010;
		

		


		

		// Add stimulus here

	end
    
	always begin
		#2 CLK=~CLK;
	end
	

	
endmodule

