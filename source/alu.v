`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:43:01 12/25/2013 
// Design Name: 
// Module Name:    alu 
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
module alu (alu_zero_flag, alu_out, data_1, data_2, sel, clk);
  
	// Opcodes
	wire [`WORD_SIZE:0] sub_res;
	wire [`WORD_SIZE:0] add_res;
	
	wire oflow_add;	//加法溢出位
	wire oflow_sub;	//减法溢出位 
	wire oflow;			//总的溢出位
	
	output alu_zero_flag;
	output [`WORD_SIZE-1: 0] alu_out;
	input [`WORD_SIZE-1: 0] data_1, data_2;
	input [`OP_SIZE-1: 0] sel;
	input clk;
	
	assign sub_res = data_1 - data_2;
	assign add_res = data_1 + data_2;
	
	assign oflow_sub = (data_1[`WORD_SIZE-1] != data_2[`WORD_SIZE-1] && sub_res[`WORD_SIZE-1] == data_2[`WORD_SIZE-1]) ? 1 : 0;
	assign oflow_add = (data_1[`WORD_SIZE-1] == data_2[`WORD_SIZE-1] && add_res[`WORD_SIZE-1] != data_1[`WORD_SIZE-1]) ? 1 : 0;
  
	reg [`WORD_SIZE-1: 0] 	tmp_alu_out;
	assign alu_out = tmp_alu_out;
	assign  alu_zero_flag = (0 == tmp_alu_out);
	always @(*)  
		case  (sel)
			`ADD: tmp_alu_out = add_res;
			`OR: tmp_alu_out = data_1 | data_2;
			`SUB: tmp_alu_out = sub_res;
			`AND: tmp_alu_out = data_1 & data_2;
			`SLT: tmp_alu_out = (data_1 < data_2) ? 1: 0;
			default: tmp_alu_out = 0;
		endcase 
endmodule
