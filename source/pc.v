`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:11:21 12/25/2013 
// Design Name: 
// Module Name:    pc 
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
module pc (pc_counter, data_in, load_pc, offset, clk, rst);
	//when increase pc, simply set offset 1 and set data_in 1
	//when jump to a branch, set load_pc 1 and set data_in the pc value
	parameter word_size = 16;
	parameter mem_size = 8;
	parameter offset_size = 4;
	output [word_size-1: 0] pc_counter;
	input offset;
	input [word_size-1: 0] data_in;
	input load_pc;
	input clk, rst;
	
	reg 	[word_size-1: 0]	pc_counter;

	always @(load_pc)
		if (load_pc) pc_counter <= data_in;
	always @(rst)
		if (rst) pc_counter <= 0;
	always @(offset)
		if (offset) pc_counter <= pc_counter + data_in;
		
endmodule