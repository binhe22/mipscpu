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
module pc (pc_counter, data_in, load_pc, offset, branch, clk, rst);

	parameter word_size = 16;
	parameter mem_size = 8;
	parameter offset_size = 4;
	output [word_size-1: 0] pc_counter;
	input [offset_size-1: 0] offset;
	input [mem_size-1: 0] branch;
	input [word_size-1: 0] data_in;
	input load_pc;
	input clk, rst;

	reg 	[word_size-1: 0]	pc_counter;

	always @ (posedge clk or negedge rst)
		if (rst == 0) pc_counter <= 0; 
		else if (load_pc) pc_counter <= data_in; 
		else if  (offset) pc_counter <= pc_counter + offset;
		else if (branch) pc_counter <= branch;
endmodule