`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:59:14 12/26/2013 
// Design Name: 
// Module Name:    translate 
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
  module Translate (DCLK, M_W,MADDR,MDATAIN,MDATAOUT,
						 RSTn,LEDS, PC_8, IR_8, IR_16, REG0_8, REG1_8, REG2_8, REG3_8,RUNTYPE,STAGE);
                                                
                                                
                parameter word_size = 16;
                parameter memory_addr = 16;
                parameter reg_addr = 4;
                parameter op_size=4;
                
                reg [word_size-1: 0] I_IN;
                input DCLK;
                
                output [7: 0] LEDS;
					 

                assign IR =  I_IN;
					 
                output M_W;
                output [word_size-1:0] MADDR;
                output [word_size-1:0] MDATAOUT;
                input [word_size-1:0] MDATAIN;
					 input RSTn;
					 input PC_8;
					 input IR_8;
					 input IR_16;
					 input REG0_8;
					 input REG1_8;
					 input REG2_8;
					 input REG3_8;
					 input RUNTYPE;
					 input STAGE;
					 
                reg [op_size-1:0] sel;
                
                reg [reg_addr-1:0] regaddr1;
                reg [reg_addr-1:0] regaddr2;                
                reg [reg_addr-1:0] regaddr3;
                
                reg [word_size-1:0] regdata1;
                reg [word_size-1:0] regdata2;
                reg [word_size-1:0] regdata3;
                
                reg [word_size-1:0] memorydata;
                
                reg [7:0] im;
                reg [3:0] offset;
                reg [7:0] target;
                
                reg m_w;
                reg [word_size-1:0] mdataout;
                reg [word_size-1:0] maddr;
                
                reg r_w;
                reg [word_size-1:0] rdataout;
                reg [reg_addr-1:0] raddr;
					 reg add_overflow;
					 reg sub_overflow;
                
                reg [word_size-1:0] data1;
                reg [word_size-1:0] data2;
                reg [word_size-1:0] data3;
					 
                assign M_W = m_w;
                assign MADDR = maddr;
                assign MDATAOUT = mdataout;
                

                assign DATA1_OUT = data1;
                assign DATA2_OUT = data2;
                assign DATA3_OUT = data3;
					 
					 reg [31:0] count;
					 reg [31:0] stage;
					 reg [31:0] stage2;
//					 reg [word_size-1: 0] REG [15: 0];
					 reg [word_size-1: 0] REG [3: 0];
					 
					 reg [word_size-1: 0] PC;
					 parameter T = 20;
//					 parameter T = 32'd2000000000;
					 reg PCADDED ;
					 initial begin
					 count=0;
					 stage=0;
					 stage2=0;
					 PC=0;
					 PCADDED = 0;
					 end
					 
					 
					 
					 always @ (posedge DCLK)
						begin
							if(RUNTYPE == `AUTO) begin 
								count = count +1;
								if(count >= T) begin
									count=0;
									stage = stage + 1;
									if(stage >=5 )
									begin
										stage=1;
									end
								end
							end
							else if(RUNTYPE == `STEP) begin
								#1 stage = stage2;
							end
						end
					
					always @(posedge STAGE) begin
						if(RUNTYPE == `STEP) begin
							stage2 = (stage==4)?1:(stage+1);
						end
					end
						
					assign LEDS [7:0] = (PC_8==1)?PC[7: 0]:(
									(IR_8==1)?I_IN[7: 0]:(
									(IR_16==1)?I_IN[15: 8]:(
									(REG0_8==1)?REG[0][7: 0]:(
									(REG1_8==1)?REG[1][7: 0]:(
									(REG2_8==1)?REG[2][7: 0]:(
									(REG3_8==1)?REG[3][7: 0]:8'b00000000
					))))));
		 always @(posedge RSTn) begin
		 end
		 always @ (stage/* or RSTn*/)
//					if (RSTn) begin
//						PC=16'b0000_0000_0000_0000;
//					end 
//               else
					begin
						if (stage == 1) begin
							m_w = 1'b0;
							maddr = PC;
							#8 I_IN = MDATAIN;
							PCADDED = 0;
						end
						else if(stage == 2) begin
                        case (I_IN[word_size-1:word_size-4])
                        `LW:
                                begin
                                        regaddr1=I_IN[`GET_REG1];
                                        im=I_IN[`GET_IM];
                                end
                                
                        `SW:
                                begin
												 regaddr1=I_IN[`GET_REG1];
												 im=I_IN[`GET_IM];
                                end
        

                                        
                        `ADD,`SUB,`OR,`AND,`SLT:
                                begin
                                
													 regaddr1 = I_IN[`GET_REG1];
													 regaddr2 = I_IN[`GET_REG2];
													 regaddr3 = I_IN[`GET_REG3];
                                        data1[word_size-1:word_size-12]=12'b0000_0000_0000;
                                        data1[word_size-13:word_size-16]=regaddr1;
                                end

                        `ADDI:
                                begin
                                regaddr1=I_IN[`GET_REG1];
                                im=I_IN[`GET_IM];
                                end
                                
                        `BEQ :
                                begin
											 offset= I_IN[`GET_REG3];
						  
											 regaddr1 = I_IN[`GET_REG1];
											 data1 = REG[regaddr1];
											 
											 regaddr2 = I_IN[`GET_REG2];
											 data2 = REG[regaddr2];
                                end
                      `JUMP :
										begin
                                  regdata1= I_IN[`GET_TARGET];        
											end     
								4'b0000:
									begin
										PC=PC;
										sel = 4'b0000;
									end
        
                        default:
                                begin	
                                end
                        endcase
							end
						else if( stage == 3)
						begin
							 case (I_IN[word_size-1:word_size-4])
							 `LW:
								begin
									m_w = 1'b0;
									maddr = im;
									#8 REG[regaddr1] = MDATAIN;
								end
								`SW:
                             begin
											 regdata1 = REG[regaddr1];
											 m_w=1'b1;
											 maddr = im;
                              end
								`ADD: begin
										regdata1 = REG[regaddr2] + REG[regaddr3];
										add_overflow = (REG[regaddr2][`WORD_SIZE-1] == REG[regaddr3][`WORD_SIZE-1] && REG[regaddr1][`WORD_SIZE-1] != REG[regaddr2][`WORD_SIZE-1]) ? 1 : 0;
										end
								`SUB: begin
										regdata1 = REG[regaddr2] - REG[regaddr3];
										sub_overflow = (REG[regaddr2][`WORD_SIZE-1] != REG[regaddr3][`WORD_SIZE-1] && REG[regaddr1][`WORD_SIZE-1] == REG[regaddr3][`WORD_SIZE-1]) ? 1 : 0;
										end
								 `OR:
										regdata1 = REG[regaddr2]|REG[regaddr3];
								 `AND:
										regdata1 = REG[regaddr2]&REG[regaddr3];
								 `SLT:
										regdata1 = (REG[regaddr2]<REG[regaddr3])?16'b0000_0000_0000_0001:16'b0000_0000_0000_0000;
								  `ADDI,`BEQ,`JUMP:;
								  
								endcase
						end
						else if( stage == 4 )
						begin
							 if(PCADDED == 1)
								;
							 else
							 begin
							 case (I_IN[word_size-1:word_size-4])
							 `LW:begin
										PC = PC+1;
									end
							 `SW:begin
									             mdataout = regdata1;
													 PC = PC+1;
								end
							 `ADD: begin
										REG[regaddr1] = regdata1;
										add_overflow = (REG[regaddr2][`WORD_SIZE-1] == REG[regaddr3][`WORD_SIZE-1] && REG[regaddr1][`WORD_SIZE-1] != REG[regaddr2][`WORD_SIZE-1]) ? 1 : 0;
										PC=PC+1;
										end
							`SUB: begin
										REG[regaddr1] = regdata1;
										sub_overflow = (REG[regaddr2][`WORD_SIZE-1] == REG[regaddr3][`WORD_SIZE-1] && REG[regaddr1][`WORD_SIZE-1] != REG[regaddr2][`WORD_SIZE-1]) ? 1 : 0;
										PC=PC+1;
										end
							`OR,`AND: begin
										REG[regaddr1] = regdata1;
										PC = PC+1;
								  end

							`SLT:begin
										REG[regaddr1] = regdata1;
										PC=PC+1;
								  end
							`ADDI:begin
										  REG[regaddr1] = im;
										  PC = PC+1;
									end
							`BEQ:begin
									if(data2==data1)begin
										PC=PC+offset;
										end
									else
										begin
											PC=PC+1;
										end
									end
							`JUMP:begin
								 PC=regdata1;   
								end
							endcase
							PCADDED = 1;
							end
						end
					end
endmodule