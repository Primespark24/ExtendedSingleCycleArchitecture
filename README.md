# Digital Design and Computer Architecture
## MIPS 4 Group Project - Extending the Single-Cycle Processor with More Instructions 

### MIPS 4 Overview
The learning goals for MIPS 4 as are follows:

* Extend your knowledge of the MIPS Single-Cycle Processor hardware by implementing new instructions.
* Learn how the VHDL hardware for a MIPS single cycle processor works
* Learn how to implement new instructions for the MIPS single cyle processor


### Grade Break Down
| Part                                              |   | Points  |
|---------------------------------------------------|---|---------|
| MIPS4 - Part 1 - slti and ori                     |10 | 10 pts  |
| MIPS4 - Part 2 - sll and srl                      | 8 | 10 pts  |     
| MIPS4 - Part 3 - control unit and test program    |10 | 10 pts  |  
| MIPS4 - Mini Presentation                         |20 | 20 pts  |    
| Total                                             |48 | 50 pts  |

## Feedback
* for part 2 you put the registers in the wrong field positions. rs is NOT used for sll and slr. Only rd and rt are used for these instructions.
* Good job in getting it working! You probabbly had issues because of the problems with instruction formats in  part 2.

# Introduction

In this lab you will (as a group) expand the MIPS single-cycle processor design even further than last time using VHDL. 
* You will implement four new MIPS instructions. 
* You will then write a new test program that confirms the four new MIPS instructions work. 
* In order to implement four new instructions you likely will need to make changes to the hardware for the processor.  
* By the end of this lab, you should have an even better understanding of the internal operation of the MIPS single-cycle processor and be ready to design your own processor from scratch (the final project).
* _Please read and follow the instructions in this lab carefully.  In the past, many students have lost points for silly errors like failing to include screen snips of the simulation signal traces requested in the lab._

As a group you must work on this part of the project together (on discord or using liveshare).
Make sure that each of you in your group have roughly equal time "driving" while the others looks for errors, discusses the process etc.

Please remember the rules of working together well!
* Share everything ??? work together at the same terminal and not separately.
* Play fair ??? don???t do all the work by yourself, OR hog the computer when typing.
* Don???t hit you partner ??? make sure to share tasks so one partner is not tempted to browse the web, text, etc. Give you partner the benefit of the doubt but also encourage them to contribute.
* Put things back where you found them ??? put away negative thoughts and don???t dwell on them. Focus on the positives.
* Clean up your own mess ??? pair programming will help you catch mistakes early and often.
* Don???t take things too seriously ??? have fun and be proactive.

# MIPS4 Design

Modify the following schematic (if neccessary) to support the four new instructions. This jpg was made from the ```schematic.pptx``` file located in this folder. If you need to modify it in order to support the instructions, you can edit this PowerPoint slide. Once you have modified the slide, you can export it as a jpg into this folder and save it over the existing ```schematic.jpg```. Your changes should then become apparent in this document.  I recommend drawing any new signal wires or components in a different color than in the original schematic.

![Schematic](./img/UpdatedSchematic.png)

## (10 pts) Part 1: Add the two I-type instructions: slti, ori 
Add the two instructions to the VHDL hardware for the MIPS single-cycle processor. First, read Appendix B, table B.1 then complete the follow two markdown tables below so that they contains a binary level description of the assembly language instruction given. This will help you understand the format of the instructions. Then add the instructions to the processor.

### I-type Instruction ```slti```

Complete the following table (use binary bits) for the given instuction. Put the hex code equivalent of the instruction in the space provided below.

| Assembly Code     |  op  | rs  | rt  | imm              | 
|-------------------|------|-----|-----|------------------|
|  slti $7, $5, 15  |001010|00101|00111|0000 0000 0000 1111|

```
Put hex code equivalent here
28A7000F
```

### I-type Instruction ```ori```

Complete the following table (use binary bits) for the given instuction. Put the hex code equivalent of the instruction in the space provided below.

| Assembly Code     |  op  | rs  | rt  | imm              | 
|-------------------|------|-----|-----|------------------|
|   ori $7, $5, 15  |001101|00101|00111|0000 0000 0000 1111|

```
Put hex code equivalent here
34A7000F
```


## (10 pts) Part 2: Add the two R-type instructions: sll, srl 
Add the following two R-type instructions to the VHDL hardware: sll, srl (see appendix B, table B.2). Complete the markdown descriptions of each of the instructions below by completing the instruction in binary and hex. This will help you understand the format of the instructions. Then add the instructions to the processor.

### R-type Instruction sll

Complete the following table (use binary bits) for the given instuction. Put the hex code equivalent of the instruction in the space provided below.

| Assembly Code     |  op  | rs  | rt  | rd  |shamt|funct | 
|-------------------|------|-----|-----|-----|-----|------|
| wrong - sll $7, $5, 4     |000000|00101|00111|00000|00100|000000| 
| corrected - sll $7, $5, 4     |000000|00000|00101|00111|00100|000000| 

```
Put hex code equivalent here
00A70100
```
Complete the following table (use binary bits) for the given instuction. Put the hex code equivalent of the instruction in the space provided below.

### R-type Instruction srl

| Assembly Code     |  op  | rs  | rt  | rd  |shamt|funct | 
|-------------------|------|-----|-----|-----|-----|------|
| wrong - srl $7, $5, 4     |000000|00101|00111|00000|00100|000010|
| corrected - srl $7, $5, 4     |000000|00000|00101|00111|00100|000010|

```
Put hex code equivalent here
00A70102
```

## Part 3: Control Unit Modifications and Test Program

Modify the tables below for the ```main decoder``` and the ```ALU decoder```, as needed, in order to account *for all* the instructions in your processor. You may or may not need to add more control signals.

| **Instruction** | **Op[5:0]** | **RegWrite** | **RegDst** | **AluSrc** | **Branch** | **MemWrite** | **MemtoReg** | **ALUOp[2:0] **|** Jump** |
| --------------- | ----------- | ------------ | ---------- | ---------- | ---------- | ------------ | ------------ | -------------- | -------- |
| R-type          | 000000      | 1 | 1 | 0 | 0 | 0 | 0 | 010 | 0 |
| lw              | 100011      | 1 | 0 | 1 | 0 | 0 | 1 | 000 | 0 |
| sw              | 101011      | 0 | X | 1 | 0 | 1 | X | 000 | 0 |
| beq             | 000100      | 0 | X | 0 | 1 | 0 | X | 001 | 0 |
| addi            | 001000      | 1 | 0 | 1 | 0 | 0 | 0 | 000 | 0 |
| j               | 000010      | 0 | X | X | X | 0 | X | 0XX | 1 |
| slti            | 001010      | 1 | 0 | 1 | 0 | 0 | 0 | 011 | 0 |
| ori             | 001101      | 1 | 0 | 1 | 0 | 0 | 0 | 101 | 0 |
| sll             | 000000 (R)  | 1 | 1 | 0 | 0 | 0 | 0 | 010 | 0 |
| srl             | 000000 (R)  | 1 | 1 | 0 | 0 | 0 | 0 | 010 | 0 |



You may or may not need to add extra ALUOp signals:

| **ALUOp[2:0]**|** Meaning** |
| ------------- | ----------- |
| 000           | Add         |
| 001           | Subtract    |
| 010           | Look at funct field |
| 011           | SLT         |
| 100           | Look at funct field |
| 101           | ORI         |
| 110           | Look at funct field            |
| 111           | Look at funct field            |

## Assembly Language Test Program for your modified MIPS single-cycle processor

For this part your group will create an assembly language test program (```test_4.s```) for the modified MIPS processor that uses all four of the new instructions.
* You may if you wish add more instructions, but, you are not required to at this time. 
* You may also if you wish modify the I/O for the processor, but, you are not required to at this time.

Put the mips assemly language code for your program here (make sure it uses all three of the new instructions):
   
   ```asm
    # test_4.s MIPS Assembly Language Test Program to Test all New Instructions
    #      Assembly                  Description          Address     Machine Code
main:   addi $2, $0, 5          # initialize $2 = 5         0           20020005        
           addi $3, $0, 12         # initialize $3 = 12        4           2003000c
           ori  $4, $3, 2          # OR bits of $3 and 2       c           34640002
           slti $4, $2, 4          # Checks if $4 < $2         10          28440004
           beq  $4, $0, sltiTJ     # should be taken           14          10800001
           addi $2, $0, 12         # shouldn't happen          18          2003000c
sltiTJ: sll  $6, $3, 4          # Shift $1 4bits left       1c          00033100
           srl  $7, $3, 1          # Shift $2 1 bit right      20          00033842
           or   $4, $2, $3         # $4 <= 3 or 5 = 7          24          00432025
           and  $5, $2, $3         # $5 <= 12 and 7 = 4        28          00432824
           sub  $2, $2, $2         # $2 = $2 - $2 = 0          2c          00421022
           j    end                # should be taken           30          08000011
           addi $2, $0, 1          # shouldn't happen          34          20020001
end:    sw   $2, 84($0)         # write adr 84 = 7          38          ac020054
           j    main               # restart                   3c          08000000
   ```


## Translate to Machine Code
Translate your assembly language program to machine code. Create a hex machine code file named ```memfile_4.dat``` that will contain the "assembled" program. You will need to modify the VHDL impure function code that load the machine code instructions. You will need to modify it to load ```memfile_4.dat```. 

Also, include the hexcode directly here:

  Hex Code for the test program
  ```
  20020005
  2003000c
  34640002
  28440004
  10800001
  2003000c
  00033100
  00033842
  00432025
  00432824
  00421022
  08000011
  20020001
  ac020054
  08000000
  ```

  NOTE: You may if you wish use PCSpim to generate part of the machine code for ```memfile_4.dat``` from the file ```test_4.s```. Remember that QTSpim will NOT give you the correct machine code for any of the jump or branching statements in your program! 
  
  The generated instruction machine code for jumps and branches may differ from what is needed for your machine. For example:
  * Our machine code starts the text segment at address ```0x00000000``` instead of ```0x00400000``` 
  * Our memory starts at address ```0x00000000``` in data memory rather than ```0x10000000```. 
  
  You will need to figure out how to generate the correct the machine code instructions so that the code works on our mips machine!

## Simulation of the Test Program
Generate a simulation waveform that shows that your group's test program is running correctly on the MIPS simulator. You must use the following signals in your simulation waveform trace:

  ```
  clk, reset, pcsrc, pc, branch, instr, srca, srcb, aluout, zero, writedata, memwrite, readdata 
  ```
  Include these signlas in that **exact** order! Make sure all your waveforms are readable and show values in hexadecimal. Take enough screen shots of the simulation trace (as you did before) and include them in this document directly here to demonstrate that your code is working. Make sure the waveforms are readable:

  ### Simulation Waveform Images

![WaveForm](./img/Waveform.png)

## Running the MIPS Test program on the FPGA

Make sure your ```test_4``` program can run successfully on the FPGA. Remember the clock on the FPGA has been slowed down in order to verify that the program works correctly. 

## Summary of Deliverables in this Project Folder

Please submit each of the following items, clearly labeled and in the following order:

1. This entire document with the entries filled out as requested in this document.
2. The modified **vhdl** and **dat** files for the exercises as described above.
3. Follow instructions **carefully** for the simulation waveforms and tables. 
   
Because of the high standards we have for our Whitworth students, we want you to do this correctly. For the waveforms, you will need to take multiple screen shots of the simulation trace and include them in this document as required.

# MIPS4 - Mini Presentation 

On the due date for this design, groups will take 5 minutes (max) and present their hardware design and test algorithm to the class. Your group will be graded on whether you present the following items. **Do not use more than 4 or 5 slides to summarize your project.**

* **Minute 1**: What hardware changes did you make to MIPS to accommodate the four instructions? Show a diagram of the changes. 
  
* **Minute 2**: Show the corresponding VHDL changes for the hardware changes that were made.

* **Minute 3**: A neat assembly language listing of your MIPS test program. You must include comments.

* **Minute 4**: An image (or video) of yuour program running on the FPGA.

* **Minute 5**: A discussion of the process and result. 
  - What went well? What not so well?
  - Did you get both simulation and FPGA working?
  - Did you do anything above and beyond the requirements (not required)?
