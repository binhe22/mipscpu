module top_module
(
    CLK, RSTn, M_W,R_W,M_ON,R_ON,DATAIN_BUS,DATAOUT_BUS,ADDR_BUS
);
	 parameter word_size = 16;
	 parameter op_size = 4;
	 parameter addr_size=16;
    input CLK;
	 input RSTn;
	 
	 
	 /*******************************/
	 input M_W,R_W,M_ON,R_ON;
	 input[word_size-1:0] DATAIN_BUS;
	 input[addr_size-1:0] ADDR_BUS;
	 output[word_size-1:0] DATAOUT_BUS;
	 
	 	Memory U1
	  (
		.W( M_W ), 
		.CLK( CLK ), 
		.ON(M_ON),
		.ADDR( ADDR_BUS ), 
		.DATA_IN( DATAIN_BUS),
		.DATA_OUT( DATAOUT_BUS)
		);  
	 
	 	Reg U2
	  (
		.W( R_W ),
		.CLK( CLK ),
		.ON(R_ON),
		.ADDR( ADDR_BUS ), 
		.DATA_IN( DATAIN_BUS),
		.DATA_OUT( DATAOUT_BUS)
		);  


endmodule