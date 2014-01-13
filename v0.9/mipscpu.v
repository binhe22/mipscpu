`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:13:04 01/05/2014 
// Design Name: 
// Module Name:    mipscpu 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module mipscpu(input CLK,
				input [7:0] SWS, input [3:0] BTNS, output LED9,
				output Hsync, Vsync, output [2:0] R, G, output [1:0] B, output [7:0] LEDS, 
				input KCLK, KDATA);
  wire [7:0] pixel_in;
  reg CLK25MHz, CLK50MHz, CLK33MHz;
  reg [31:0] count_2;
  reg [31:0] count_3;
  wire [10:0] XCoord, YCoord;
  
  wire [7:0] KCODE;
  wire KCOME;
  
  //vga memory
  wire MW_VGA_ON;
  wire [15:0] RADDR_VGA,WADDR_VGA,DATA_IN_VGA;
  wire [15:0] DATA_OUT_VGA;
  
  //screen memory
  wire MW_SCREEN_ON;
  wire [15:0] RADDR_SCREEN,WADDR_SCREEN,DATA_IN_SCREEN;
  wire [15:0] DATA_OUT_SCREEN;

///////////////////////memory-reg bus define///////////////
wire [15:0] MRADDR_IO_BUS,MDATA_OUT_IO_BUS,MRADDR_CPU_BUS,MDATA_OUT_CPU_BUS,
                                MWADDR_IO_BUS,MDATA_IN_IO_BUS,MWADDR_CPU_BUS,MDATA_IN_CPU_BUS,
                                RDATA_OUT1_BUS,RDATA_OUT2_BUS,RDATA_IN_BUS;
wire MW_CPU_ON_BUS,MW_IO_ON_BUS,RW_ON_BUS;
wire [3:0] RRADDR1_BUS,RRADDR2_BUS,RWADDR_BUS;
//////////////PC////////////////////////

 wire [15:0] PC_BUS;
 wire [15:0] OFFSET_BUS;
 wire REALPCWRITEBACK_BUS,STAGE1WRITEBACK_BUS;
 wire [15:0] STAGE1IN_BUS,STAGE2IN_BUS,STAGE3IN_BUS,STAGE4IN_BUS,STAGE1OUT_BUS,STAGE2OUT_BUS,STAGE3OUT_BUS,STAGE4OUT_BUS;
 wire WILLWRITE_BUS,ENDWRITE_BUS,READREG_BUS;
 wire [3:0]READREG1_BUS,READREG2_BUS ,ENDREG_BUS,STARTREG_BUS;
 wire [15:0] STAGE4ADDR_BUS,STAGE4DATA_BUS;

wire [7:0] REG_BUS;


assign LEDS [7:0] = (SWS[3:1]==3'b000)?REG_BUS:(
						 (SWS[3:1]==3'b001)?MDATA_OUT_CPU_BUS:(
						 (SWS[3:1]==3'b010)?PC_BUS:(
						 (SWS[3:1]==3'b011)?MRADDR_CPU_BUS:8'b0000_1111)
						 ));

assign LED9 = KCOME;

//////////////////test/////////////////////////
  initial
    begin
      CLK25MHz = 0;
		CLK50MHz = 0;
		count_2 = 0;
		count_3 = 0;
    end 
  
  always @ (posedge CLK) begin
    count_2 = count_2 + 1;
	 if (count_2 >= 2) begin
		count_2 = 0;
		CLK25MHz = ~CLK25MHz;
	 end
  end
  
  always @ (posedge CLK) begin
    CLK50MHz = ~CLK50MHz;
  end
  
  always @(CLK) begin
    count_3 = count_3 + 1;
	 if(count_3 >= 3) begin
		count_3 = 0;
	   CLK33MHz = ~CLK33MHz;
	 end
  end
  
//vga and keyboard
		vga VGA(CLK25MHz, pixel_in, Hsync, Vsync, R, G, B, XCoord, YCoord);
		vga_display VGA_DISPLAY (CLK33MHz, XCoord, YCoord, pixel_in, DATA_OUT_VGA, RADDR_VGA);
		vga_memory VGA_MEMORY (CLK,MW_VGA_ON,RADDR_VGA,WADDR_VGA,DATA_IN_VGA,DATA_OUT_VGA);
		vga_buf VGA_BUF (CLK50MHz,YCoord,XCoord,WADDR_VGA, DATA_IN_VGA,MW_VGA_ON,RADDR_SCREEN, DATA_OUT_SCREEN);

		kbctrl KBCTRL (KCLK, KDATA, KCODE, KCOME);
		kcode_ascii KCODE_ASCII (KCLK, KCOME, KCODE, WADDR_SCREEN, DATA_IN_SCREEN, MW_SCREEN_ON);
		screen_memory SCREEN_MEMORY (CLK,MW_SCREEN_ON,RADDR_SCREEN,WADDR_SCREEN,DATA_IN_SCREEN,DATA_OUT_SCREEN);
		
//////////////////////////////////////////
Memorynew M(
.CLK(CLK),
.RADDR_IO(MRADDR_IO_BUS),
.DATA_OUT_IO(MDATA_OUT_IO_BUS),
.RADDR_CPU(MRADDR_CPU_BUS),
.DATA_OUT_CPU(MDATA_OUT_CPU_BUS),
.WADDR_IO(MWADDR_IO_BUS),
.DATA_IN_IO(MDATA_IN_IO_BUS),
.WADDR_CPU(MWADDR_CPU_BUS),
.DATA_IN_CPU(MDATA_IN_CPU_BUS),

.MW_CPU_ON(MW_CPU_ON_BUS),
.MW_IO_ON(MW_IO_ON_BUS),

.STAGE4ADDR(STAGE4ADDR_BUS),
.STAGE4OUT(STAGE4DATA_BUS)
);    

Reg Reg(
.CLK(CLK),
.RADDR1(RRADDR1_BUS),
.DATA_OUT1(RDATA_OUT1_BUS),
.RADDR2(RRADDR2_BUS),
.DATA_OUT2(RDATA_OUT2_BUS),
.W_ON(RW_ON_BUS),
.WADDR(RWADDR_BUS),
.DATA_IN(RDATA_IN_BUS),
.TESTADDR(SWS[7:4]),
.TESTDATAOUT( REG_BUS)
); 

pc PC(
.PCOUT(PC_BUS),
.STAGE1WRITEBACK(STAGE1WRITEBACK_BUS),
.REALPCWRITEBACK(REALPCWRITEBACK_BUS),
.OFFSET(OFFSET_BUS),
.CLK(CLK),
.WILLWRITE(WILLWRITE_BUS),
.STARTREG(STARTREG_BUS),
.READREG1(READREG1_BUS),
.READREG2(READREG2_BUS),
.ENDWRITE(ENDWRITE_BUS),
.ENDREG(ENDREG_BUS),
.STAGE1IN(STAGE1IN_BUS),
.STAGE2IN(STAGE2IN_BUS),
.STAGE3IN(STAGE3IN_BUS),
.STAGE4IN(STAGE4IN_BUS),

.STAGE1OUT(STAGE1OUT_BUS),
.STAGE2OUT(STAGE2OUT_BUS),
.STAGE3OUT(STAGE3OUT_BUS),
.STAGE4OUT(STAGE4OUT_BUS),

.READREG(READREG_BUS)
    );
 
 
 wire [15:0]IR_12_BUS;
wire [15:0]PC_12_BUS;

 
fetch STAGE1(
.RADDR_CPU(MRADDR_CPU_BUS),
.DATA_IN(MDATA_OUT_CPU_BUS),
.STAGE1IN(STAGE1IN_BUS),
.STAGE1OUT(STAGE1OUT_BUS),
.IROUT(IR_12_BUS),
.PCOUT(PC_12_BUS),
.PCIN(PC_BUS),
.STAGE1WRITEBACK(STAGE1WRITEBACK_BUS),
.CLK(CLK)
 );  


wire [15:0] IR_23_BUS,
                                 PC_23_BUS,
                                 DATA1_23_BUS,
                                 DATA2_23_BUS,
                                 DATA3_23_BUS;
 
convert STAGE2(
        .IRIN(IR_12_BUS),
        .PCIN(PC_12_BUS),
        .DATAIN1(RDATA_OUT1_BUS),
        .DATAIN2(RDATA_OUT2_BUS), 
        .STAGE2IN(STAGE2IN_BUS),
        .STAGE2OUT(STAGE2OUT_BUS),
        .IROUT(IR_23_BUS),
        .PCOUT(PC_23_BUS),
        .DATAOUT1(DATA1_23_BUS),
        .DATAOUT2(DATA2_23_BUS),
        .DATAOUT3(DATA3_23_BUS),
        .RADDR1(RRADDR1_BUS),
        .RADDR2(RRADDR2_BUS),
        .CLK(CLK),
        .WILLWRITE(WILLWRITE_BUS),
        .STARTREG(STARTREG_BUS),
        .READREG1(READREG1_BUS),
        .READREG2(READREG2_BUS),
        .READREG(READREG_BUS)
    );

wire [15:0] IR_34_BUS,
                                 PC_34_BUS,
                                 DATA_34_BUS,
                                 ADDR_34_BUS;
         
alu STAGE3(
                .IRIN(IR_23_BUS),
                .PCIN(PC_23_BUS),
                .DATAIN1(DATA1_23_BUS),
                .DATAIN2(DATA2_23_BUS),
                .DATAIN3(DATA3_23_BUS),
                .STAGE3IN(STAGE3IN_BUS),
                .STAGE3OUT(STAGE3OUT_BUS),
                .CLK(CLK), 
                .PCOUT(PC_34_BUS),
                .IROUT(IR_34_BUS),
                .DATAOUT(DATA_34_BUS),
                .ADDROUT(ADDR_34_BUS));

wire [15:0] IR_45_BUS,
                                 PC_45_BUS,
                                 DATA_45_BUS,
                                 ADDR_45_BUS;

writememory STAGE4(
                        .CLK(CLK),
                   .IRIN(IR_34_BUS),
                        .DATAIN(DATA_34_BUS),
                        .ADDRIN(ADDR_34_BUS),
                        .STAGE4IN(STAGE4IN_BUS),
                        .STAGE4OUT(STAGE4OUT_BUS),
                        .WADDR_CPU(MWADDR_CPU_BUS),
                        .DATA_OUT_CPU(MDATA_IN_CPU_BUS),
                        .ADDROUT(ADDR_45_BUS),
                        .DATAOUT(DATA_45_BUS),
                        .IROUT(IR_45_BUS),
                        .MW_CPU_ON(MW_CPU_ON_BUS),
                        .REALPCWRITEBACK(REALPCWRITEBACK_BUS) ,
                        .OFFSET(OFFSET_BUS),
                        .PCIN(PC_34_BUS),
                        .RADDR_CPU(STAGE4ADDR_BUS),
                        .DATA_IN_CPU(STAGE4DATA_BUS)

    );
         
writereg STAGE5(
                        .CLK(CLK),
                        .IRIN(IR_45_BUS),
                        .DATAIN(DATA_45_BUS),
                        .ADDRIN(ADDR_45_BUS),
                        .DATA_OUT(RDATA_IN_BUS),
                        .W_ON(RW_ON_BUS),
                        .WADDR(RWADDR_BUS),
                        .ENDWRITE(ENDWRITE_BUS),
                        .ENDREG(ENDREG_BUS)
    );

                        
                        
  endmodule