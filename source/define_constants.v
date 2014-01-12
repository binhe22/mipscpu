`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:25:18 12/26/2013 
// Design Name: 
// Module Name:    define_constants 
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
`define WORD_SIZE 16
`define OP_SIZE 4
`define MEM_SIZE 8
`define OFFSET_SIZE 4
`define TIMER_SIZE 4
`define OVERFLOW_ADDR 4'b0111

`define LW 4'b0001
`define LB 4'b0010
`define SW 4'b0011
`define SB 4'b0100
`define AND 4'b0101
`define OR 4'b0110
`define ADD 4'b0111
`define SUB 4'b1000
`define SLT 4'b1001
`define BEQ 4'b1010
`define JUMP 4'b1011
`define ADDI 4'b1100

`define CYCLE1 4'b0001
`define CYCLE2 4'b0010
`define CYCLE3 4'b0100
`define CYCLE4 4'b1000

`define GET_OP word_size-1:word_size-4
`define GET_REG1 word_size-5:word_size-8
`define GET_REG2 word_size-9:word_size-12
`define GET_REG3 word_size-13:word_size-16
`define GET_IM word_size-9:word_size-16
`define GET_OFFSET word_size-13:word_size-16
`define GET_TARGET word_size-5:word_size-12


`define STEP 1'b0
`define AUTO 1'b1

`define PIXEL_NUM 128
`define PIXEL_COL 8
`define PIXEL_ROW 16

`define VGA_BUF1_START 16'h0000  //vga buffer1 memory start addr in vga memory
`define VGA_BUF_SIZE 16'h1400   //a word is 2 bytes
`define VGA_BUF2_START 16'h1400  //16'h0000 + 16'h1400

`define CHA_BUF_START 16'h0000  //in io memory
`define CHA_BUF_SIZE 16'd2400  //80*30 characters
`define FONT_COLOR 8'b00011100

//ascii_code
 `define ascii_1 8'h31 
 `define ascii_2 8'h32 
 `define ascii_3 8'h33 
 `define ascii_4 8'h34 
 `define ascii_5 8'h35 
 `define ascii_6 8'h36 
 `define ascii_7 8'h37 
 `define ascii_8 8'h38 
 `define ascii_9 8'h39 
 `define ascii_0 8'h30 
 `define ascii_a 8'h61 
 `define ascii_b 8'h62 
 `define ascii_c 8'h63 
 `define ascii_d 8'h64 
 `define ascii_e 8'h65 
 `define ascii_f 8'h66 
 `define ascii_g 8'h67 
 `define ascii_h 8'h68 
 `define ascii_i 8'h69 
 `define ascii_j 8'h6a 
 `define ascii_k 8'h6b 
 `define ascii_l 8'h6c 
 `define ascii_m 8'h6d 
 `define ascii_n 8'h6e 
 `define ascii_o 8'h6f 
 `define ascii_p 8'h70 
 `define ascii_q 8'h71 
 `define ascii_r 8'h72 
 `define ascii_s 8'h73 
 `define ascii_t 8'h74 
 `define ascii_u 8'h75 
 `define ascii_v 8'h76 
 `define ascii_w 8'h77 
 `define ascii_x 8'h78 
 `define ascii_y 8'h79 
 `define ascii_z 8'h7a
 `define ascii_shift_a	8'd65			
 `define ascii_shift_b	8'd66		
 `define ascii_shift_c	8'd67			
 `define ascii_shift_d	8'd68			
 `define ascii_shift_e	8'd69			
 `define ascii_shift_f	8'd70	
 `define ascii_shift_g	8'd71			
 `define ascii_shift_h	8'd72		
 `define ascii_shift_i	8'd73			
 `define ascii_shift_j	8'd74			
 `define ascii_shift_k	8'd75			
 `define ascii_shift_l	8'd76			
 `define ascii_shift_m	8'd77		
 `define ascii_shift_n	8'd78			
 `define ascii_shift_o	8'd79			
 `define ascii_shift_p	8'd80			
 `define ascii_shift_q	8'd81		
 `define ascii_shift_r	8'd82		
 `define ascii_shift_s	8'd83			
 `define ascii_shift_t	8'd84			
 `define ascii_shift_u	8'd85			
 `define ascii_shift_v	8'd86		
 `define ascii_shift_w	8'd87			
 `define ascii_shift_x	8'd88			
 `define ascii_shift_y	8'd89			
 `define ascii_shift_z	8'd90 
 `define ascii_wave 8'h60  //`和~
 `define ascii_sub 8'h2d  //_和-
 `define ascii_equal 8'h3d  //=和+
 `define ascii_left_bracket 8'h5b  //[和{
 `define ascii_right_bracket 8'h5d  //]和}
 `define ascii_or 8'h5c  //\和|
 `define ascii_colon 8'h3b  // 和：
 `define ascii_quotes 8'h27  //'和"
 `define ascii_comma 8'h2c  //和<
 `define ascii_dot 8'h2e  //.和>
 `define ascii_div 8'h2f  ///和?
//shift  `define ascii_shift_
 `define ascii_shift_1 8'h21 
 `define ascii_shift_2 8'h40 
 `define ascii_shift_3 8'h23 
 `define ascii_shift_4 8'h24 
 `define ascii_shift_5 8'h25 
 `define ascii_shift_6 8'h5e 
 `define ascii_shift_7 8'h26 
 `define ascii_shift_8 8'h2a 
 `define ascii_shift_9 8'h28 
 `define ascii_shift_0 8'h29 
 `define ascii_shift_wave 8'h7e  //`和~
 `define ascii_shift_sub 8'h5f  //_和-
 `define ascii_shift_equal 8'h2b  //=和+
 `define ascii_shift_left_bracket 8'h7b  //[和{
 `define ascii_shift_right_bracket 8'h7d  //]和}
 `define ascii_shift_or 8'h7c  //\和|
 `define ascii_shift_colon 8'h3a  // 和：
 `define ascii_shift_quotes 8'h22  //'和"
 `define ascii_shift_comma 8'h3c  //和<
 `define ascii_shift_dot 8'h3e  //.和>
 `define ascii_shift_div 8'h3f  ///和?

//key_code
 `define kb_1 8'h16 
 `define kb_2 8'h1e 
 `define kb_3 8'h26 
 `define kb_4 8'h25 
 `define kb_5 8'h2e 
 `define kb_6 8'h36 
 `define kb_7 8'h3d 
 `define kb_8 8'h3e 
 `define kb_9 8'h46 
 `define kb_0 8'h45 
 `define kb_a 8'h1c 
 `define kb_b 8'h32  
 `define kb_c 8'h21 
 `define kb_d 8'h23 
 `define kb_e 8'h24  
 `define kb_f 8'h2b 
 `define kb_g 8'h34 
 `define kb_h 8'h33 
 `define kb_i 8'h43 
 `define kb_j 8'h3b 
 `define kb_k 8'h42 
 `define kb_l 8'h4b 
 `define kb_m 8'h3a 
 `define kb_n 8'h31 
 `define kb_o 8'h44 
 `define kb_p 8'h4d 
 `define kb_q 8'h15 
 `define kb_r 8'h2d 
 `define kb_s 8'h1b 
 `define kb_t 8'h2c 
 `define kb_u 8'h3c 
 `define kb_v 8'h2a 
 `define kb_w 8'h1d 
 `define kb_x 8'h22 
 `define kb_y 8'h35 
 `define kb_z 8'h1a 
 `define kb_wave 8'h0e  //`和~
 `define kb_sub 8'h4e  //_和-
 `define kb_equal 8'h55  //=和+
 `define kb_left_bracket 8'h54  //[和{
 `define kb_right_bracket 8'h5b  //]和}
 `define kb_or 8'h5d  //\和|
 `define kb_colon 8'h4c  // 和：
 `define kb_quotes 8'h52  //'和"
 `define kb_comma 8'h41  //和<
 `define kb_dot 8'h49  //.和>
 `define kb_div 8'h4a  ///和?
//功能键
 `define kb_ESC 8'h76 
 `define kb_F1 8'h05 
 `define kb_F2 8'h06 
 `define kb_F3 8'h04 
 `define kb_F4 8'h0c 
 `define kb_F5 8'h03 
 `define kb_F6 8'h0b 
 `define kb_F7 8'h83 
 `define kb_F8 8'h0a 
 `define kb_F9 8'h01 
 `define kb_F10 8'h09 
 `define kb_F11 8'h78 
 `define kb_F12 8'h07 
 `define kb_TAB 8'h0d 
 `define kb_CAPS 8'h58 
 `define kb_SHIFT_LEFT 8'h12 
 `define kb_SHIFT_RIGHT 8'h59 
 `define kb_CTRL 8'h14  //左边的ctrl是14，右边的alt是E0 14
 `define kb_ALT 8'h11  //左边的alt是11，右边的alt是E0 11
 `define kb_SPACE 8'h29 
 `define kb_ENTER 8'h5A 
 `define kb_BACK 8'h66 
//扩展键（键码E0开头）
 `define kb_UP        8'h75 
 `define kb_DOWN 8'h72 
 `define kb_LEFT 8'h6b 
 `define kb_RIGHT 8'h74 
 
`define char_1 128'h00_00_00_10_70_10_10_10_10_10_10_10_10_7C_00_00;//"1"0
`define char_2 128'h00_00_00_3C_42_42_42_04_04_08_10_20_42_7E_00_00;//"2"1
`define char_3 128'h00_00_00_3C_42_42_04_18_04_02_02_42_44_38_00_00;//"3"2
`define char_4 128'h00_00_00_04_0C_14_24_24_44_44_7E_04_04_1E_00_00;//"4"3
`define char_5 128'h00_00_00_7E_40_40_40_58_64_02_02_42_44_38_00_00;//"5"4
`define char_6 128'h00_00_00_1C_24_40_40_58_64_42_42_42_24_18_00_00;//"6"5
`define char_7 128'h00_00_00_7E_44_44_08_08_10_10_10_10_10_10_00_00;//"7"6
`define char_8 128'h00_00_00_3C_42_42_42_24_18_24_42_42_42_3C_00_00;//"8"7
`define char_9 128'h00_00_00_18_24_42_42_42_26_1A_02_02_24_38_00_00;//"9"8
`define char_0 128'h00_00_00_18_24_42_42_42_42_42_42_42_24_18_00_00;//"0"9
`define char_a 128'h000000000000003C421E2242423F0000
`define char_b 128'h000000C0404040586442424264580000
`define char_c 128'h000000000000001C22404040221C0000
`define char_d 128'h000000060202021E22424242261B0000
`define char_e 128'h000000000000003C427E4040423C0000
`define char_f 128'h0000000F1110107E10101010107C0000
`define char_g 128'h000000000000003E444438403C42423C
`define char_h 128'h000000C04040405C6242424242E70000
`define char_i 128'h000000303000007010101010107C0000
`define char_j 128'h0000000C0C00001C0404040404044478
`define char_k 128'h000000C04040404E4850684844EE0000
`define char_l 128'h000000701010101010101010107C0000
`define char_m 128'h00000000000000FE4949494949ED0000
`define char_n 128'h00000000000000DC6242424242E70000
`define char_o 128'h000000000000003C42424242423C0000
`define char_p 128'h00000000000000D864424242447840E0
`define char_q 128'h000000000000001E22424242221E0207
`define char_r 128'h00000000000000EE3220202020F80000
`define char_s 128'h000000000000003E42403C02427C0000
`define char_t 128'h000000000010107C10101010100C0000
`define char_u 128'h00000000000000C642424242463B0000
`define char_v 128'h00000000000000E74224242810100000
`define char_w 128'h00000000000000D79292AAAA44440000
`define char_x 128'h000000000000006E2418181824760000
`define char_y 128'h00000000000000E742242428181010E0
`define char_z 128'h000000000000007E44081010227E0000
`define char_A 128'h0000001010182828243C444242E70000
`define char_B 128'h000000F8444444784442424244F80000
`define char_C 128'h0000003E424280808080804244380000
`define char_D 128'h000000F8444242424242424244F80000
`define char_E 128'h000000FC424848784848404242FC0000
`define char_F 128'h000000FC424848784848404040E00000
`define char_G 128'h0000003C44448080808E844444380000
`define char_H 128'h000000E7424242427E42424242E70000
`define char_I 128'h0000007C1010101010101010107C0000
`define char_J 128'h0000003E0808080808080808080888F0
`define char_K 128'h000000EE444850705048484444EE0000
`define char_L 128'h000000E0404040404040404042FE0000
`define char_M 128'h000000EE6C6C6C6C5454545454D60000
`define char_N 128'h000000C7626252524A4A4A4646E20000
`define char_O 128'h00000038448282828282828244380000
`define char_P 128'h000000FC424242427C40404040E00000
`define char_Q 128'h00000038448282828282B2CA4C380600
`define char_R 128'h000000FC4242427C4848444442E30000
`define char_S 128'h0000003E4242402018040242427C0000
`define char_T 128'h000000FE921010101010101010380000
`define char_U 128'h000000E74242424242424242423C0000
`define char_V 128'h000000E7424244242428281810100000
`define char_W 128'h000000D692929292AAAA6C4444440000
`define char_X 128'h000000E7422424181818242442E70000
`define char_Y 128'h000000EE444428281010101010380000
`define char_Z 128'h0000007E840408081020204242FC0000

`define char_wave 128'h304C4300000000000000000000000000 //`和~
`define char_sub 128'h00000000000000007F00000000000000  //_和-
`define char_equal 128'h000000000000FE000000FE0000000000  //=和+
`define char_left_bracket 128'h001E1010101010101010101010101E00  //[
`define char_right_bracket 128'h00780808080808080808080808087800  //]和}
`define char_or 128'h00004040202010101008080404040202 //\和|
`define char_colon 128'h00000000000000100000000000101020  // ;
`define char_quotes 128'h00606020C00000000000000000000000  // '
`define char_comma 128'h000000000000000000000000606020C0  // ,
`define char_dot 128'h00000000000000000000000060600000  // .
`define char_div 128'h00000102020404080810102020404000  // /
//shift  `define ascii_shift_
`define char_shift_1 128'h00000010101010101010000018180000 
`define char_shift_2 128'h00000038445AAAAAAAAAB44244380000 
`define char_shift_3 128'h000000242424FE484848FE4848480000 
`define char_shift_4 128'h00001038545450301814145454381010 
`define char_shift_5 128'h00000044A4A8A8A8541A2A2A2A440000
`define char_shift_6 128'h001C2200000000000000000000000000 
`define char_shift_7 128'h00000030484848506EA4948889760000 
`define char_shift_8 128'h000000001010D63838D6101000000000 
`define char_shift_9 128'h00020408081010101010100808040200
`define char_shift_0 128'h00402010100808080808081010204000 
`define char_shift_wave 128'h00601000000000000000000000000000  //`和~
`define char_shift_sub 128'h000000000000000000000000000000FF  //_和-
`define char_shift_equal 128'h0000000010101010FE10101010000000  //=和+
`define char_shift_left_bracket 128'h00030404040404080404040404040300  //[和{
`define char_shift_right_bracket 128'h00601010101010081010101010106000 //}
`define char_shift_or 128'h08080808080808080808080808080808  //\和|
`define char_shift_colon 128'h00000000000018180000000018180000  // ：
`define char_shift_quotes 128'h00123624480000000000000000000000  //"
`define char_shift_comma 128'h00000002040810204020100804020000  //<
`define char_shift_dot 128'h00000040201008040204081020400000  //>
`define char_shift_div 128'h0000003C424262020408080018180000  //?

