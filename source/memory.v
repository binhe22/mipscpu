module Memory(W,CLK,ON,ADDR, DATA_IN,DATA_OUT);                                       
   
  parameter word_size = 16;
  parameter memory_size = 16;
	
  output [word_size-1: 0] DATA_OUT;
  input [word_size-1: 0] DATA_IN;
  input [word_size-1: 0] ADDR;
  input CLK,W,ON;
  reg [15: 0] memory [15: 0];
  
  reg [31:0] i;
  
  initial begin
		for(i=0;i<16;i=i+1) begin
			memory[i] = 16'b0000_0000_0000_0000;//主存初始化
		end
		//指令部分
//		memory[0] = 16'b0001_0000_0000_1101;//lw
//	   memory[1] = 16'b0001_0001_0000_1110;//lw
//		memory[2] = 16'b0101_0010_0000_0001;//and
//		memory[3] = 16'b0110_0011_0000_0001;//or
//		memory[4] = 16'b0111_0100_0010_0011;//add
//		memory[5] = 16'b1000_0101_0100_0000;//sub
//		memory[6] = 16'b1001_0110_0000_0001;//slt
//		memory[7] = 16'b1001_0111_0101_0000;//slt
//		memory[8] = 16'b0000_0000_0000_0000; //nop
//		
//		//数据部分
//		memory[13] = 16'b0000_0000_0000_0011;
//		memory[14] = 16'b0000_0000_0000_0101;

//		memory[0] = 16'b0001_0000_0000_1100;   //lw
//		memory[1] = 16'b0001_0001_0000_1101;   //lw
//		memory[2] = 16'b0001_0010_0000_1110;   //lw
//		memory[3] = 16'b0001_0011_0000_1111;   //lw
//		memory[4] = 16'b0111_0010_0010_0000;   //add
//		memory[5] = 16'b0111_0000_0000_0011;   //add
//		memory[6] = 16'b1010_0000_0001_0010;   //beq
//		memory[7] = 16'b1011_0000_0100_0000;   //jump
//		memory[8] = 16'b0011_0010_0000_1110;   //sw
		
		//test add overflow
//		memory[0] = 16'b0001_0000_0000_1011;  //lw
//		memory[1] = 16'b0001_0001_0000_1100;  //lw
//		memory[2] = 16'b0111_0010_0000_0001;  //add
//		memory[3] = 16'b0000_0000_0000_0000;  //nop
//		memory[11] = 16'b0111_1111_1111_1111;  //max 16 bits positive integer
//		memory[12] = 16'b0000_0000_0000_0001;
		
		//test sub overflow
		memory[0] = 16'b0001_0000_0000_1011;  //lw
		memory[1] = 16'b0001_0001_0000_1100;  //lw
		memory[2] = 16'b1000_0010_0000_0001;  //sub
		memory[3] = 16'b0000_0000_0000_0000;  //nop;
		
		memory[11] = 16'b0111_1111_1111_1111;  //255
		memory[12] = 16'b1111_1111_1111_1101;  //-3
		
		//data
//		memory[12] = 16'b0000_0000_0000_0001;  //1
//		memory[13] = 16'b0000_0000_0000_1011;  //11
//		memory[14] = 16'b0000_0000_0000_0000;  //0
//		memory[15] = 16'b0000_0000_0000_0001;  //1
		
		//add program from 1 to 10
//		memory[0] = 16'b0001

//		memory[4] = 16'h320D; //sw
//		memory[5] = 16'h100D; //lw
//		memory[6] = 16'hA252; //beq
//		memory[7] = 16'hB003; //jump
//		memory[8] = 16'h160D; //lw
//		memory[9] = 16'h0000;//nop
	end

	assign DATA_OUT = ((W == 1'b1) || (ON == 1'b0)) ? 16'bZ : (memory[ADDR]);
	
  always @ (posedge CLK)
    if (W && ON) 
		begin
			memory[ADDR] = DATA_IN;
		end
endmodule