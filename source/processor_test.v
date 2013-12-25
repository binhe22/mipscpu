`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   10:51:31 12/25/2013
// Design Name:   top_module
// Module Name:   C:/fpga/Simple_MIPS/processor_test.v
// Project Name:  Simple_MIPS
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

module processor_test;

	// Inputs
	reg CLK;
	reg RSTn;
	reg KEY_OK;

	// Outputs
	wire [3:0] LED_Out;

	// Instantiate the Unit Under Test (UUT)
	top_module uut (
		.CLK(CLK), 
		.RSTn(RSTn), 
		.LED_Out(LED_Out), 
		.KEY_OK(KEY_OK)
	);

	initial begin
		// Initialize Inputs
		$display($time, " << Starting the Simulation >>");
		CLK = 1'b0;
		RSTn = 1'b0;
		KEY_OK = 1'b1;

		// Wait 100 ns for global reset to finish
//		#100;
		#20 RSTn = 1'b1;
        
		// Add stimulus here
	end
	
	always
			#20 CLK = ~CLK;
			
endmodule

