`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:18:57 01/05/2014 
// Design Name: 
// Module Name:    fetch 
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
module fetch(RADDR_CPU,DATA_IN,STAGE1IN,STAGE1OUT,IROUT,PCOUT,PCIN,STAGE1WRITEBACK,CLK
    );
	 output [15:0]RADDR_CPU;
	 input [15:0]DATA_IN,STAGE1IN,STAGE1OUT,PCIN;
	 input CLK;
	 output [15:0] IROUT,PCOUT;//forward ir pc
	 output STAGE1WRITEBACK;
	 
	 reg[15:0] raddr_cpu;
	 reg stage1writeback;
	 reg [15:0] pc,ir;
	 reg gonext;
	 reg[15:0] lastpc,lastir;

	 
	 parameter ZERO = 16'b0000_0000_0000_0000;
	 
	 initial
	 begin
		stage1writeback= 0;
		raddr_cpu = 16'b0000_0000_0000_0000;
		pc = 16'bz;
		ir = 16'b0000_0000_0000_0000;
		lastpc = ZERO;
		lastir = ZERO;
		gonext = 0;
	 end
	 
	 assign IROUT =lastir ;
	 assign PCOUT = lastpc ;
	 
	 assign STAGE1WRITEBACK = gonext;//negedge
	 
	 assign RADDR_CPU = pc;
	 
	 always @(posedge CLK)
	 begin
		if(STAGE1IN)
		begin
			if(ir[`GET_OP] == 4'b1111)
			begin
			end
			else
			begin
				pc = PCIN;
				gonext = 1'b1;
			end
		end
		else
		begin
			gonext = 1'b0;
		end
	 end
	 
	 
	 always @(negedge CLK)
	 begin
		if(STAGE1OUT)
		begin
			ir = DATA_IN;
			lastir = ir;
			lastpc = pc;
		end
		else
		begin
			lastir = ZERO;
			lastpc = ZERO;
		end
	 end
	 
	
	 

endmodule
