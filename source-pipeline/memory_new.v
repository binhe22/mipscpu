module Memorynew(CLK,RADDR_IO,DATA_OUT_IO,RADDR_CPU,DATA_OUT_CPU,WADDR_IO,DATA_IN_IO,WADDR_CPU,DATA_IN_CPU,MW_CPU_ON,MW_IO_ON);                                       
   
	parameter mem_size = 200;
  input [15:0] RADDR_IO,RADDR_CPU,WADDR_IO,DATA_IN_IO,WADDR_CPU,DATA_IN_CPU;
  output[15:0] DATA_OUT_IO,DATA_OUT_CPU;
  input MW_CPU_ON,MW_IO_ON;
  input CLK;
  
  reg [15: 0] memory [mem_size -1:0];
  
  reg [31:0] i;
  
  initial begin
		for(i=0;i<mem_size;i=i+1) begin
		memory[i] = 16'b0000_0000_0000_0000;//Ö÷´æ³õÊ¼»¯
		end

			memory[0]=16'b1011_0000_0011_0000;
			memory[1]=16'b0111_0001_0010_0011;
			memory[2]=16'b0111_1001_0011_0010;
			memory[3]=16'b0111_1000_0001_0010;
			memory[4]=16'b0111_1100_1000_0000;
			memory[5]=16'b0110_1110_1100_0000;
			memory[6]=16'b0101_0000_0010_1000;
			memory[7]=16'b1000_1111_0011_1100;
			memory[8]=16'b1100_0111_1111_1111;
			
		   
		


		
	end

  assign DATA_OUT_CPU=(RADDR_CPU === 16'bz)?16'bz:memory[RADDR_CPU];
  assign DATA_OUT_IO= (RADDR_IO === 16'bz)?16'bz:memory[RADDR_IO];  


 


  always @ (negedge CLK)
	begin
  if (MW_IO_ON) 
		begin
			memory[WADDR_IO] = DATA_IN_IO;
		end
	 if (MW_CPU_ON) 
		begin
			memory[WADDR_CPU]= DATA_IN_CPU;
		end
	end
	
endmodule