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
module Translate (I_IN,DATA1_OUT,DATA2_OUT,DATA3_OUT,SEL_OUT,DCLK,

						R_W,RADDR,RDATAIN,RDATAOUT,
						
						M_W,MADDR,MDATAIN,MDATAOUT);
						
						
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
		
		output R_W;
		output [word_size-1:0] RADDR;
		output [word_size-1:0] RDATAOUT;
		input [word_size-1:0] RDATAIN;
		
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

/*		assign M_W= (!DCLK) ? 1'bZ:m_w;
		assign MADDR= (~DCLK) ? 16'bz:maddr;
		assign MDATAOUT= (~DCLK) ? 16'bz:mdataout;
		
			assign M_W = (DCLK)? 1'bz:(m_w);
		assign MADDR = (DCLK)?16'bz:maddr;
		assign MDATAOUT = (DCLK)?16'bz:mdataout;
		

		assign R_W= (~DCLK) ? 1'bz:r_w;
		assign RADDR= (~DCLK) ? 16'bz:raddr;
		assign RDATAOUT= (~DCLK) ? 16'bz:rdataout;		
*/
		
		assign R_W = r_w;
		assign RADDR = raddr;
		assign RDATAOUT = rdataout;
		
		assign M_W = m_w;
		assign MADDR = maddr;
		assign MDATAOUT = mdataout;
		
	

		assign SEL_OUT[op_size-1:0]=sel;

		assign DATA1_OUT = data1;
		assign DATA2_OUT = data2;
		assign DATA3_OUT = data3;

		
		always @ (DCLK) 
		
		begin
			case (I_IN[word_size-1:word_size-4])
			`LW:
				begin
					regaddr1=I_IN[`GET_REG1];
					im=I_IN[`GET_IM];
					m_w = 1'b0;
					maddr = im;
					regdata1 = MDATAIN;
					r_w = 1'b1;
					raddr = im;
					rdataout = regdata1;
				end
				

			`SW:
				begin
					regaddr1=I_IN[`GET_REG1];
					im=I_IN[`GET_IM];
					r_w = 1'b0;
					raddr = regaddr1;
					regdata1 = RDATAIN;
					m_w=1'b1;
					maddr = im;
					mdataout = regdata1;
				end
	

					
			`ADD,`SUB,`OR,`AND,`SLT:
				begin
				
					regaddr1 = I_IN[`GET_REG1];
					data1[word_size-1:word_size-12]=12'b0000_0000_0000;
					data1[word_size-13:word_size-16]=regaddr1;
					
					regaddr3 = I_IN[`GET_REG3];
					r_w = 1'b0;
					raddr = regaddr3;
					#50 regdata3 = RDATAIN;
					data3 = regdata3;
					
					regaddr2 = I_IN[`GET_REG2];
					r_w = 1'b0;
					raddr = regaddr2;
					#50 regdata2 = RDATAIN;
					data2 = regdata2;
					
					sel = I_IN[word_size-1:word_size-4];
				end

			`ADDI:
				begin
				regaddr1=I_IN[`GET_REG1];
				im=I_IN[`GET_IM];
				r_w=1;
				raddr = regaddr1;
				rdataout = im;
				end
				
			`BEQ :
				begin
					regaddr3 = I_IN[`GET_REG3];
					data3[word_size-1:word_size-12]=12'b0000_0000_0000;
					data3[word_size-13:word_size-16]=regaddr3;
					
					regaddr1 = I_IN[`GET_REG1];
					r_w = 1'b0;
					raddr = regaddr1;
					#50 regdata1 = RDATAIN;
					data1 = regdata1;
					
					regaddr2 = I_IN[`GET_REG2];
					r_w = 1'b0;
					raddr = regaddr2;
					#50 regdata2 = RDATAIN;
					data2 = regdata2;
					
					sel = I_IN[word_size-1:word_size-4];
				end
				
				`JUMP :
				begin
					data1[word_size-1:word_size-8]=8'b0000_0000;
					data1[word_size-9:word_size-16] = I_IN[`GET_TARGET];
					sel = I_IN[word_size-1:word_size-4];
					
				end
				
	
			default:
				begin
				end
			endcase
		end
	
endmodule
