module top_module
(
    CLK, RSTn,LEDS, PC_8, IR_8, IR_16, REG0_8, REG1_8, REG2_8, REG3_8,RUNTYPE,STAGE
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
	 input REG0_8;
	 input REG1_8;
	 input REG2_8;
	 input REG3_8;
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
		//.I_IN(IR),
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
		.REG0_8(REG0_8), 
		.REG1_8(REG1_8), 
		.REG2_8(REG2_8), 
		.REG3_8(REG3_8),
		.RUNTYPE(RUNTYPE),
		.STAGE(STAGE)
		);
		
	/*	Clk_driver U6(
		.CLK(CLK), 
		.RSTn(RSTn), 
		.CLK_OUT(CLKD_BUS)
		);
		*/
	/*	fetch U4(
		.PC(PC),
		.IR(IR),
		.M_W(M_W),
		.R_W(R_W),
		.MADDR(MADDR_BUS),
		.MDATAIN(MDATAOUT_BUS),
		.MDATAOUT(MDATAIN_BUS),
		.RADDR(RADDR_BUS),
		.RDATAIN(RDATAOUT_BUS),
		.RDATAOUT(RDATAIN_BUS),
		.DCLK(CLK),
		.CLK_M(CLK_M2)
		);*/
		
endmodule