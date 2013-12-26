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
module pc (pc_counter, data_in, load_pc, offset, timer, rst);
	//when increase pc, simply set offset 1 and set data_in 1
	//when jump to a branch, set load_pc 1 and set data_in the pc value
	
	output [`WORD_SIZE-1:0] pc_counter;
	input offset;
	input [`WORD_SIZE-1:0] data_in;
	input load_pc;
	input rst;
	input [`TIMER_SIZE-1:0] timer;
	
	reg [`WORD_SIZE-1:0]	pc_counter;
//	reg [`TIMER_SIZE-1: 0] timer;

	always @(load_pc)
		if (load_pc) pc_counter <= data_in;
	always @(rst)
		if (rst) pc_counter <= 0;
	always @(timer)
		if (offset) pc_counter <= pc_counter + data_in;
		
endmodule