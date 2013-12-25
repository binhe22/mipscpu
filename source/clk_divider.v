module clk_divider
(
    CLK, RSTn, LED_Out
);

    input CLK;
	 input RSTn;
	 output [3:0]LED_Out;
	 
	 /*******************************/
	 wire M_W;
	 wire M_ON;
	 wire R_W;
	 wire R_ON;
	 wire [15:0] DATA_BUS;
	 wire [15:0] ADDR_BUS;
	 wire [3:0] LED;
	  Memory U1
	  (
		.W( M_W ),
		.ON( M_ON ), 
		.CLK( CLK ), 
		.ADDR( ADDR_BUS ), 
		.Mem_Bus( DATA_BUS)
		);   
	 
	 	Reg U2
	  (
		.W( R_W ),
		.ON( R_ON ), 
		.CLK( CLK ), 
		.ADDR( ADDR_BUS ), 
		.Mem_Bus( DATA_BUS)
		);  
		clk_driver U3
		(
			.CLK(CLK), 
			.RSTn(RSTn), 
			.LED_Out(LED),
			.KEY_OK(KEY_OK)
		);
	 
	 /**********************************/
	 
	 assign LED_Out = LED;
	 
	 /***********************************/

endmodule
