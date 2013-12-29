module top_module
(
    CLK, RSTn,LEDS, PC_8, IR_8, IR_16, REGADDR, RUNTYPE,STAGE
);

	 parameter word_size = 16;
	 parameter op_size = 4;
	 parameter maddr_size=16;
	 parameter raddr_size=4;
    
	 input CLK;
	 
	 input RSTn;
	 input STAGE;
	 
	 //controls the out with switches.
	 input PC_8;
	 input IR_8;
	 input IR_16;
	 input [3:0] REGADDR;
	 input RUNTYPE;
	 output [7:0] LEDS;

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
		wire[word_size-1:0] PC;
		
		wire PCOFFSET;
		wire PCLOAD;
		wire PCDATABUS;
		wire [3:0] CLKD_BUS;
		
		reg CLK_M1,CLK_M2,CLK_M3,CLK_M4;
		
		Memory U1
	  (
		.W( M_W ), 
		.CLK( CLK ), 
		.ON(M_ON),
		.ADDR( MADDR_BUS ), 
		.DATA_IN( MDATAIN_BUS),
		.DATA_OUT( MDATAOUT_BUS)
		);  
	 

		Translate U3
		(
		.DCLK(CLK),
		.M_W(M_W),
		.MADDR(MADDR_BUS),
		.MDATAIN(MDATAOUT_BUS),
		.MDATAOUT(MDATAIN_BUS),
		.RSTn(RSTn),
		.LEDS(LEDS), 
		.PC_8(PC_8), 
		.IR_8(IR_8), 
		.IR_16(IR_16), 
		.REGADDR(REGADDR),
		.RUNTYPE(RUNTYPE),
		.STAGE(STAGE)
		);
		
endmodule