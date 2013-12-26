`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   18:35:45 12/26/2013
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
	reg rst;
	reg key_ok;
	reg data_1;
	reg data_2;
	reg sel;
	reg data_in;
	reg load_pc;
	reg offset;

	// Outputs
	wire alu_zero_flag;
	wire alu_out;

	// Instantiate the Unit Under Test (UUT)
	mipscpu uut (
		.clk(clk), 
		.rst(rst), 
		.key_ok(key_ok), 
		.alu_zero_flag(alu_zero_flag), 
		.alu_out(alu_out), 
		.data_1(data_1), 
		.data_2(data_2), 
		.sel(sel), 
		.data_in(data_in), 
		.load_pc(load_pc), 
		.offset(offset)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		rst = 0;
		key_ok = 0;
		data_1 = 0;
		data_2 = 0;
		sel = 0;
		data_in = 0;
		load_pc = 0;
		offset = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end
      
endmodule

