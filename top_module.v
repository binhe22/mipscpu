module top_module
(
    CLK, RSTn,IR,DCLK
);

	 parameter word_size = 16;
	 parameter op_size = 4;
	 parameter maddr_size=16;
	 parameter raddr_size=4;
    input CLK;
	 input DCLK;
	 input RSTn;
	 input[word_size-1:0] IR;
	 
	 
	 /*******************************/

		wire M_W;
		wire R_W;
		wire[maddr_size-1:0] MADDR_BUS;
		wire[raddr_size-1:0] RADDR_BUS;
		
		wire[word_size-1:0] MDATAIN_BUS;
		wire[word_size-1:0] MDATAOUT_BUS;
		
		wire[word_size-1:0] RDATAIN_BUS;
		wire[word_size-1:0] RDATAOUT_BUS;	
		
		reg M_ON=1'b1;
		reg R_ON=1'b1;
		
	 	Memory U1
	  (
		.W( M_W ), 
		.CLK( CLK ), 
		.ON(M_ON),
		.ADDR( MADDR_BUS ), 
		.DATA_IN( MDATAIN_BUS),
		.DATA_OUT( MDATAOUT_BUS)
		);  
	 
	 	Reg U2
	  (
		.W( R_W ),
		.CLK( CLK ),
		.ON(R_ON),
		.ADDR( RADDR_BUS ), 
		.DATA_IN( RDATAIN_BUS),
		.DATA_OUT( RDATAOUT_BUS)
		);  
		
		Translate U3
		(
		.I_IN(IR),
		.DATA1_OUT(DATA1),
		.DATA2_OUT(DATA2),
		.DATA3_OUT(DATA3),
		.SEL_OUT(ALU_SEL),
		.DCLK(CLK),
		.R_W(R_W),
		.RADDR(RADDR_BUS),
		.RDATAIN(RDATAOUT_BUS),
		.RDATAOUT(RDATAIN_BUS),
		.M_W(M_W),
		.MADDR(MADDR_BUS),
		.MDATAIN(MDATAOUT_BUS),
		.MDATAOUT(MDATAIN_BUS)
		);
		

endmodule