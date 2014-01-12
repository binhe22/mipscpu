`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:51:39 01/05/2014 
// Design Name: 
// Module Name:    vga_display 
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
module vga_display(input CLK33MHz, input [10:0] XCoord, YCoord, 
						output [7:0] pixel_in, 
						input [15:0] DATA_OUT_VGA, output reg [15:0] RADDR_VGA);
	reg [7:0] data;
	reg [15:0] addr;
	assign pixel_in = data;
	reg [15:0] vga_buf_start;
	initial begin
		data = 8'd0;
	end
	
	always @(posedge CLK33MHz) begin
		if(XCoord < 640 && YCoord < 480) begin
			vga_buf_start = (YCoord[4]==0)?`VGA_BUF1_START:`VGA_BUF2_START;
			addr =(YCoord[3:0])* 640 + XCoord;
			RADDR_VGA = vga_buf_start + (addr>>1);
			data = (addr[0]==0)?DATA_OUT_VGA[15:8]:DATA_OUT_VGA[7:0];
		end
	end
	
endmodule
