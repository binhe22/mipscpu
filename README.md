mipscpu
=======

Yes, it is a cpu that implements the mips instruction.  
In this simple implementation, both the instruction and data handled are 16 bits.  
Refered to the MIPS ,we designed our instructio as follows:



    void advance_pc (SWORD offset){
         PC  =  nPC;
         nPC  += offset;
    }

* lw reg1 im
>Description:  
A word is loaded into a register from the specified address.  
Operation:  
$s = MEM[im]; advance_pc (2);  
Syntax:  
lw $s, im  
Encoding:  
0001 ssss iiii iiii

* lb reg1  im
>Description:  
A word is loaded into a register from the specified address.  
Operation:  
$s = MEM[im]; advance_pc (2);  
Syntax:  
lw $s, im  
Encoding:  
0010 ssss iiii iiii

* sw reg1 im
>Description:  
The contents of $s is stored at the specified address.  
Operation:  
MEM[im] = $s ; advance_pc (2);  
Syntax:  
sw $s, im  
Encoding:  
0011 ssss iiii iiii  

* sb reg1 im
>Description:  
The contents of $s is stored at the specified address.  
Operation:  
MEM[im] = $s; advance_pc (2);  
Syntax:  
sw $s, im  
Encoding:  
0100 ssss iiii iiii  
* and reg1 reg2 reg3 
>Description:  
Adds two registers and stores the result in a register  
Operation:  
$d = $s + $t; advance_pc (2);  
Syntax:  
add $d, $s, $t  
Encoding:  
0101 dddd ssss tttt

* or reg1 reg2 reg3
>Description:  
Bitwise logical ors two registers and stores the result in a register  
Operation:  
$d = $s | $t; advance_pc (2);  
Syntax:  
or $d, $s, $t  
Encoding:  
0110 dddd ssss tttt

* add reg1 reg2 reg3
> Adds two registers and stores the result in a registe  
add $d, $s, $t  
$d = $s + $t; advance_pc (2);  
0111 dddd ssss tttt

* sub reg1 reg2 reg3
>Description:  
Subtracts two registers and stores the result in a register  
Operation:  
$d = $s - $t; advance_pc (2);  
Syntax:  
sub $d, $s, $t  
Encoding:  
1000 dddd ssss tttt

* slt reg1 reg2 reg3
>Description:  
If $s is less than $t, $d is set to one. It gets zero otherwise.  
Operation:  
if $s < $t $d = 1; advance_pc (2); else $d = 0; advance_pc (2);  
Syntax:  
slt $d, $s, $t  
Encoding:  
1001 dddd ssss tttt

* beq reg1 reg2 offset
>Description:  
Branches if the two registers are equal  
Operation:  
if $s == $t advance_pc (offset )); else advance_pc (2);  
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
Adds a register and a sign-extended immediate value and stores the result in a register  
Operation:  
$s = $s + imm; advance_pc (2;  
Syntax:  
addi $s, imm  
Encoding:  
1100 ssss iiii iiii







