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
module Translate (I_IN,DATA1_OUT,DATA2_OUT,DATA3_OUT,SEL_OUT,DCLK, M_W,MADDR,MDATAIN,MDATAOUT);
                                                
                                                
                parameter word_size = 16;
                parameter memory_addr = 16;
                parameter reg_addr = 4;
                parameter op_size=4;
                
                input [word_size-1: 0] I_IN;
                input DCLK;
                
                output [word_size-1: 0] DATA1_OUT;
                output [word_size-1: 0] DATA2_OUT;
                output [word_size-1: 0] DATA3_OUT;
                output [op_size-1: 0] SEL_OUT;
                
                
                output M_W;
                output [word_size-1:0] MADDR;
                output [word_size-1:0] MDATAOUT;
                input [word_size-1:0] MDATAIN;
                
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
                
                reg [word_size-1:0] data1;
                reg [word_size-1:0] data2;
                reg [word_size-1:0] data3;

/*                assign M_W= (!DCLK) ? 1'bZ:m_w;
                assign MADDR= (~DCLK) ? 16'bz:maddr;
                assign MDATAOUT= (~DCLK) ? 16'bz:mdataout;
                
                        assign M_W = (DCLK)? 1'bz:(m_w);
                assign MADDR = (DCLK)?16'bz:maddr;
                assign MDATAOUT = (DCLK)?16'bz:mdataout;
                

                assign R_W= (~DCLK) ? 1'bz:r_w;
                assign RADDR= (~DCLK) ? 16'bz:raddr;
                assign RDATAOUT= (~DCLK) ? 16'bz:rdataout;                
*/
                
                
                assign M_W = m_w;
                assign MADDR = maddr;
                assign MDATAOUT = mdataout;
                
        

                assign SEL_OUT[op_size-1:0]=sel;

                assign DATA1_OUT = data1;
                assign DATA2_OUT = data2;
                assign DATA3_OUT = data3;
					 
					 reg[31:1] count;
					 reg[31:1] stage;
					 reg [word_size-1: 0] REG[15: 0];
					 reg [word_size-1: 0] PC;
					 parameter T = 100; 
					 initial begin
					 count=0;
					 stage=0;
					 PC=0;
					 end
					 
					 

					 
					 always @ (posedge DCLK) begin 
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
					
					

                
                always @ (stage) 
                
                begin
					 
					 if(stage == 2) begin
                        case (I_IN[word_size-1:word_size-4])
                        `LW:
                                begin
                                        regaddr1=I_IN[`GET_REG1];
                                        im=I_IN[`GET_IM];
                                        m_w = 1'b0;
                                        maddr = im;
                                        REG[regaddr1] = MDATAIN;
													 PC = PC+1;
                                end
                                

                        `SW:
                                begin
                                        regaddr1=I_IN[`GET_REG1];
                                        im=I_IN[`GET_IM];
													 
                                        regdata1 = REG[regaddr1];
                                        m_w=1'b1;
                                        maddr = im;
                                        mdataout = regdata1;
													 PC = PC+1;
								
                                end
        

                                        
                        `ADD,`SUB,`OR,`AND,`SLT:
                                begin
                                
                                        regaddr1 = I_IN[`GET_REG1];
													 regaddr2 = I_IN[`GET_REG2];
													 regaddr3 = I_IN[`GET_REG3];
                                        data1[word_size-1:word_size-12]=12'b0000_0000_0000;
                                        data1[word_size-13:word_size-16]=regaddr1;
													 case (I_IN[word_size-1:word_size-4])
													 `ADD:
														REG[regaddr1]=REG[regaddr2]+REG[regaddr3];
													 `SUB:
														REG[regaddr1]=REG[regaddr2]-REG[regaddr3];
													 `OR:
														REG[regaddr1]=REG[regaddr2]|REG[regaddr3];
													 `SLT:
														REG[regaddr1]=(REG[regaddr2]<REG[regaddr3])?16'b0000_0000_0000_0001:16'b0000_0000_0000_0000;
													endcase
													 PC = PC+1;
					
                                        sel = I_IN[word_size-1:word_size-4];
                                end

                        `ADDI:
                                begin
                                regaddr1=I_IN[`GET_REG1];
                                im=I_IN[`GET_IM];
										  REG[regaddr1] = im;
										  PC = PC+1;
								
                                end
                                
                        `BEQ :
                                begin
                                         offset= I_IN[`GET_REG3];
                          
                                        regaddr1 = I_IN[`GET_REG1];
                                        data1 = REG[regaddr1];
                                        
                                        regaddr2 = I_IN[`GET_REG2];
                                        data2 = REG[regaddr2];
													 if(data2==data1)
														begin
															PC=PC+offset;
														end
													  else
														begin
															PC=PC+1;
														end
												
                                        sel = I_IN[word_size-1:word_size-4];
                                end
                                
                                `JUMP :
												begin
                                        regdata1= I_IN[`GET_TARGET];
													 PC=PC+regdata1;
											
                                        sel = I_IN[word_size-1:word_size-4];
                                        
											end
                                
        
                        default:
                                begin
                                end
                        endcase
							end
                end
        
endmodule
