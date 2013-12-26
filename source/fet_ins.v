`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:01:08 12/26/2013 
// Design Name: 
// Module Name:    fet_ins 
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
module fet_ins(timer, pc_counter, mem_w, mem_on, mem_addr, mem_data_out,
					reg_w, reg_on, reg_addr, reg_data_in, reg_data_out, ir_reg);
	input [`WORD_SIZE-1: 0] pc_counter;
	input [`TIMER_SIZE-1: 0] timer;
	input [`WORD_SIZE-1: 0] mem_data_out;
	input [`WORD_SIZE-1: 0] reg_data_out;
	
	output mem_w, mem_on;
	output [`WORD_SIZE-1: 0] mem_addr;
	output [`WORD_SIZE-1: 0] reg_data_in;
	output [`WORD_SIZE-1: 0] reg_addr;
	output reg_w, reg_on;
	output [`WORD_SIZE-1: 0] ir_reg;

	reg tmp_mem_w, tmp_mem_on;
	reg [`WORD_SIZE-1: 0] tmp_mem_addr;
	reg [`WORD_SIZE-1: 0] tmp_reg_data_in;
	reg [`WORD_SIZE-1: 0] tmp_reg_addr;
	reg [`WORD_SIZE-1: 0] tmp_ir_reg;
	reg tmp_reg_w, tmp_reg_on;
	
	assign mem_w = tmp_mem_w;
	assign mem_on = tmp_mem_on;
	assign mem_addr = tmp_mem_addr;
	assign reg_data_in = tmp_reg_data_in;
	assign reg_w = tmp_reg_w;
	assign reg_on = tmp_reg_on;
	assign reg_addr = tmp_reg_addr;
	assign ir_reg = tmp_ir_reg;
	
	always @(timer)
	begin
		case (timer)
			`CYCLE1:
				begin
					tmp_mem_w = 0;
					tmp_mem_on = 1;
					tmp_mem_addr = pc_counter;
					#20 tmp_reg_data_in = mem_data_out;
					tmp_reg_w = 1;
					tmp_reg_on = 1;
					tmp_reg_addr = `IR_ADDR;
					#20 tmp_ir_reg = reg_data_out;
				end
		default:
				begin
				end
		endcase
	end
endmodule
