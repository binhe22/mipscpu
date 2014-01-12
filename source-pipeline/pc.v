`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:59:18 01/05/2014 
// Design Name: 
// Module Name:    pc 
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
	module pc(PCOUT,STAGE1WRITEBACK,REALPCWRITEBACK,OFFSET,CLK,
		WILLWRITE,STARTREG,READREG1,READREG2,ENDWRITE,ENDREG,READREG, STAGE1IN,STAGE1OUT,STAGE2IN,STAGE2OUT,STAGE3IN,STAGE3OUT,STAGE4IN,STAGE4OUT
    );
	input REALPCWRITEBACK,CLK,STAGE1WRITEBACK;
	input[15:0] OFFSET;
	output [15:0]PCOUT;
	input[3:0] STARTREG,READREG1,READREG2,ENDREG;
	input WILLWRITE,ENDWRITE,READREG;
	output reg[15:0] STAGE1IN,STAGE1OUT,STAGE2IN,STAGE2OUT,STAGE3IN,STAGE3OUT,STAGE4IN,STAGE4OUT;
	
	
	reg [15:0] point;
	reg [15:0] i;
	reg[15:0] writingreg;
	reg[15:0] tmppc;
	reg[15:0] realpc;
	parameter ZERO =  16'b0000_0000_0000_0000;
	parameter ALLONE =  16'b1111_1111_1111_1111;
	reg JUMPPC;
	
	initial
	begin
		tmppc = 0;
		realpc  = 0;
		writingreg = ZERO;
		point = 0;
		i = 0;
		
		STAGE1IN = ALLONE;
		STAGE2IN = ALLONE;
		STAGE3IN = ALLONE;
		STAGE4IN = ALLONE;
		
		STAGE1OUT = ALLONE;
		STAGE3OUT = ALLONE;
		STAGE4OUT = ALLONE;
		
		JUMPPC = 1'b0;
	end
	
	assign PCOUT = tmppc;
	
	
	
	always@(posedge CLK)
	begin	
	end
	
	always@(negedge CLK)
	begin
		JUMPPC = 1'b0;
		
		if(STAGE1WRITEBACK)
			tmppc = tmppc + 1;
			
		if(ENDWRITE == 1'b1)
			begin
				writingreg[ENDREG] = 1'b0;
			end
			
		if((OFFSET -realpc>1) && REALPCWRITEBACK)begin
			STAGE1IN = ZERO;
			STAGE2IN = ZERO;
			STAGE3IN = ZERO;
			STAGE4IN = ZERO;
		
			STAGE1OUT = ZERO;
			STAGE2OUT = ZERO;
			STAGE3OUT = ZERO;
			STAGE4OUT = ZERO;
			tmppc = OFFSET;
			writingreg = 16'b0000_0000_0000_0000;	
			
		end
		else if(READREG && (writingreg[READREG1]||writingreg[READREG2]))begin
			STAGE1IN = ZERO;
			STAGE2IN = ZERO;
			STAGE3IN = ZERO;
			STAGE4IN = ALLONE;
		
			STAGE1OUT = ZERO;
			STAGE2OUT = ZERO;
			STAGE3OUT = ALLONE;
			STAGE4OUT = ALLONE;
			tmppc = realpc;
		end
		else
		begin
			STAGE1IN = ALLONE;
			STAGE2IN = ALLONE;
			STAGE3IN = ALLONE;
			STAGE4IN = ALLONE;
		
			STAGE1OUT = ALLONE;
			STAGE2OUT = ALLONE;
			STAGE3OUT = ALLONE;
			STAGE4OUT = ALLONE;
		end
		
		if(WILLWRITE == 1'b1)
			begin
				writingreg[STARTREG] = 1'b1;
		end
		
		if(REALPCWRITEBACK == 1'b1)
		begin
			realpc = OFFSET;
		end
	
	
	end
	

endmodule
