module Memorynew(CLK,RADDR_IO,DATA_OUT_IO,RADDR_CPU,DATA_OUT_CPU,WADDR_IO,DATA_IN_IO,WADDR_CPU,DATA_IN_CPU,MW_CPU_ON,MW_IO_ON,STAGE4ADDR,STAGE4OUT);                                       
   
	parameter mem_size = 200;
  input [15:0] RADDR_IO,RADDR_CPU,WADDR_IO,DATA_IN_IO,WADDR_CPU,DATA_IN_CPU;
  output[15:0] DATA_OUT_IO,DATA_OUT_CPU;
  input MW_CPU_ON,MW_IO_ON;
  input CLK;
  input [15:0] STAGE4ADDR;
  output [15:0] STAGE4OUT;
  
  reg [15: 0] memory [mem_size -1:0];
  reg [31:0] i, j;
  
  
  initial begin
		i= 0;
		while(i<mem_size) begin
			memory[i] = 16'b0000_0000_0000_0000;
			i = i+1;
		end
		memory[0]=16'b1100_0000_0001_0001;//addi
		memory[1]=16'b1100_0001_0010_0010;//addi
		memory[2]=16'b1100_0010_0100_0100;//addi
		memory[3]=16'b1100_0011_1000_1000;//addi
		
		memory[4]=16'b0111_0100_0001_0000;//add
		memory[5]=16'b0110_0101_0100_0000;//or
		memory[6]=16'b0101_0000_0001_0011;//and
		memory[7]=16'b0011_0000_0000_0000;//sw
		memory[8]=16'b1000_0111_0100_0001;//sub
		memory[8]=16'b1001_1000_0001_0100;//slt
		memory[9]=16'b1011_0000_1011_0000;//jump
		memory[10] =16'b1100_0000_0000_0001;//halt
		memory[11] =16'b1010_0000_1111_0010;//beq
		memory[12] =16'b1100_0000_0000_0001;//halt
		memory[13] =16'b0001_1110_0000_0001;//lw
		memory[14] =16'b1011_0000_1110_0000;
	end

  assign DATA_OUT_CPU = memory[RADDR_CPU];
  assign DATA_OUT_IO = memory[RADDR_IO];
	assign STAGE4OUT = memory[STAGE4ADDR];

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
