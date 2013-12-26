//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    09:17:47 12/26/2013 
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
////////////////////////////////////////////////////////////////////////////////////
`define WORD_SIZE 16
`define OP_SIZE 4
`define MEM_SIZE 8
`define OFFSET_SIZE 4
`define TIMER_SIZE 4
`define IR_ADDR 4'b0000

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
`define GET_TARGET word_size-5s:word_size-13

