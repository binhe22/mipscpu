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
			memory[i] = 16'b0000_0000_0000_0000;//主存初始化
		end
	end

  assign DATA_OUT_CPU= memory[RADDR_CPU];
  assign DATA_OUT_IO= memory[RADDR_IO];  

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
