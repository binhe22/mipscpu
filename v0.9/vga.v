`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    09:12:25 01/04/2014 
// Design Name: 
// Module Name:    vga 
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
module vga (CLK25MHz, pixel_in, Hsync, Vsync, R, G, B, XCoord, YCoord);
  input CLK25MHz;
  input [7:0] pixel_in;
  
  output [2:0] R, G;
  output [1:0] B;
  output Hsync, Vsync;
  output [10:0] XCoord, YCoord;
  
  reg Hsync, Vsync;
  reg [10:0] HCount, VCount;
  
  initial
    begin
      Hsync <= 1;
      Vsync <= 1;
      HCount <= 11'd0;
      VCount <= 11'd0;
    end
  
  assign XCoord = HCount;
  assign YCoord = VCount;
  assign R = (HCount < 11'd640 && VCount < 11'd480) ? pixel_in[7:5] : 3'b000;  
  assign G = (HCount < 11'd640 && VCount < 11'd480) ? pixel_in[4:2] : 3'b000; 
  assign B = (HCount < 11'd640 && VCount < 11'd480) ? pixel_in[1:0] : 2'b00; 

  always @ (negedge CLK25MHz)
    begin
          if (HCount >= 800)                    // increment and reset HCount and increment VCount
            begin
              HCount <= 0;
              VCount <= VCount + 1;
            end
          else
            HCount <= HCount + 1;
       
          if (HCount < 659 || HCount > 755)     // Hsync control
            Hsync <= 1;
          else
            Hsync <= 0; 
              
          if (VCount < 493 || VCount > 494)     // Vsync control
            Vsync <= 1;
          else
            Vsync <= 0;
        
          if (VCount >= 525)                    // reset VCount
            VCount <= 0;
          else
            begin
            end    
    end
endmodule