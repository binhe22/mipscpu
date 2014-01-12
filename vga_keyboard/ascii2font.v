`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:41:58 01/05/2014 
// Design Name: 
// Module Name:    ascii2font 
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
parameter char_1 = 512'h00_00_00_00_00_00_00_00_00_00_00_00_00_80_01_80_1F_80_01_80_01_80_01_80_01_80_01_80_01_80_01_80_01_80_01_80_01_80_01_80_01_80_01_80_01_80_01_80_01_80_03_C0_1F_F8_00_00_00_00_00_00_00_00_00_00;//"1",0
parameter char_2 = 512'h00_00_00_00_00_00_00_00_00_00_00_00_07_E0_08_38_10_18_20_0C_20_0C_30_0C_30_0C_00_0C_00_18_00_10_00_20_00_40_00_80_01_00_02_00_04_04_08_04_10_04_20_0C_3F_F8_3F_F8_00_00_00_00_00_00_00_00_00_00;//"2",1
parameter char_3 = 512'h00_00_00_00_00_00_00_00_00_00_00_00_07_C0_18_70_30_30_30_18_30_18_30_18_00_18_00_30_00_60_03_C0_00_70_00_18_00_08_00_0C_00_0C_30_0C_30_0C_30_08_30_18_18_30_07_C0_00_00_00_00_00_00_00_00_00_00;//"3",2
parameter char_4 = 512'h00_00_00_00_00_00_00_00_00_00_00_00_00_30_00_70_00_70_00_F0_01_70_01_70_02_70_06_70_04_70_08_70_08_70_10_70_20_70_20_70_7F_FE_00_70_00_70_00_70_00_70_00_70_00_70_03_FE_00_00_00_00_00_00_00_00;//"4",3
parameter char_5 = 512'h00_00_00_00_00_00_00_00_00_00_00_00_0F_FC_0F_FC_08_00_08_00_08_00_10_00_10_00_13_E0_14_30_18_18_10_08_00_0C_00_0C_00_0C_00_0C_30_0C_30_0C_20_18_20_18_10_30_0F_C0_00_00_00_00_00_00_00_00_00_00;//"5",4
parameter char_6 = 512'h00_00_00_00_00_00_00_00_00_00_00_00_01_F0_03_08_04_0C_08_0C_18_00_18_00_10_00_30_00_31_F0_36_18_3C_0C_38_06_30_06_30_06_30_06_30_06_18_06_18_04_0C_0C_06_18_03_E0_00_00_00_00_00_00_00_00_00_00;//"6",5
parameter char_7 = 512'h00_00_00_00_00_00_00_00_00_00_00_00_1F_FC_1F_FC_38_08_30_10_20_10_20_20_00_20_00_40_00_40_00_80_00_80_00_80_01_00_01_00_01_00_03_00_03_00_03_00_03_00_03_00_03_00_00_00_00_00_00_00_00_00_00_00;//"7",6
parameter char_8 = 512'h00_00_00_00_00_00_00_00_00_00_00_00_07_E0_0C_30_18_18_30_0C_30_0C_30_0C_38_0C_1C_18_0E_10_07_E0_0D_E0_18_70_30_38_60_1C_60_0C_60_0C_60_0C_60_0C_30_18_18_30_07_C0_00_00_00_00_00_00_00_00_00_00;//"8",7
parameter char_9 = 512'h00_00_00_00_00_00_00_00_00_00_00_00_07_C0_18_20_30_10_30_18_60_08_60_0C_60_0C_60_0C_60_0C_60_1C_30_3C_18_6C_0F_8C_00_0C_00_18_00_18_00_18_30_30_30_60_30_C0_0F_80_00_00_00_00_00_00_00_00_00_00;//"9",8
parameter char_0 = 512'h00_00_00_00_00_00_00_00_00_00_00_00_03_E0_06_30_0C_18_18_0C_18_0C_18_04_30_06_30_06_30_06_30_06_30_06_30_06_30_06_30_06_30_06_18_04_18_0C_18_0C_0C_18_06_30_03_E0_00_00_00_00_00_00_00_00_00_00;//"0",9
parameter char_a = 512'h00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_0F_C0_18_60_30_30_30_30_00_30_01_F0_0E_30_38_30_30_30_60_30_60_30_60_32_30_F2_1F_1C_00_00_00_00_00_00_00_00_00_00;//"a",0
parameter char_b = 512'h00_00_00_00_00_00_00_00_00_00_08_00_78_00_18_00_18_00_18_00_18_00_18_00_18_00_18_F0_1B_18_1C_0C_1C_06_18_06_18_06_18_06_18_06_18_06_18_06_18_04_1C_0C_1E_18_13_E0_00_00_00_00_00_00_00_00_00_00;//"b",1
parameter char_c = 512'h00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_03_E0_0E_30_18_18_18_18_30_18_30_00_30_00_30_00_30_00_30_04_18_04_18_08_0C_10_03_E0_00_00_00_00_00_00_00_00_00_00;//"c",2
parameter char_d = 512'h00_00_00_00_00_00_00_00_00_00_00_08_00_78_00_18_00_18_00_18_00_18_00_18_00_18_07_D8_0C_38_18_18_18_18_30_18_30_18_30_18_30_18_30_18_30_18_10_18_18_38_0C_5E_07_90_00_00_00_00_00_00_00_00_00_00;//"d",3
parameter char_e = 512'h00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_03_E0_0C_30_18_18_10_08_30_0C_30_0C_3F_FC_30_00_30_00_30_00_18_04_18_08_0E_18_03_E0_00_00_00_00_00_00_00_00_00_00;//"e",4
parameter char_f = 512'h00_00_00_00_00_00_00_00_00_00_00_00_00_7C_01_C3_01_03_03_03_03_00_03_00_03_00_3F_F8_03_00_03_00_03_00_03_00_03_00_03_00_03_00_03_00_03_00_03_00_03_00_03_00_1F_F0_00_00_00_00_00_00_00_00_00_00;//"f",5
parameter char_g = 512'h00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_03_EE_0C_36_08_18_18_18_18_18_18_18_08_18_0C_30_0F_E0_18_00_18_00_0F_F0_0F_FC_10_0E_30_06_30_06_30_06_1C_1C_07_F0;//"g",6
parameter char_h = 512'h00_00_00_00_00_00_00_00_00_00_08_00_78_00_18_00_18_00_18_00_18_00_18_00_18_00_19_F0_1B_18_1C_0C_18_0C_18_0C_18_0C_18_0C_18_0C_18_0C_18_0C_18_0C_18_0C_18_0C_7E_3F_00_00_00_00_00_00_00_00_00_00;//"h",7
parameter char_i = 512'h00_00_00_00_00_00_00_00_00_00_00_00_01_C0_01_C0_01_C0_00_00_00_00_00_00_00_80_1F_80_01_80_01_80_01_80_01_80_01_80_01_80_01_80_01_80_01_80_01_80_01_80_01_80_1F_F8_00_00_00_00_00_00_00_00_00_00;//"i",8
parameter char_j = 512'h00_00_00_00_00_00_00_00_00_00_00_00_00_1C_00_1C_00_1C_00_00_00_00_00_00_00_08_01_F8_00_18_00_18_00_18_00_18_00_18_00_18_00_18_00_18_00_18_00_18_00_18_00_18_00_18_00_18_00_18_18_30_18_60_0F_C0;//"j",9
parameter char_k = 512'h00_00_00_00_00_00_00_00_00_00_08_00_78_00_18_00_18_00_18_00_18_00_18_00_18_00_18_7C_18_30_18_60_18_C0_18_80_19_80_1B_80_1C_C0_18_E0_18_60_18_30_18_38_18_18_7E_3E_00_00_00_00_00_00_00_00_00_00;//"k",10
parameter char_l = 512'h00_00_00_00_00_00_00_00_00_00_00_80_1F_80_01_80_01_80_01_80_01_80_01_80_01_80_01_80_01_80_01_80_01_80_01_80_01_80_01_80_01_80_01_80_01_80_01_80_01_80_01_80_1F_F8_00_00_00_00_00_00_00_00_00_00;//"l",11
parameter char_m = 512'h00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_10_00_77_38_39_CC_31_8C_31_8C_31_8C_31_8C_31_8C_31_8C_31_8C_31_8C_31_8C_31_8C_31_8C_7B_DE_00_00_00_00_00_00_00_00_00_00;//"m",12
parameter char_n = 512'h00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_08_00_78_F0_1B_18_1C_0C_18_0C_18_0C_18_0C_18_0C_18_0C_18_0C_18_0C_18_0C_18_0C_18_0C_7E_3F_00_00_00_00_00_00_00_00_00_00;//"n",13
parameter char_o = 512'h00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_03_E0_0E_38_08_0C_18_0C_30_06_30_06_30_06_30_06_30_06_30_06_18_0C_18_0C_0C_18_03_E0_00_00_00_00_00_00_00_00_00_00;//"o",14
parameter char_p = 512'h00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_08_00_79_F0_1A_18_1C_0C_18_04_18_06_18_06_18_06_18_06_18_06_18_06_18_0C_1C_0C_1E_18_19_E0_18_00_18_00_18_00_18_00_7E_00;//"p",15
parameter char_q = 512'h00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_03_C4_0C_3C_18_1C_18_0C_30_0C_30_0C_30_0C_30_0C_30_0C_30_0C_10_0C_18_1C_0C_3C_07_CC_00_0C_00_0C_00_0C_00_0C_00_3F;//"q",16
parameter char_r = 512'h00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_06_00_7E_3C_06_66_06_86_07_00_07_00_06_00_06_00_06_00_06_00_06_00_06_00_06_00_06_00_7F_E0_00_00_00_00_00_00_00_00_00_00;//"r",17
parameter char_s = 512'h00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_07_E4_0C_1C_18_0C_18_04_18_00_0E_00_07_C0_01_F0_00_38_20_0C_20_0C_30_0C_38_18_37_F0_00_00_00_00_00_00_00_00_00_00;//"s",18
parameter char_t = 512'h00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_01_00_01_00_01_00_03_00_07_00_3F_F8_03_00_03_00_03_00_03_00_03_00_03_00_03_00_03_00_03_00_03_04_03_04_01_88_00_F0_00_00_00_00_00_00_00_00_00_00;//"t",19
parameter char_u = 512'h00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_08_04_78_3C_18_0C_18_0C_18_0C_18_0C_18_0C_18_0C_18_0C_18_0C_18_0C_18_0C_18_1C_0C_2F_07_C8_00_00_00_00_00_00_00_00_00_00;//"u",20
parameter char_v = 512'h00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_7E_3C_18_18_18_10_1C_10_0C_20_0C_20_0E_40_06_40_06_40_07_80_03_80_03_80_03_00_01_00_00_00_00_00_00_00_00_00_00_00;//"v",21
parameter char_w = 512'h00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_FB_EF_71_C6_30_C4_31_C4_31_C4_19_C8_19_C8_1A_68_1A_68_0E_70_0E_70_0E_70_04_20_04_20_00_00_00_00_00_00_00_00_00_00;//"w",22
parameter char_x = 512'h00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_3F_7C_0E_10_0E_20_07_20_03_40_03_80_01_C0_01_C0_02_E0_06_60_04_30_08_30_18_18_7C_7E_00_00_00_00_00_00_00_00_00_00;//"x",23
parameter char_y = 512'h00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_7E_3E_18_18_18_10_0C_10_0C_10_0C_20_06_20_06_20_03_40_03_40_03_40_01_80_01_80_01_80_01_00_01_00_01_00_32_00_3C_00;//"y",24
parameter char_z = 512'h00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_3F_F8_30_30_20_70_20_60_00_C0_01_C0_01_80_03_00_07_00_0E_04_0C_04_1C_0C_38_18_3F_F8_00_00_00_00_00_00_00_00_00_00;//"z",25


