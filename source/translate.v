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
						 RSTn,LEDS, PC_8, IR_8, IR_16, REGADDR, RUNTYPE,STAGE);
                                                
                                                
                parameter word_size = 16;
                parameter memory_addr = 16;
                parameter reg_addr = 4;
                parameter op_size=4;
                
                reg [word_size-1: 0] I_IN;
                input DCLK;
                
                output [7: 0] LEDS;
					 

                assign IR =  I_IN;
					 
                output M_W; //¶ÁÐ´ÐÅºÅ
                output [word_size-1:0] MADDR;
                output [word_size-1:0] MDATAOUT;
                input [word_size-1:0] MDATAIN;
					 input RSTn;
					 input PC_8;
					 input IR_8;
					 input IR_16;
					 input [3:0] REGADDR;
					 
					 input RUNTYPE;
					 input STAGE;
					 
					 reg [31:0] testcount;
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
					 reg [31:0] i;
					 reg [2:0] stage;
					 reg [word_size-1: 0] REG [15: 0];
					 
					 wire CHANGE;
					 reg stage2;
					 
					 reg [word_size-1: 0] PC;
					 parameter T = 20;
					 
					 initial begin
						count=0;
						stage = 3'b000;
						m_w = 1'b0;
						testcount = 0;
						PC = 0;
						maddr = 0;
						add_overflow = 0;
						sub_overflow = 0;
						for(i=0;i<16;i=i+1) begin
							REG[i] = 16'b0000_0000_0000_0000;//¼Ä´æÆ÷³õÊ¼»¯
						end
					 end
					 
   			assign CHANGE = (RUNTYPE == `AUTO)? (DCLK):(STAGE);

				always @(posedge CHANGE)
				begin
						stage = (stage >=4 )? 1:(stage + 1);
						if (stage == 1) begin
							I_IN = MDATAIN;
						end
						else if(stage == 2) begin
                        case (I_IN[word_size-1:word_size-4])
                        `LW:
                                begin
                                        regaddr1=I_IN[`GET_REG1];
                                        maddr=I_IN[`GET_IM];
													 m_w = 1'b0;
													 
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
								   REG[regaddr1] = MDATAIN;
								end
								`SW:
                             begin
											 regdata1 = REG[regaddr1];
											 m_w=1'b1;
											 maddr = im;
											 mdataout = regdata1;
                              end
								`ADD: begin
										regdata1 = REG[regaddr2] + REG[regaddr3];
										add_overflow = ((REG[regaddr2][`WORD_SIZE-1] == 1&REG[regaddr3][`WORD_SIZE-1] == 1&regdata1[`WORD_SIZE-1]==0)||(REG[regaddr2][`WORD_SIZE-1]==0&REG[regaddr3][`WORD_SIZE-1]==0&regdata1[`WORD_SIZE-1]==1))?1:0;
										REG[`OVERFLOW_ADDR] = add_overflow;
										end
								`SUB: begin
										regdata1 = REG[regaddr2] - REG[regaddr3];
										sub_overflow = ((REG[regaddr2][`WORD_SIZE-1] == 1&REG[regaddr3][`WORD_SIZE-1] == 0&regdata1[`WORD_SIZE-1]==0)||(REG[regaddr2][`WORD_SIZE-1]==0&REG[regaddr3][`WORD_SIZE-1]==1&regdata1[`WORD_SIZE-1]==1))?1:0;
										REG[`OVERFLOW_ADDR] = sub_overflow;
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
							 case (I_IN[word_size-1:word_size-4])
							 `LW:begin
										PC = PC+1;
									end
							 `SW:begin
									             
													 PC = PC+1;
								end
							 `ADD: begin
//										add_overflow = (REG[regaddr2][`WORD_SIZE-1] == REG[regaddr3][`WORD_SIZE-1] && REG[regaddr1][`WORD_SIZE-1] != REG[regaddr2][`WORD_SIZE-1]) ? 1 : 0;
										REG[regaddr1] = regdata1;
										PC=PC+1;
										end
							`SUB: begin
//										sub_overflow = (REG[regaddr2][`WORD_SIZE-1] != REG[regaddr3][`WORD_SIZE-1] && REG[regaddr1][`WORD_SIZE-1] == REG[regaddr3][`WORD_SIZE-1]) ? 1 : 0;
										REG[regaddr1] = regdata1;
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
							m_w = 1'b0;
							maddr = PC;
						end
				end
				assign LEDS [7:0] = (PC_8==1)?PC[7: 0]:(
						(IR_8==1)?I_IN[7: 0]:(
						(IR_16==1)?I_IN[15: 8]:
						REG[REGADDR][7:0]
				));

endmodule