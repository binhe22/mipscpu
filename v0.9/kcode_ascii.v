`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:25:51 01/08/2014 
// Design Name: 
// Module Name:    kcode_ascii 
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
module kcode_ascii(input KCLK, input KCOME, input [7:0] KCODE, 
					output reg [15:0] WADDR_SCREEN, DATA_IN_SCREEN, output reg MW_SCREEN_ON);	
					
	function [7:0] GET_ASCII;
		input [7:0] kcode;
		input is_shift;
		case(kcode) 
			`kb_1: GET_ASCII = (is_shift)?`ascii_shift_1:`ascii_1;
			`kb_2: GET_ASCII = (is_shift)?`ascii_shift_2:`ascii_2;
			`kb_3: GET_ASCII = (is_shift)?`ascii_shift_3:`ascii_3;
			`kb_4: GET_ASCII = (is_shift)?`ascii_shift_4:`ascii_4;
			`kb_5: GET_ASCII = (is_shift)?`ascii_shift_5:`ascii_5;
			`kb_6: GET_ASCII = (is_shift)?`ascii_shift_6:`ascii_6;
			`kb_7: GET_ASCII = (is_shift)?`ascii_shift_7:`ascii_7;
			`kb_8: GET_ASCII = (is_shift)?`ascii_shift_8:`ascii_8;
			`kb_9: GET_ASCII = (is_shift)?`ascii_shift_9:`ascii_9;
			`kb_0: GET_ASCII = (is_shift)?`ascii_shift_0:`ascii_0;
			`kb_a: GET_ASCII = (is_shift)?`ascii_shift_a:`ascii_a;
			`kb_b: GET_ASCII = (is_shift)?`ascii_shift_b:`ascii_b;
			`kb_c: GET_ASCII = (is_shift)?`ascii_shift_c:`ascii_c;
			`kb_d: GET_ASCII = (is_shift)?`ascii_shift_d:`ascii_d;
			`kb_e: GET_ASCII = (is_shift)?`ascii_shift_e:`ascii_e;
			`kb_f: GET_ASCII = (is_shift)?`ascii_shift_f:`ascii_f;
			`kb_g: GET_ASCII = (is_shift)?`ascii_shift_g:`ascii_g;
			`kb_h: GET_ASCII = (is_shift)?`ascii_shift_h:`ascii_h;
			`kb_i: GET_ASCII = (is_shift)?`ascii_shift_i:`ascii_i;
			`kb_j: GET_ASCII = (is_shift)?`ascii_shift_j:`ascii_j;
			`kb_k: GET_ASCII = (is_shift)?`ascii_shift_k:`ascii_k;
			`kb_l: GET_ASCII = (is_shift)?`ascii_shift_l:`ascii_l;
			`kb_m: GET_ASCII = (is_shift)?`ascii_shift_m:`ascii_m;
			`kb_n: GET_ASCII = (is_shift)?`ascii_shift_n:`ascii_n;
			`kb_o: GET_ASCII = (is_shift)?`ascii_shift_o:`ascii_o;
			`kb_p: GET_ASCII = (is_shift)?`ascii_shift_p:`ascii_p;
			`kb_q: GET_ASCII = (is_shift)?`ascii_shift_q:`ascii_q;
			`kb_r: GET_ASCII = (is_shift)?`ascii_shift_r:`ascii_r;
			`kb_s: GET_ASCII = (is_shift)?`ascii_shift_s:`ascii_s;
			`kb_t: GET_ASCII = (is_shift)?`ascii_shift_t:`ascii_t;
			`kb_u: GET_ASCII = (is_shift)?`ascii_shift_u:`ascii_u;
			`kb_v: GET_ASCII = (is_shift)?`ascii_shift_v:`ascii_v;
			`kb_w: GET_ASCII = (is_shift)?`ascii_shift_w:`ascii_w;
			`kb_x: GET_ASCII = (is_shift)?`ascii_shift_x:`ascii_x;
			`kb_y: GET_ASCII = (is_shift)?`ascii_shift_y:`ascii_y;
			`kb_z: GET_ASCII = (is_shift)?`ascii_shift_z:`ascii_z;
			`kb_wave: GET_ASCII = (is_shift)?`ascii_shift_wave:`ascii_wave; //`和~
			`kb_sub: GET_ASCII = (is_shift)?`ascii_shift_sub:`ascii_sub;  //_和-
			`kb_equal: GET_ASCII = (is_shift)?`ascii_shift_equal:`ascii_equal;//=和+
			`kb_left_bracket: GET_ASCII = (is_shift)?`ascii_shift_left_bracket:`ascii_left_bracket;  //[和{
			`kb_right_bracket: GET_ASCII = (is_shift)?`ascii_shift_right_bracket:`ascii_right_bracket;  //]和}
			`kb_or: GET_ASCII = (is_shift)?`ascii_shift_or:`ascii_or;  //\和|
			`kb_colon: GET_ASCII = (is_shift)?`ascii_shift_colon:`ascii_colon;  // 和：
			`kb_quotes: GET_ASCII = (is_shift)?`ascii_shift_quotes:`ascii_quotes;  //'和"
			`kb_comma: GET_ASCII = (is_shift)?`ascii_shift_comma:`ascii_comma;  //,和<
			`kb_dot: GET_ASCII = (is_shift)?`ascii_shift_dot:`ascii_dot;  //.和>
			`kb_div: GET_ASCII = (is_shift)?`ascii_shift_div:`ascii_div;  ///和?
			default: GET_ASCII = 8'h00;
		endcase
	endfunction
	
	reg [7:0] last_kcode;
	reg [31:0] cha_buf_count;
	reg is_shift;
	reg last_is_shift;
	reg is_f0;
	initial begin
		last_kcode = 8'h00;
		cha_buf_count = 32'd80;
		is_shift = 0;
		last_is_shift = 0;
		is_f0 = 0;
	end
	always @(negedge KCLK) begin
		MW_SCREEN_ON = 0;
		if(KCOME) begin
			case (KCODE)
				`kb_1, `kb_2, `kb_3, `kb_4, `kb_5, `kb_6, `kb_7, `kb_8, `kb_9, `kb_0,
				`kb_a, `kb_b, `kb_c, `kb_d, `kb_e, `kb_f, `kb_g, `kb_h, `kb_i, `kb_j,
				`kb_k, `kb_l, `kb_m, `kb_n, `kb_o, `kb_p, `kb_q, `kb_r, `kb_s, `kb_t,
				`kb_u, `kb_v, `kb_w, `kb_x, `kb_y, `kb_z, `kb_wave, `kb_sub, `kb_equal,
				`kb_left_bracket, `kb_right_bracket, `kb_or, `kb_colon, `kb_quotes, `kb_comma,
				`kb_dot, `kb_div, `kb_SPACE: begin
					if(is_f0) begin
						is_f0 = 0;
					end
					else begin
						if(cha_buf_count[0]) begin
							WADDR_SCREEN = `SCREEN_BUF_START + (cha_buf_count>>1);
							DATA_IN_SCREEN = {GET_ASCII(last_kcode, last_is_shift), GET_ASCII(KCODE, is_shift)};
							MW_SCREEN_ON = 1;
						end 
						else begin
							WADDR_SCREEN = `SCREEN_BUF_START + (cha_buf_count>>1);
							DATA_IN_SCREEN = {GET_ASCII(KCODE, is_shift), 8'd0};
							MW_SCREEN_ON = 1;
							last_kcode = KCODE;
							last_is_shift = is_shift;
						end
						cha_buf_count = cha_buf_count + 1;
						is_shift = 0;
						if(cha_buf_count>`SCREEN_BUF_SIZE) begin
							cha_buf_count = 0;
						end
					end
				end
				`kb_SHIFT_LEFT, `kb_SHIFT_RIGHT: begin
					if(is_f0) begin
						is_f0 = 0;
					end
					else begin
						is_shift = 1;
					end
				end
				8'hF0: begin
					is_f0 = 1;
				end
				default: begin
					MW_SCREEN_ON = 0;
				end
			endcase
		end
	end
endmodule
