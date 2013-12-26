`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    07:12:20 12/26/2013 
// Design Name: 
// Module Name:    reg 
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
module Reg(W,CLK,ON,ADDR, DATA_IN,DATA_OUT);                                       
	output [`WORD_SIZE-1: 0] DATA_OUT;
	input [`WORD_SIZE-1: 0] DATA_IN;
	input [`WORD_SIZE-1: 0] ADDR;
	input CLK,W,ON;
	reg [`WORD_SIZE-1: 0] memory [`OP_SIZE-1: 0];

	assign DATA_OUT = ((W == 1'b1) || (ON == 1'b0)) ? 16'bZ : (memory[ADDR]);

	always @ (posedge CLK)
	 if (W && ON) 
					 begin
								memory[ADDR] = DATA_IN;
					 end

endmodule
