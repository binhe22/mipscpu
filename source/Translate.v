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
                output [memory_addr-1:0] RADDR;
                output [word_size-1:0] RDATAOUT;
                input [word_size-1:0] RDATAIN;
                
                output M_W;
                output [memory_addr-1:0] MADDR;
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
                reg [word_size-1:0] raddr;
                
                

                assign M_W = m_w;
                assign MADDR = maddr;
                assign MDATAOUT = mdataout;
                
                assign R_W = r_w;
                assign RADDR = raddr;
                assign RDATAOUT = rdataout;
                
                
                assign SEL_OUT[op_size-1:0]=sel;
                assign DATA1_OUT=I_IN;

                
                always @ (posedge DCLK) 
                
                begin
                        case (I_IN[word_size-1:word_size-4])
                        `LW:
                                begin
                                        regaddr1=I_IN[`GET_REG1];
                                        im=I_IN[`GET_IM];
                                        m_w = 1'b1;
                                        maddr = im;
                                        memorydata = MDATAIN;
                                end
                                
                        4'b0010:
                                begin
                                end
                        `SW:
                                begin
                                        regaddr1=I_IN[`GET_REG1];
                                        im=I_IN[`GET_IM];
                                        r_w = 1'b1;
                                        m_w = 1'b0;
                                end
                        4'b0100:
                                begin
                                end                
                        4'b0101:
                                begin
                                end
                        4'b0110:
                                begin
                                end
                        4'b0111:
                                begin
                                end
                        4'b1000:
                                begin
                                end
                        4'b1001:
                                begin
                                end
                        `ADDI:
                                begin
                                regaddr1=I_IN[`GET_REG1];
                                im=I_IN[`GET_IM];
                                r_w=1;
                                raddr = regaddr1;
                                rdataout = im;
                                end
                        default:
                                begin
                                end
                        endcase
                end
        
endmodule