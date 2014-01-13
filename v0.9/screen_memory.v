`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:59:56 01/13/2014 
// Design Name: 
// Module Name:    screen_memory 
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
module screen_memory(input CLK,MW_SCREEN_ON, input [15:0] RADDR_SCREEN,WADDR_SCREEN,DATA_IN_SCREEN, output [15:0] DATA_OUT_SCREEN);                                       
  parameter mem_size = 1200;
  reg [15: 0] memory [mem_size-1:0];
  reg [31:0] i, j;
  reg [639:0] welcome_str;
  
  initial begin
		i= 0;
		while(i<mem_size) begin
			memory[i] = 16'b0000_0000_0000_0000;
			i = i+1;
		end
		welcome_str = {
			{30{8'd0}},
			`ascii_shift_w, `ascii_e, `ascii_l, `ascii_c, `ascii_o, `ascii_m, `ascii_e, 8'd0, 
			`ascii_t, `ascii_o, 8'd0, 
			`ascii_n, `ascii_e, `ascii_w, 8'd0, 
			`ascii_l, `ascii_a,`ascii_n, `ascii_d, `ascii_shift_1, 
			{30{8'd0}}
		};  
		i = 0;
		while(i<40) begin
			for(j=0;j<16;j=j+1) begin
				memory[`SCREEN_BUF_START+i][15-j] = welcome_str[639-(i*16+j)];
			end
			i = i+1;
		end
	end

  assign DATA_OUT_SCREEN = memory[RADDR_SCREEN];  

  always @ (negedge CLK) begin
		if (MW_SCREEN_ON) begin
				memory[WADDR_SCREEN] = DATA_IN_SCREEN;
		end
	end
endmodule