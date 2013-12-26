
module Memory(W,ON, CLK, ADDR, Mem_Bus);                                       
   
   `define ADDR_bit  15		//16 - 1
	`define DATA_bit  15		//16-1
	input W; //1 write(data in) ;0 read (data out) 
	input ON;//1  work;0 not work                                                                     
	input CLK;                                                                     
	input [`ADDR_bit:0] ADDR;                                                             
	inout [`DATA_bit:0] Mem_Bus;  //output                                                        
                                                                               
	reg [`DATA_bit:0] data_out;                                                           
	reg [`DATA_bit:0] RAM [0:256];                                                        
                                                                               
initial                                                                        
	begin                                                                          
	/* Write Verilog-Text IO code here */                                                                            
	end                                                                            
                                                                               
assign Mem_Bus = ((ON == 1'b0) || ( W == 1'b1))?  `DATA_bit'bZ : data_out;            
                                                                               
always @(posedge CLK)                                                          
	begin                                                                          
	if(( ON == 1'b1) && (W == 1'b1))                                               
		RAM[ADDR] <= Mem_Bus[`DATA_bit:0];                                                  
                                                                               
	data_out <= RAM[ADDR];                                                         
	end                                                                            
endmodule  