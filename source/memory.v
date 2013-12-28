module Memory(W,CLK,ON,ADDR, DATA_IN,DATA_OUT);                                       
   
  parameter word_size = 16;
  parameter memory_size = 16;
	
  output [word_size-1: 0] DATA_OUT;
  input [word_size-1: 0] DATA_IN;
  input [word_size-1: 0] ADDR;
  input CLK,W,ON;
  reg [15: 0] memory [5: 0];
  
  initial begin
		//memory[0] = 16'h100D;//lw
	   //memory[1] = 16'h110E;//lw
		//memory[2] = 16'h5201;//and
		//memory[3] = 16'h6301;//or
		//memory[4] = 16'h7423;//add
		//memory[5] = 16'h8540;//sub
		//memory[6] = 16'h9601;//slt
		//memory[7] = 16'h9750;//slt
		
		//data
		//memory[13] = 16'h0003;
		//memory[14] = 16'h0005;
		memory[0] = 16'b0001_0000_0000_0100; //lw
		memory[1] = 16'b0001_0001_0000_0101; //lw
//		memory[2] = 16'b0001_0101_0000_1111; //lw
		memory[2] = 16'b0111_0010_0000_0001; //add
		memory[3] = 16'h0000_0000_0000_0000; //nop
		
		memory[4] = 16'b0000_0000_0000_0001; 
		memory[5] = 16'b0000_0000_0000_0010;
//		memory[6] = 16'b0000_0000_0000_0101;

//		memory[4] = 16'h320D; //sw
//		memory[5] = 16'h100D; //lw
//		memory[6] = 16'hA252; //beq
//		memory[7] = 16'hB003; //jump
//		memory[8] = 16'h160D; //lw
//		memory[9] = 16'h0000;//nop
		
		//data
//		memory[13] = 16'b0000_0000_0000_0001; 
//		memory[14] = 16'b0000_0000_0000_0010;
//		memory[15] = 16'b0000_0000_0000_0101;
		
		
		//memory[0] = 16'b1100_0000_0001_0001;
		//memory[1] = 16'b1100_0001_0001_0011;
		//memory[2] = 16'b0001_0010_0000_1111;
		//memory[3] = 16'b0001_0011_0000_1110;
		//memory[4] = 16'b0111_0100_0010_0011;
		//memory[5] = 16'b0011_0100_0000_1101;
		//memory[2] = 16'b0000_0000_0000_0000;

		//memory[2] = 16'b1010_0000_0001_0010;
		//memory[3] = 16'b0111_0010_0001_0000;
		//memory[4] = 16'b1000_0010_0001_0000;
		//memory[5] = 16'b1001_0011_0000_0001;
		//memory[6] = 16'b1100_0100_1111_1111;
		//memory[7] = 16'b0011_0100_0000_0000;
		//memory[7] = 16'b1011_0000_1001_0000;  
		//memory[2] = 16'b0000_0000_0000_0000;
		//memory[8] = 16'b1011_0000_1000_0000;
	end

	assign DATA_OUT = ((W == 1'b1) || (ON == 1'b0)) ? 16'bZ : (memory[ADDR]);
	
  always @ (posedge CLK)
    if (W && ON) 
		begin
			memory[ADDR] = DATA_IN;
		end

endmodule