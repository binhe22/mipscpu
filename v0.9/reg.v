module Reg(CLK,RADDR1,DATA_OUT1,RADDR2,DATA_OUT2,W_ON,WADDR,DATA_IN,TESTADDR,TESTDATAOUT);                                       
   
  parameter word_size = 16;
  parameter memory_size = 16;
  parameter addr_size = 4;
	
  output [word_size-1: 0] DATA_OUT1;
  output [word_size-1: 0] DATA_OUT2;
  
  input [word_size-1: 0] DATA_IN;
  input [addr_size-1: 0] RADDR1;
  input [addr_size-1: 0] RADDR2;
  input [addr_size-1: 0] WADDR;
  input [addr_size-1: 0] TESTADDR;
  output [7: 0] TESTDATAOUT; 
  
  input CLK,W_ON;
  
  reg [15: 0] memory [memory_size-1: 0];
  
  reg [31:0] i;
  
  initial begin
		for(i=0;i<memory_size;i=i+1) begin
			memory[i] = 16'b0000_0000_0000_0000;//ʼ
		memory[4'b1100] = 16'b1111_1111_1111_1111;
		memory[4'b1111] = 16'b1111_1111_1111_1111;
		end
	end
	
  parameter ZERO = 16'b0000_0000_0000_0000;
 
  assign DATA_OUT1=memory[RADDR1];
  assign DATA_OUT2=memory[RADDR2];
  assign TESTDATAOUT = memory[TESTADDR][7:0];  

  always @ (negedge CLK)
    if (W_ON) 
		begin
			memory[WADDR] = DATA_IN;
		end
endmodule