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
module alu (alu_zero_flag, alu_out, data_1, data_2, sel);
	parameter word_size = 16;
	parameter op_size = 4;
  
  // Opcodes
  
//  parameter LW 	= 4'b0001;
//  parameter LB 	= 4'b0010;
//  parameter SW 	= 4'b0011;
//  parameter SB 	= 4'b0100;

	//instructions needed to be processed by alu 
	parameter AND 	= 4'b0101;
	parameter OR  	= 4'b0110;
	parameter ADD	= 4'b0111;
	parameter SUB	= 4'b1000;
	parameter SLT 	= 4'b1001;
	
//  parameter BEQ   = 4'b1010;
//  parameter JUMP  = 4'b1011;
//  parameter ADDI  = 4'b1100;

	wire [word_size:0] sub_res;
	wire [word_size:0] add_res;
	
	wire oflow_add;	//加法溢出位
	wire oflow_sub;	//减法溢出位 
   wire oflow;			//总的溢出位
	
	assign sub_res = data_1 - data_2;
	assign add_res = data_1 + data_2;
	
	assign oflow_sub = (data_1[word_size-1] != data_2[word_size-1] && sub_res[word_size] == data_2[word_size-1]) ? 1 : 0;
	assign oflow_add = (data_1[word_size-1] == data_2[word_size-1] && add_res[word_size] != data_1[word_size-1]) ? 1 : 0;
  
  output 			alu_zero_flag;
  output [word_size-1: 0] 	alu_out;
  input 	[word_size-1: 0] 	data_1, data_2;
  input 	[op_size-1: 0] 	sel;
  
  reg [word_size-1: 0] 	alu_out;
  assign  alu_zero_flag = (0 == alu_out);
  always @ (*)  
     case  (sel)
      ADD: alu_out <= add_res;
		OR: alu_out <= data_1 | data_2;
      SUB: alu_out <= sub_res;
      AND: alu_out <= data_1 & data_2;
		SLT: alu_out <= (data_1 < data_2) ? 1: 0;
      default: alu_out <= 0;
    endcase 
endmodule
