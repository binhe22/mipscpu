
module Memory(W,CLK,ON,ADDR, DATA_IN,DATA_OUT);                                       
   
	parameter word_size = 16;
	parameter memory_size = 16;
		  
	output [word_size-1: 0] DATA_OUT;
	input [word_size-1: 0] DATA_IN;
	input [word_size-1: 0] ADDR;
	input CLK,W,ON;
	reg [word_size-1: 0] memory [memory_size-1: 0];
	reg [word_size-1: 0] k;
	
	initial
	begin
		for (k = 0; k < memory_size ; k = k + 1) 
		begin 
			memory[k] = k+1; 
		end
	end

	assign DATA_OUT = ((W == 1'b1) || (ON == 1'b0)) ? 16'bZ : (memory[ADDR]);

	always @ (posedge CLK)
		if (W && ON) 
			begin
				memory[ADDR] = DATA_IN;
			end

endmodule