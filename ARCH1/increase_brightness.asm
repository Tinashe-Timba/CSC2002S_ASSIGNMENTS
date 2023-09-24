.data
    AVG1:     .asciiz "Average pixel value of the original image:\n"
    AVG2:   .asciiz "Average pixel value of new image:"
    input_filename: .asciiz "C:/Users/3520/Desktop/sample_images/house_64_in_ascii_cr.ppm"
    output_filename: .asciiz "C:/Users/3520/Desktop/sample_images/output.ppm"
   Read_in: .space 50000
   Write: .space
.text
.globl main

main:
#read in the file
     # Open input file
        li $v0, 13          # syscall code for open
        la $a0, input_filename
        li $a1, 0 
        li $a2,0          
        syscall
        move $s0, $v0       # save file descriptor in $s0



    # open output file to be manually created by user
    li $v0, 13
    la $a0, file_out
    li $a1, 1 # writing mode
    li $a2, 0
    syscall
    move $s1, $v0 # Save file descriptor in $s1

INPUT:
     li $v0, 14
    move $a0, $s6
    la $a1, Read_in
    li $a2, 50000
    syscall



#intialising the buffers 
la $s2, Read_in 
la $s3, Write 
la $s4, Write 
li $t1, 0 # Counter


#add the header into the write buffer
HEADER:
lb $t2,($s2)
sb $t3,($s3)

addi $s3,$s3,1
addi $s2,$s2,1

beq $t1,10,newline
j HEADER

newline:
 addi $t1,$t1,1