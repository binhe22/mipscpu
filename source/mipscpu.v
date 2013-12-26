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
module mipscpu(clk, rst, key_ok, timer, alu_zero_flag, alu_out, data_1, data_2, sel, pc_counter, data_in, load_pc, offset,
					reg_w, reg_on, reg_addr, reg_data_in, reg_data_out);
	
	//clk_divider
	input clk;
	input rst;
	input key_ok;
	output [`TIMER_SIZE-1: 0] timer;
	
	//alu 
	output 			alu_zero_flag;
	output 	[`WORD_SIZE-1: 0] 	alu_out;
	input 	[`WORD_SIZE-1: 0] 	data_1, data_2;
	input 	[`OP_SIZE-1: 0] 	sel;
	
	//pc
	output [`WORD_SIZE-1: 0] pc_counter;
	input offset;
	input [`WORD_SIZE-1: 0] data_in;
	input load_pc;
	
	//register
	output [`WORD_SIZE-1: 0] reg_data_out;
	input [`WORD_SIZE-1: 0] reg_data_in;
	input [`WORD_SIZE-1: 0] reg_addr;
	input reg_w, reg_on;
	 
	clk_divider M0_CLK_DIVIDER ( .CLK(clk), .RSTn(rst), .LED_Out(timer), .KEY_OK(key_ok) );
	alu M1_ALU ( .alu_zero_flag(alu_zero_flag), .alu_out(alu_out), .data_1(data_1), .data_2(data_2), .sel(sel) );
	pc M2_PC ( .pc_counter(pc_counter), .data_in(data_in), .load_pc(load_pc), .offset(offset), .timer(timer), .rst(rst) );
	Reg M3_REG ( .W(reg_w), .CLK(clk), .ON(reg_on), .ADDR(reg_addr), .DATA_IN(reg_data_in), .DATA_OUT(reg_data_out) );
	
endmodule
