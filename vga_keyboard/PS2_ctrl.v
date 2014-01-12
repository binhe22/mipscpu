`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:42:59 01/04/2014 
// Design Name: 
// Module Name:    PS2_ctrl 
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
module ps2ctrl (data,clk,lastSent);
input data;
input clk;
output [15:0] lastSent;



reg [15:0] lastSent;
reg [3:0] c1;
reg start;




always@(negedge clk)
begin
  if(data==0&&start==0)
    begin
      start=1; 
    end
  else
    begin
      start=0;
    end
  if(start==1)
  begin  
    if(c1==4'b0000)
      begin
        lastSent[0]=data;
        c1=c1+1;  
      end
    else if(c1==4'b0001)
      begin
       lastSent[1]=data;
       c1=c1+1; 
      end
    else if(c1==4'b0010)
      begin
       lastSent[2]=data;
       c1=c1+1;   
      end
    else if(c1==4'b0011)
      begin
        lastSent[3]=data;
        c1=c1+1;  
      end
    else if(c1==4'b0100)
      begin
        lastSent[4]=data;
        c1=c1+1;   
      end
    else if(c1==4'b0101)
      begin
        lastSent[5]=data;
        c1=c1+1;   
      end
    else if(c1==4'b0110)
      begin
        lastSent[6]=data;
        c1=c1+1;   
      end
    else if(c1==4'b0111)
      begin
        lastSent[7]=data; 
        c1=c1+1; 
      end
    else if(c1==4'b1000)
      begin
        lastSent[8]=data;
        c1=c1+1;  
      end
    else if(c1==4'b1001)
      begin
        lastSent[9]=data;
        c1=0;
        start=0;   
      end
  end
end
endmodule 
