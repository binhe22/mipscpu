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
	parameter word_size = 16;
	parameter op_size = 4;
	parameter AND 	= 4'b0101;
	parameter OR  	= 4'b0110;
	parameter ADD	= 4'b0111;
	parameter SUB	= 4'b1000;
	parameter SLT 	= 4'b1001;
	parameter mem_size = 8;
	parameter offset_size = 4;

	// Inputs
	reg clk;
	reg rstn;
	reg key_ok;
	reg [word_size-1:0] data_1;
	reg [word_size-1:0] data_2;
	reg [op_size-1:0] sel;
	
	reg offset;
	reg [word_size-1: 0] data_in;
	reg load_pc;

	// Outputs
	wire [3:0] timer;
	wire alu_zero_flag;
	wire [word_size-1:0] alu_out;
	wire [word_size-1: 0] pc_counter;

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
		.sel(sel),
		.pc_counter(pc_counter),
		.data_in(data_in),
		.load_pc(load_pc),
		.offset(offset)
	);

	initial begin
		$display($time, " << Starting the Simulation >> ");
		// Initialize Inputs
		clk = 0;
		rstn = 0;
		key_ok = 1;
		data_1 = 0;
		data_2 = 0;
		sel = 0;
		data_in = 0;
		offset = 0;
		load_pc = 0;

		
		#100 rstn = 1'b1;
		
		#200 data_in = 16'h0003;
				load_pc = 1;
				$display("load pc: %h", pc_counter);
       
		// Wait 100 ns for global reset to finish
		
		// Add stimulus here
		
		/* test for alu, pc module */
		#40000  data_1 = 16'h0004;
				data_2 = 16'h0005;
				sel = ADD;
				
				$display($time, "%h+%h=%h\n", data_1, data_2, alu_out);

		#40000	data_1 = 16'h0004;
				data_2 = 16'h0005;
				sel = SUB;
				offset = 1;
				data_in = 16'h0004;
				$display($time, "%h-%h=%h", data_1, data_2, alu_out);
		
		#40000  data_1 = 16'h0004;
				data_2 = 16'h0005;
				sel = AND;
				offset = 1;
				data_in = 16'h0001;
				$display($time, "%h AND %h=%h", data_1, data_2, alu_out);
				
		#40000  data_1 = 16'h0004;
				data_2 = 16'h0005;
				sel = OR;
				offset = 1;
				data_in = 16'h0001;
				$display($time, "%h OR %h=%h", data_1, data_2, alu_out);
			
		#40000  data_1 = 16'h0004;
				data_2 = 16'h0005;
				sel = SLT;
				offset = 1;
				data_in = 16'h0001;
				$display($time, "%h SLT %h=%h", data_1, data_2, alu_out);
		/* end test for alu, pc module */
	end
	
	always
		#20 clk = ~clk;
      
endmodule



