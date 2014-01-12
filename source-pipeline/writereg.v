// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module writereg(
			input CLK,
			input [15:0] IRIN,DATAIN,ADDRIN,
			output reg[15:0] DATA_OUT,
			output reg W_ON,
			output reg[3:0]WADDR,
			output reg ENDWRITE,
			output reg[3:0] ENDREG
    );
	 
	 
	initial
	begin
		DATA_OUT = 16'b0000_0000_0000_0000;
		W_ON = 1'b0;
		WADDR = 4'b0000;
	end
	
	always@(posedge CLK)
	begin
		DATA_OUT = 16'b0000_0000_0000_0000;
		W_ON = 1'b0;
		WADDR = 4'b0000;
		ENDWRITE = 1'b0;
		case (IRIN[`GET_OP])
		`ADD,`SUB,`OR,`AND,`SLT,`ADDI:
		begin	
			W_ON = 1'b1;
			WADDR =  ADDRIN[3:0];
			DATA_OUT = DATAIN;
			ENDWRITE = 1'b1;
			ENDREG = WADDR;
		end
		
		endcase
	end
	
endmodule