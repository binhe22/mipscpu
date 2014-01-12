`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    01:17:50 01/09/2014 
// Design Name: 
// Module Name:    vga_memory 
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
module vga_memory(input CLK,MW_VGA_ON, input [15:0] RADDR_VGA,WADDR_VGA,DATA_IN_VGA, output [15:0] DATA_OUT_VGA);                                       
   
	parameter mem_size = 20000;
  
  reg [15: 0] memory [mem_size -1:0];
  
  reg [31:0] i;
  
  initial begin
		i= 0;
		while(i<mem_size) begin
			memory[i] = 16'b0000_0000_0000_0000;
			i = i+1;
		end
	end

  assign DATA_OUT_VGA = memory[RADDR_VGA];  

  always @ (negedge CLK) begin
		if (MW_VGA_ON) begin
				memory[WADDR_VGA] = DATA_IN_VGA;
		end
	end
endmodule
