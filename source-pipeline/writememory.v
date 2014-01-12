`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:02:29 01/05/2014 
// Design Name: 
// Module Name:    writememory 
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
module writememory(
			input CLK,
			input [15:0] IRIN,DATAIN,ADDRIN,STAGE4IN,STAGE4OUT,
			output reg[15:0] WADDR_CPU,DATA_OUT_CPU,ADDROUT,DATAOUT,IROUT,
			output reg MW_CPU_ON,REALPCWRITEBACK ,
			output reg[15:0] OFFSET,
			input [15:0] PCIN
			
    );
	 
	 reg [3:0] op;
	 initial 
	 begin
			IROUT = 16'b0000_0000_0000_0000;
		   ADDROUT = 16'b0000_0000_0000_0000;
			DATAOUT = 16'b0000_0000_0000_0000;			
			MW_CPU_ON = 1'b0;
			WADDR_CPU = 16'b0000_0000_0000_0000;
			DATA_OUT_CPU = 16'b0000_0000_0000_0000;
			OFFSET = 0;	
			op = 0;
	 end
	 
	 always@(posedge CLK)
	 begin
		 MW_CPU_ON = 1'b0;
		 WADDR_CPU = 16'b0000_0000_0000_0000;
		 DATA_OUT_CPU = 16'b0000_0000_0000_0000;
		 REALPCWRITEBACK = 1'b0;
		 OFFSET= 0;
		
		if(STAGE4IN)begin
			op = IRIN[`GET_OP];
		 end
		 else
		 begin
			op = 4'b0000;
		 end
		 
		if(STAGE4IN)
		begin	
			case (op)
			`SW:
			begin
				MW_CPU_ON = 1'b1;
				WADDR_CPU = ADDRIN;
				DATA_OUT_CPU = DATAIN;
				
				REALPCWRITEBACK = 1'b1;
				OFFSET=1+PCIN;
			end
			`ADD,`SUB,`AND,`OR:
			begin
				REALPCWRITEBACK = 1'b1;
				OFFSET=1+PCIN;
			end
			`JUMP:
			begin
				REALPCWRITEBACK = 1'b1;
				OFFSET = DATAIN;
			end
			endcase
		end
	 end
	
	
	
	
	always @(negedge CLK)
	begin
			if(STAGE4OUT)
			begin
				IROUT = IRIN;
				ADDROUT = ADDRIN;
				DATAOUT = DATAIN;
			end
			else
			begin
				IROUT = 16'b0000_0000_0000_0000;
				ADDROUT = 16'b0000_0000_0000_0000;
				DATAOUT = 16'b0000_0000_0000_0000;	
			end
	end


endmodule
