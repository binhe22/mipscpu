module clk_divider
(
    CLK, RSTn, LED_Out,KEY_OK
);

    input CLK;
	 input RSTn;
	 input KEY_OK;
	 output [3:0] LED_Out;
	 
	 parameter T = 30'd10_000_000;
	 reg [29:0]Count1;
	 
	 reg led0;
	 reg led1;
	 reg led2;
	 reg led3;
	 
	 initial begin
		Count1=30'd0;
		end
		
	 
	 always @ ( posedge CLK or negedge RSTn )
		begin
	    if( !RSTn )	
	        Count1 <= 30'd0;
	    else if( Count1 >= T*4 )
	        Count1 <= 30'd0;
	    else
	        Count1 <= Count1 + 1'b1;
		end
	

	 always @ ( posedge CLK or negedge RSTn )
        if( !RSTn ) 
				begin
				led0 <= 1'b0;
				led1 <= 1'b0;
				led2 <= 1'b0;
				led3 <= 1'b0;
				end
		  else if( Count1 >= 0 && Count1 < T )
          begin 
				led0 <= 1'b1;
				led1 <= 1'b0;
				led2 <= 1'b0;
				led3 <= 1'b0;
			end
        else if( Count1 >= T && Count1 < T*2 )
			begin	
				led0 <= 1'b0;
				led1 <= 1'b1;
				led2 <= 1'b0;
				led3 <= 1'b0;
			end
		  else if( Count1 >= T*2  && Count1 < T*3 )
         begin
				led0 <= 1'b0;
				led1 <= 1'b0;
				led2 <= 1'b1;
				led3 <= 1'b0;
			end
        else if( Count1 >= T*3 && Count1 < T*4 )
			begin
				led0 <= 1'b0;
				led1 <= 1'b0;
				led2 <= 1'b0;
				led3 <= 1'b1;
			end

	
    assign LED_Out = { led3 ,led2, led1, led0 };
endmodule
 