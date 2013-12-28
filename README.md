#mipscpu


Yes, it is a cpu that implements the mips instruction.  
In this simple implementation, both the instruction and data handled are 16 bits.  
Refered to the MIPS ,we designed our instructio as follows:



    void advance_pc (Byte offset){
         PC  =  nPC;
         nPC  += offset;
    }
##Instruction Set
###Support  
* halt 
>Description:  
Set IR 0000 0000 0000 0000,do nothing. 
Operation:  
advance_pc (0);  
Syntax:  
halt 
Encoding:  
0000 0000 0000 0000


* lw reg1 im
>Description:  
A word is loaded into a register from the specified address.  
Operation:  
$s = MEM[im]; advance_pc (1);  
Syntax:  
lw $s, im  
Encoding:  
0001 ssss iiii iiii


* sw reg1 im
>Description:  
The contents of $s is stored at the specified address.  
Operation:  
MEM[im] = $s ; advance_pc (1);  
Syntax:  
sw $s, im  
Encoding:  
0011 ssss iiii iiii  


* and reg1 reg2 reg3 
>Description:  
Adds two registers and stores the result in a register  
Operation:  
$d = $s + $t; advance_pc (1);  
Syntax:  
add $d, $s, $t  
Encoding:  
0101 dddd ssss tttt




* or reg1 reg2 reg3
>Description:  
Bitwise logical ors two registers and stores the result in a register  
Operation:  
$d = $s | $t; advance_pc (1);  
Syntax:  
or $d, $s, $t  
Encoding:  
0110 dddd ssss tttt

* add reg1 reg2 reg3
> Description:  
adds two registers and stores the result in a registe  
Operation:  
$d = $s + $t; advance_pc (1);  
Syntax:  
add $d, $s, $t  
Encoding:  
0111 dddd ssss tttt

* sub reg1 reg2 reg3
>Description:  
Subtracts two registers and stores the result in a register  
Operation:  
$d = $s - $t; advance_pc (1);  
Syntax:  
sub $d, $s, $t  
Encoding:  
1000 dddd ssss tttt

* slt reg1 reg2 reg3
>Description:  
If $s is less than $t, $d is set to one. It gets zero otherwise.  
Operation:  
if $s < $t $d = 1; advance_pc (1); else $d = 0; advance_pc (1);  
Syntax:  
slt $d, $s, $t  
Encoding:  
1001 dddd ssss tttt

* beq reg1 reg2 offset
>Description:  
Branches if the two registers are equal  
Operation:  
if $s == $t advance_pc (offset)); else advance_pc (1);  
Syntax:  
beq $s, $t, offset  
Encoding:  
1010 ssss tttt iiii

* j target
>Description:  
Jumps to the calculated address  
Operation:  
PC = target  
Syntax:  
j target  
Encoding:  
1011 tttt tttt 0000

* addi reg1 im
>Description:  
Adds zero and a sign-extended immediate value and stores the result in a register  
Operation:  
$s = 0 + imm; advance_pc (1);  
Syntax:  
addi $s, imm  
Encoding:  
1100 ssss iiii iiii


Some constant definitions to note when use the instructions
IR_ADDR = 4'b0000

###Not Support Yet

* lb reg1  im
>Description:  
A word is loaded into a register from the specified address.  
Operation:  
$s = MEM[im]; advance_pc (1);  
Syntax:  
lw $s, im  
Encoding:  
0010 ssss iiii iiii

* sb reg1 im
>Description:  
The contents of $s is stored at the specified address.  
Operation:  
MEM[im] = $s; advance_pc (1);  
Syntax:  
sw $s, im  
Encoding:  
0100 ssss iiii iiii  


##Define
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

    `define STAGE1 4'b0001
    `define STAGE2'b0010
    `define STAGE3 4'b0100
    `define STAGE4 4'b1000

    `define GET_OP 15:12
    `define GET_REG1 11:8
    `define GET_REG2 7:4
    `define GET_REG3 4:0
    `define GET_IM 7:0
    `define GET_OFFSET 3:0
    `define GET_TARGET 12:4

