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
	reg [15:0] IR;
	reg DCLK;

	// Instantiate the Unit Under Test (UUT)
	top_module uut (
		.CLK(CLK), 
		.RSTn(RSTn), 
		.IR(IR),
		.DCLK(DCLK)
	);

	initial begin
		// Initialize Inputs
		CLK = 0;
		DCLK = 0; 
		RSTn = 0;
		IR = 0;

		// Wait 100 ns for global reset to finish
		#100;
		RSTn=1;
		#10 IR=16'b1100_0001_1111_1111;		
        
		// Add stimulus here

	end
    
	always begin
		#2 CLK=~CLK;
	end
	
	always begin
		#20 DCLK=~DCLK;
	end
	
endmodule

