`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:21:16 01/04/2014 
// Design Name: 
// Module Name:    kbctrl 
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
module kbctrl(input KCLK, input KDATA, output [7:0] KCODE, output KCOME);
  reg enable;
  reg [3:0] left, right;
  reg [31:0] count;
  reg is_start;
  reg [8:0] shift;
  
  assign KCODE = {left, right};
  assign KCOME = enable;
  
  initial
    begin
      enable = 0;
      left = 4'd0;
      right = 4'd0;
		count = 32'd0;
		is_start = 0;
		shift = 9'd0;
    end
  
  always @(posedge KCLK)
    begin
		enable = 0;
		left[3:0] = 4'd0;
		right[3:0] = 4'd0;
		if(is_start == 0 && KDATA == 0) begin
			is_start = 1;
		end
		else if(is_start==1) begin
			shift = {KDATA, shift[8:1]};
			count = count + 1;
			if(count>=9) begin
				count = 0;
				is_start = 0;
				enable = 1;
				left[3:0] = shift[7:4];
				right[3:0] = shift[3:0];
			end
		end
	end
endmodule

