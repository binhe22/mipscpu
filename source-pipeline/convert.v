`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:33:46 01/05/2014 
// Design Name: 
// Module Name:    convert 
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
module convert(
	input [15:0]
	IRIN,PCIN,DATAIN1,DATAIN2, STAGE2IN,STAGE2OUT,
	output [15:0] 
	IROUT,PCOUT,DATAOUT1,DATAOUT2,DATAOUT3,
	output [3:0] RADDR1,RADDR2,
	output reg [3:0] READREG1,READREG2,STARTREG,
	output reg WILLWRITE,READREG,
	input CLK
    );

	reg  [3:0]op ,reg1,reg2,reg3,offset;
	reg [7:0] im,target;
	
	reg[15:0] dataout1,dataout2,dataout3;
	
	reg[3:0] raddr1,raddr2;
	reg[15:0] lastir,ir,lastpc,pc;
	reg[15:0] lastdataout1,lastdataout2,lastdataout3;
	
	initial
	begin

		raddr1 = 4'b0000;
		raddr2 = 4'b0000;
		dataout1 = ZERO;
		dataout2 = ZERO;
		dataout3 = ZERO;
		ir = 0;
		pc = 0;
		lastir = 0;
		lastpc = 0;
		
		lastdataout1 = ZERO;
		lastdataout2 = ZERO;
		lastdataout3 = ZERO;
	end
	
	
	parameter ZERO = 16'b0000_0000_0000_0000;
	

	assign RADDR1 = raddr1;
	assign RADDR2 = raddr2;
	
	assign PCOUT = lastpc;
	assign IROUT = lastir;
	
	assign DATAOUT1 = lastdataout1;
	assign DATAOUT2 = lastdataout2;
	assign DATAOUT3 = lastdataout3;



	always @(posedge CLK)
	begin
		
		if(STAGE2IN)
		begin
			ir = IRIN;
			pc = PCIN;
		end
		else
		begin
			ir = ZERO;
			pc = ZERO;

		end
		op = ir[`GET_OP];
		reg1 = ir[`GET_REG1];
		reg2 = ir[`GET_REG2];
		reg3 = ir[`GET_REG3];
		offset = ir[`GET_OFFSET];
		im = ir[`GET_IM];
		target = ir[`GET_TARGET];
		WILLWRITE = 1'b0;
		READREG = 1'b0;
		
	
		case (op)
			`ADD,`OR,`AND,`SUB,`SLT:
			begin
				
				raddr1= reg2;
				raddr2= reg3;
				WILLWRITE = 1'b1;
				STARTREG = reg1;
				
				READREG = 1'b1;
				READREG1 = reg2;
				READREG2 = reg3;
				
			end
			`ADDI:
			 begin
			 end	
			
			default
			begin
			end
		endcase
	end
	
	
	
	always@(negedge CLK)
	begin	
	if(STAGE2OUT)
	begin
		case (op)
			`ADD,`OR,`AND,`SUB,`SLT:
			begin
				
				dataout2 = DATAIN1;
				dataout3 = DATAIN2;
				dataout1[15:4] = 12'b0000_0000_0000;
				dataout1[3:0] = reg1;
			end
			`JUMP:
			begin
				dataout1 = target;
			end
			`ADDI:
			begin
				dataout1 = reg1;
				dataout2 = im;
			end
			default
			begin
				raddr1 = 4'b0000;
				raddr2 = 4'b0000;	
				dataout1 = ZERO;
				dataout2 = ZERO;
				dataout3 = ZERO;
			end
		endcase
		
		lastir = ir;
		lastpc = pc;
		lastdataout2 = dataout2;
		lastdataout3 = dataout3;
		lastdataout1 = dataout1;
	end
	else
	begin
		lastir = ZERO;
		lastpc = ZERO;
		lastdataout2 = ZERO;
		lastdataout3 = ZERO;
		lastdataout1 = ZERO;		
	end
	end
	
	


endmodule
