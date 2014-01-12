`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:19:47 01/09/2014 
// Design Name: 
// Module Name:    vga_buf 
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
module vga_buf(input CLK50MHz, input [10:0] YCoord, XCoord,
			output reg [15:0] WADDR_VGA, DATA_IN_VGA, output reg MW_VGA_ON, 
			output reg [15:0] RADDR_IO, input [15:0] DATA_OUT_IO);
	parameter screen_width = 80;
	function [127:0] GET_FONT;
		input [7:0] ascii_code;
		case (ascii_code)
			`ascii_1: begin GET_FONT = `char_1; end
			`ascii_1: begin GET_FONT = `char_1; end
			`ascii_2: begin GET_FONT = `char_2; end
			`ascii_3: begin GET_FONT = `char_3; end
			`ascii_4: begin GET_FONT = `char_4; end
			`ascii_5: begin GET_FONT = `char_5; end
			`ascii_6: begin GET_FONT = `char_6; end
			`ascii_7: begin GET_FONT = `char_7; end
			`ascii_8: begin GET_FONT = `char_8; end
			`ascii_9: begin GET_FONT = `char_9; end
			`ascii_0: begin GET_FONT = `char_0; end
			`ascii_a: begin GET_FONT = `char_a; end
			`ascii_b: begin GET_FONT = `char_b; end
			`ascii_c: begin GET_FONT = `char_c; end
			`ascii_d: begin GET_FONT = `char_d; end
			`ascii_e: begin GET_FONT = `char_e; end
			`ascii_f: begin GET_FONT = `char_f; end
			`ascii_g: begin GET_FONT = `char_g; end
			`ascii_h: begin GET_FONT = `char_h; end
			`ascii_i: begin GET_FONT = `char_i; end
			`ascii_j: begin GET_FONT = `char_j; end
			`ascii_k: begin GET_FONT = `char_k; end
			`ascii_l: begin GET_FONT = `char_l; end
			`ascii_m: begin GET_FONT = `char_m; end
			`ascii_n: begin GET_FONT = `char_n; end
			`ascii_o: begin GET_FONT = `char_o; end
			`ascii_p: begin GET_FONT = `char_p; end
			`ascii_q: begin GET_FONT = `char_q; end
			`ascii_r: begin GET_FONT = `char_r; end
			`ascii_s: begin GET_FONT = `char_s; end
			`ascii_t: begin GET_FONT = `char_t; end
			`ascii_u: begin GET_FONT = `char_u; end
			`ascii_v: begin GET_FONT = `char_v; end
			`ascii_w: begin GET_FONT = `char_w; end
			`ascii_x: begin GET_FONT = `char_x; end
			`ascii_y: begin GET_FONT = `char_y; end
			`ascii_z: begin GET_FONT = `char_z; end
			`ascii_wave: begin GET_FONT = `char_wave; end  //`和~
			`ascii_sub : begin GET_FONT = `char_sub; end   //_和-
			`ascii_equal : begin GET_FONT = `char_equal; end   //=和+
			`ascii_left_bracket : begin GET_FONT = `char_left_bracket; end   //[和{
			`ascii_right_bracket : begin GET_FONT = `char_right_bracket; end   //]和}
			`ascii_or : begin GET_FONT = `char_or; end   //\和|
			`ascii_colon : begin GET_FONT = `char_colon; end   // 和：
			`ascii_quotes : begin GET_FONT = `char_quotes; end   //'和"
			`ascii_comma : begin GET_FONT = `char_comma; end    //和<
			`ascii_dot : begin GET_FONT = `char_dot; end   //.和>
			`ascii_div : begin GET_FONT = `char_div; end   ///和?
			`ascii_shift_a	: begin GET_FONT = `char_A; end			
			`ascii_shift_b	: begin GET_FONT = `char_B; end	
			`ascii_shift_c	: begin GET_FONT = `char_C; end	
			`ascii_shift_d	: begin GET_FONT = `char_D; end		
			`ascii_shift_e	: begin GET_FONT = `char_E; end			
			`ascii_shift_f	: begin GET_FONT = `char_F; end
			`ascii_shift_g	: begin GET_FONT = `char_G; end			
			`ascii_shift_h	: begin GET_FONT = `char_H; end		
			`ascii_shift_i	: begin GET_FONT = `char_I; end		
			`ascii_shift_j	: begin GET_FONT = `char_J; end			
			`ascii_shift_k	: begin GET_FONT = `char_K; end			
			`ascii_shift_l	: begin GET_FONT = `char_L; end			
			`ascii_shift_m	: begin GET_FONT = `char_M; end		
			`ascii_shift_n	: begin GET_FONT = `char_N; end			
			`ascii_shift_o	: begin GET_FONT = `char_O; end			
			`ascii_shift_p	: begin GET_FONT = `char_P; end			
			`ascii_shift_q	: begin GET_FONT = `char_Q; end		
			`ascii_shift_r	: begin GET_FONT = `char_R; end		
			`ascii_shift_s	: begin GET_FONT = `char_S; end			
			`ascii_shift_t	: begin GET_FONT = `char_T; end			
			`ascii_shift_u	: begin GET_FONT = `char_U; end			
			`ascii_shift_v	: begin GET_FONT = `char_V; end		
			`ascii_shift_w	: begin GET_FONT = `char_W; end			
			`ascii_shift_x	: begin GET_FONT = `char_X; end			
			`ascii_shift_y	: begin GET_FONT = `char_Y; end			
			`ascii_shift_z	: begin GET_FONT = `char_Z; end
			`ascii_shift_1 : begin GET_FONT = `char_shift_1; end
			`ascii_shift_2 : begin GET_FONT = `char_shift_2; end 
			`ascii_shift_3 : begin GET_FONT = `char_shift_3; end 
			`ascii_shift_4 : begin GET_FONT = `char_shift_4; end 
			`ascii_shift_5 : begin GET_FONT = `char_shift_5; end 
			`ascii_shift_6 : begin GET_FONT = `char_shift_6; end 
			`ascii_shift_7 : begin GET_FONT = `char_shift_7; end
			`ascii_shift_8 : begin GET_FONT = `char_shift_8; end
			`ascii_shift_9 : begin GET_FONT = `char_shift_9; end 
			`ascii_shift_0 : begin GET_FONT = `char_shift_0; end 
			`ascii_shift_wave : begin GET_FONT = `char_shift_wave; end  //`和~
			`ascii_shift_sub : begin GET_FONT = `char_shift_sub; end  //_和-
			`ascii_shift_equal : begin GET_FONT = `char_shift_equal; end  //=和+
			`ascii_shift_left_bracket : begin GET_FONT = `char_shift_left_bracket; end  //[和{
			`ascii_shift_right_bracket : begin GET_FONT = `char_shift_right_bracket; end  //]和}
			`ascii_shift_or : begin GET_FONT = `char_shift_or; end  //\和|
			`ascii_shift_colon : begin GET_FONT = `char_shift_colon; end  // 和：
			`ascii_shift_quotes : begin GET_FONT = `char_shift_quotes; end  //'和"
			`ascii_shift_comma : begin GET_FONT = `char_shift_comma; end  //和<
			`ascii_shift_dot : begin GET_FONT = `char_shift_dot; end  //.和>
			`ascii_shift_div : begin GET_FONT = `char_shift_div; end  ///和?
			default: begin GET_FONT = 128'd0; end
		endcase
	endfunction
	
	reg [31:0] i, j;
	reg [31:0] screen_col;
	reg [7:0] asc_code;
	reg [127:0] char_reg;
	reg [15:0] buf_start;
	reg [15:0] last_buf_start;
	reg [7:0] color1, color2;
	initial begin
		last_buf_start = `VGA_BUF2_START;
		screen_col = 32'd0;
		i = 32'd0;
		j = 32'd0;
		color1 = 8'd0;
		color2 = 8'd0;
	end
	always @(posedge CLK50MHz) begin
		if(XCoord < 640 && YCoord < 480) begin
			buf_start = (YCoord[4]==0)?`VGA_BUF2_START:`VGA_BUF1_START;
			if(buf_start == last_buf_start && screen_col < screen_width) begin
				RADDR_IO = `CHA_BUF_START + ((YCoord >> 4)*80 + screen_col)>>1;
				asc_code = (screen_col[0]==0)?DATA_OUT_IO[15:8]:DATA_OUT_IO[7:0];
				char_reg = GET_FONT(asc_code);
				WADDR_VGA = buf_start + ((i*640+j+screen_col*8)>>1);
				color1 = (char_reg[`PIXEL_NUM-1-(`PIXEL_COL*i+j)] == 1)?`FONT_COLOR:8'd0;
				color2 = (char_reg[`PIXEL_NUM-1-(`PIXEL_COL*i+j+1)] == 1)?`FONT_COLOR:8'd0;
				DATA_IN_VGA = {color1, color2};
				j = j + 2;
				if(j>=`PIXEL_COL) begin
					j = 0;
					i = i+1;
				end
				if(i>=`PIXEL_ROW) begin
					screen_col = screen_col + 1;
					i = 0;
					j = 0;
				end
			end
			else if(buf_start == last_buf_start && screen_col >= screen_width)begin
				MW_VGA_ON = 0;
			end 
			else begin
				screen_col = 0;
				last_buf_start = buf_start;
				MW_VGA_ON = 1;
			end
		end
	end
endmodule
