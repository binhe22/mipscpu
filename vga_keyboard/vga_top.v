`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:43:27 01/04/2014 
// Design Name: 
// Module Name:    vga_top 
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
module VGA_top (input CLK,
				input SW0, output LED9,
				output Hsync, Vsync, output [2:0] R, G, output [1:0] B, output [7:0] LEDS, 
				input KCLK, KDATA
				);
  wire [7:0] pixel_in;
  reg CLK25MHz, CLK50MHz, CLK33MHz;
  reg [31:0] count_2;
  reg [31:0] count_3;
  
  wire [7:0] KCODE;
  wire KCOME;
  
  wire MW_CPU_ON,MW_IO_ON;
  wire [15:0] DATA_OUT_IO, DATA_OUT_CPU;
  wire [15:0] RADDR_IO,RADDR_CPU,WADDR_IO,DATA_IN_IO,WADDR_CPU,DATA_IN_CPU;
  
  wire MW_VGA_ON;
  wire [15:0] RADDR_VGA,WADDR_VGA,DATA_IN_VGA;
  wire [15:0] DATA_OUT_VGA;
  
  wire [10:0] XCoord, YCoord;
  
  initial
    begin
      CLK25MHz = 0;
		CLK50MHz = 0;
		count_2 = 0;
		count_3 = 0;
    end 

//	assign LEDS = KCODE;
	assign LEDS = (SW0==1)?DATA_IN_VGA[15:8]:DATA_IN_VGA[7:0];
	assign LED9 = KCOME;
  
  always @ (posedge CLK) begin
    count_2 = count_2 + 1;
	 if (count_2 >= 2) begin
		count_2 = 0;
		CLK25MHz = ~CLK25MHz;
	 end
  end
  
  always @ (posedge CLK) begin
    CLK50MHz = ~CLK50MHz;
  end
  
  always @(CLK) begin
    count_3 = count_3 + 1;
	 if(count_3 >= 3) begin
		count_3 = 0;
	   CLK33MHz = ~CLK33MHz;
	 end
  end
  
    vga VGA(CLK25MHz, pixel_in, Hsync, Vsync, R, G, B, XCoord, YCoord);
	 vga_display VGA_DISPLAY (CLK33MHz, XCoord, YCoord, pixel_in, DATA_OUT_VGA, RADDR_VGA);
	 vga_memory VGA_MEMORY (CLK,MW_VGA_ON,RADDR_VGA,WADDR_VGA,DATA_IN_VGA,DATA_OUT_VGA);
	 vga_buf VGA_BUF (CLK50MHz,YCoord,XCoord,WADDR_VGA, DATA_IN_VGA,MW_VGA_ON,RADDR_IO, DATA_OUT_IO);
	 
	 kbctrl KBCTRL (KCLK, KDATA, KCODE, KCOME);
	 kcode_ascii KCODE_ASCII (KCLK, KCOME, KCODE, WADDR_IO, DATA_IN_IO, MW_IO_ON);
	 
	 Memorynew MEMORYNEW (CLK, RADDR_IO,DATA_OUT_IO,RADDR_CPU,DATA_OUT_CPU,WADDR_IO,DATA_IN_IO,WADDR_CPU,DATA_IN_CPU,MW_CPU_ON,MW_IO_ON);                                       
  endmodule
