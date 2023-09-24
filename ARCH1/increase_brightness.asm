.data
    AVG1:     .asciiz "Average pixel value of the original image:\n"
    AVG2:   .asciiz "Average pixel value of new image:"
    input_filename: .asciiz "C:/Users/3520/Desktop/sample_images/house_64_in_ascii_cr.ppm"
    output_filename: .asciiz "C:/Users/3520/Desktop/sample_images/output.ppm"
    Header: .asciiz "P3\n#J\n64 64"
    file:   .asciiz ""
    int: .space 3
    line: .space 16
.text
.globl main

main:
#read in the file
     # Open input file
        li $v0, 13          # syscall code for open
        la $a0, input_filename
        li $a1, 0           
        syscall
        move $s0, $v0       # save file descriptor in $s0

# Skip the first three lines
#li $t0, 1           # Number of lines to skip

skip_lines_loop:
    # Read a line from the input file
    li $v0, 14           # syscall code for read
    move $a0, $s0        # input file descriptor
    la $a1, line  # buffer to store the line
    li $a2, 15     #read and skip first 15 lines
    syscall


    #print check
    li $v0, 4         # syscall code for print string
    la $a0,line    # Load the address of the result string
    syscall

    # Check if we've skipped the desired number of characters
    #bnez $t0, skip_lines_loop

done_skip_lines:

    move $s2,$zero

 # Read a line from the input file
    li $v0, 14           # syscall code for read
    move $a0, $s2        # input file descriptor
    la $a1, int  # buffer to store the line
    li $a2,  3   #read and skip first 15 char
    syscall

    la $t0,int
    move $t1,$t0  #make t1 == str
    move $s2,$zero #intializ a temp register
    move $t6,$zero


loop:
    lb $t2,($t1) # load byte into t2
    beq $t2,10,Print
    addi $t1,$t1,1 # move onto next character
    sub $t2,$t2,48 #subtract 48 from t2 to give the actual value 
    mul $s2,$s2,10
    add $s2,$s2,$t2
    move $t6,$s2
    j loop


Print:
     li $v0,4
     la $a0,space
     syscall


     li $v0,1
     move $a0,$t6
     syscall

j done_skip_lines





 # Close input and output files
        li $v0, 16          # syscall code for close
        move $a0, $s0       # input file descriptor
        syscall


        # Exit
        li $v0, 10          # syscall code for exit
        syscall