`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   08:25:19 12/26/2013
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
	reg [`WORD_SIZE-1:0] data_1;
	reg [`WORD_SIZE-1:0] data_2;
	reg [`OP_SIZE-1:0] sel;
	reg [`WORD_SIZE-1: 0] data_in;
	reg load_pc;
	reg offset;
	reg reg_w;
	reg reg_on;
	reg [`WORD_SIZE-1:0] reg_addr;
	reg [`WORD_SIZE-1:0] reg_data_in;

	// Outputs
	wire [`TIMER_SIZE:0] timer;
	wire alu_zero_flag;
	wire [`WORD_SIZE-1:0] alu_out;
	wire [`WORD_SIZE-1:0] pc_counter;
	wire [`WORD_SIZE-1:0] reg_data_out;

	// Instantiate the Unit Under Test (UUT)
	mipscpu uut (
		.clk(clk), 
		.rst(rst), 
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
		.offset(offset), 
		.reg_w(reg_w), 
		.reg_on(reg_on), 
		.reg_addr(reg_addr), 
		.reg_data_in(reg_data_in), 
		.reg_data_out(reg_data_out)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		rst = 0;
		key_ok = 1;
		data_1 = 0;
		data_2 = 0;
		sel = 0;
		data_in = 0;
		load_pc = 0;
		offset = 0;
		reg_w = 0;
		reg_on = 0;
		reg_addr = 0;
		reg_data_in = 0;

		// Wait 100 ns for global reset to finish
		#100;
		#100 rst = 1'b1;
		
		#200 data_in = 16'h0003;
				load_pc = 1;
				$display("load pc: %h", pc_counter);
        
		// Add stimulus here

	end
	
	always
		#20 clk = ~clk;
	
	always @(timer)
		case (timer)
			`CYCLE3:
				begin 
					offset <= 1;
					data_in <= 16'h0001;
				end
			`CYCLE4:
				begin
					data_1 = 16'h0004;
					data_2 = 16'h0005;
					sel = `ADD;
					$display($time, "%h+%h=%h\n", data_1, data_2, alu_out);
				end
			default:
				begin
					offset <= 0;
					data_in <= 16'h0000;
				end
		endcase
      
endmodule

