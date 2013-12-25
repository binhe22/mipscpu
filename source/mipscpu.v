`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:28:12 12/25/2013 
// Design Name: 
// Module Name:    mipscpu 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module mipscpu(clk, rstn, key_ok, timer, alu_zero_flag, alu_out, data_1, data_2, sel, pc_counter, data_in, load_pc, offset, branch);
	parameter word_size = 16;
	parameter op_size = 4;
	parameter mem_size = 8;
	parameter offset_size = 4;

	//clk_divider
	input clk;
	input rstn;
	input key_ok;
	output [3:0] timer;
	
	//alu 
	output 			alu_zero_flag;
	output 	[word_size-1: 0] 	alu_out;
	input 	[word_size-1: 0] 	data_1, data_2;
	input 	[op_size-1: 0] 	sel;
	
	//pc
	output [word_size-1: 0] pc_counter;
	input [offset_size-1: 0] offset;
	input [mem_size-1: 0] branch;
	input [word_size-1: 0] data_in;
	input load_pc;
	input clk, rst;
	 
	clk_divider M0_CLK_DIVIDER ( .CLK(clk), .RSTn(rstn), .LED_Out(timer), .KEY_OK(key_ok) );
	alu M1_ALU ( .alu_zero_flag(alu_zero_flag), .alu_out(alu_out), .data_1(data_1), .data_2(data_2), .sel(sel) );
	pc M2_PC ( .pc_counter(pc_counter), .data_in(data_in), .load_pc(load_pc), .offset(offset), .branch(branch), .clk(clk), .rst(rst) );
endmodule
