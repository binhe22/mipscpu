`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   13:42:05 12/25/2013
// Design Name:   mipscpu
// Module Name:   C:/fpga/Simple_MIPS/mipscpu_test.v
// Project Name:  Simple_MIPS
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: mipscpu
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module mipscpu_test;

	// Inputs
	reg clk;
	reg rstn;
	reg key_ok;
	reg [0:0] data_1;
	reg [0:0] data_2;
	reg [0:0] sel;

	// Outputs
	wire [3:0] timer;
	wire alu_zero_flag;
	wire [0:0] alu_out;

	// Instantiate the Unit Under Test (UUT)
	mipscpu uut (
		.clk(clk), 
		.rstn(rstn), 
		.key_ok(key_ok), 
		.timer(timer), 
		.alu_zero_flag(alu_zero_flag), 
		.alu_out(alu_out), 
		.data_1(data_1), 
		.data_2(data_2), 
		.sel(sel)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		rstn = 0;
		key_ok = 0;
		data_1 = 0;
		data_2 = 0;
		sel = 0;

		// Wait 100 ns for global reset to finish
		#20 rstn = 1'b1;
        
		// Add stimulus here
	end
	
	always
			#20 clk = ~clk;
      
endmodule



