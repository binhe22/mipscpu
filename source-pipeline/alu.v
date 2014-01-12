module alu(
		input [15:0] IRIN,PCIN,DATAIN1,DATAIN2,DATAIN3,STAGE3IN,STAGE3OUT,
		input CLK, 
		output reg[15:0] PCOUT,IROUT,DATAOUT,ADDROUT);

	initial
	begin
						DATAOUT = 16'b0000_0000_0000_0000;
						PCOUT = 16'b0000_0000_0000_0000;
						IROUT = 16'b0000_0000_0000_0000;
						ADDROUT = 16'b0000_0000_0000_0000;	
						op = 0;
	end
	
	reg [3:0]op;
	
	always @(posedge CLK)begin
		if(STAGE3IN)
		op =  IRIN[`GET_OP];
		else op = 4'b0000;
				
	end


	always @(negedge CLK) begin
			if(STAGE3OUT)
			begin
				PCOUT = PCIN;
				IROUT = IRIN;
				ADDROUT = DATAIN1;
				

            case (op)
                `ADD:
                    DATAOUT = DATAIN2 + DATAIN3;
                `SUB:
                    DATAOUT = DATAIN2 - DATAIN3;
                `SLT:
					 begin
                    if (DATAIN2 < DATAIN3)begin
								DATAOUT[7:1] = 7'b0000_000;
								DATAOUT[0] = 1'b1;
							end
							else
								DATAOUT[7:0] = 8'b0000_0000;
							
                end
					 `AND:
                    DATAOUT = DATAIN2 & DATAIN3;
                `OR:
                    DATAOUT = DATAIN2 | DATAIN3;
					 `JUMP:
							DATAOUT = DATAIN1;
					 `ADDI:
							DATAOUT = DATAIN2;
					 `SW:
						begin
							DATAOUT = DATAIN1; 
							ADDROUT = DATAIN2;
						end
					 `LW:
						begin
							ADDROUT = DATAIN1;
							DATAOUT = DATAIN2;
						end
					 `BEQ:
						begin
							ADDROUT = DATAIN3;
							
							if(DATAIN1 == DATAIN2)
								DATAOUT = 16'b1111_1111_1111_1111;
							else
								DATAOUT = 16'b0000_0000_0000_0000;
						end
						
					  
					  default
					  begin
						DATAOUT = 16'b0000_0000_0000_0000;
						PCOUT = 16'b0000_0000_0000_0000;
						IROUT = 16'b0000_0000_0000_0000;
						ADDROUT = 16'b0000_0000_0000_0000;
						end
            endcase
			end
			else
			begin
						DATAOUT = 16'b0000_0000_0000_0000;
						PCOUT = 16'b0000_0000_0000_0000;
						IROUT = 16'b0000_0000_0000_0000;
						ADDROUT = 16'b0000_0000_0000_0000;				
			end
			
    end
	 


endmodule