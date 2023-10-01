#TMBTIN004
.data
    AVG1:     .asciiz "Average pixel value of the original image:\n"
    AVG2:   .asciiz "\nAverage pixel value of new image:\n"
    input_filename: .asciiz "C:/Users/3520/Desktop/sample_images/jet_64_in_ascii_crlf.ppm"
    output_filename: .asciiz "C:/Users/3520/Desktop/sample_images/output1.ppm"
   Read_in: .space  100000
   Write_OUT: .space 100000
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
    la $a0, output_filename
    li $a1, 1 # writing mode
    li $a2, 0
    syscall
    move $s1, $v0 # Save file descriptor in $s1

INPUT:
     li $v0, 14
    move $a0, $s0
    la $a1, Read_in
    li $a2, 100000
    syscall



#intialising the buffers 
la $s2, Read_in 
la $s3, Write_OUT
la $s4, Write_OUT
li $t1, 0 # Counter


#add the header into the write buffer
HEADER:
lb $t2,($s2)
sb $t2,($s3)

addi $s3,$s3,1
addi $s2,$s2,1

#beq $t2,13,newline
beq $t2,10,newline
j HEADER

newline:
 addi $t1,$t1,1 # count the number of lines
 beq $t1,3,Pixel_read #start reading the pixel values

 j HEADER

 Pixel_read:
    li $t4, 0 # line
    li $t1, 0 # number of digits
    li.d $f6, 0.0 # P1
    li.d $f2, 0.0 # P2
    li $t6, 0 # Line count

String_to_int:

lb $t2,($s2)

beq $t2,10,Line
beq $t2,0,WRITE
#beq $t2,13,Line

#STRING TO  INT conversion
sub $t2,$t2,48
mul $t4,$t4,10
add $t4,$t4,$t2

addi $s2,$s2,1
addi $s3,$s3,1
addi $t1,$t1,1 #increase count

j String_to_int

#end of line
Line:
 addi $t6,$t6,1
 beq $t6,12290,WRITE

 
#pixel sum
 mtc1 $t4, $f0
cvt.d.w $f0, $f0
add.d $f6, $f6, $f0 # Sum for orignal pixels

addi $s2,$s2,1
#when digits are differnet lengths there need to be some chnage to the logic
bgt $t4,244,stay
bgt $t4,89,ADD1
blt $t4,10,ADD1

addi $t4,$t4,10
mtc1 $t4, $f0
cvt.d.w $f0, $f0
add.d $f2, $f2, $f0 # Sum for NEW pixels

li $t8,10
sb $t8,($s3)

j INT_STRING


ADD1:
bgt $t4,99,nADD

addi $t4,$t4,10
mtc1 $t4, $f0
cvt.d.w $f0, $f0
add.d $f2, $f2, $f0 # Sum for NEW pixels

    # Increment addresses and counter
    addi $t1, $t1, 1
    addi $s3, $s3, 1


li $t8,10
sb $t8,($s3)

j INT_STRING


nADD:
addi $t4,$t4,10
mtc1 $t4, $f0
cvt.d.w $f0, $f0
add.d $f2, $f2, $f0 # Sum for NEW pixels


li $t8,10
sb $t8,($s3)
j INT_STRING

stay: #stay at 255 if the result is greater than max pixel value
li $t4,255

mtc1 $t4, $f0
cvt.d.w $f0, $f0
add.d $f2, $f2, $f0 # Sum for NEW pixels

li $t8,10
sb $t8,($s3)

j INT_STRING





INT_STRING:
    beqz $t4, end    # If the integer is 0, conversion is done
    divu $t4, $t4, 10     
    mfhi $t9             
    addi $t9, $t9, 48     # Convert digit to ASCII character
    sb $t9, -1($s3)       
    addi $s3, $s3, -1       # Move the pointer backward    

    j INT_STRING


end:
add $s3,$s3,$t1
addi $s3,$s3,1
li $t1,0

j String_to_int







#write the output to specified output file 

WRITE:
sb $t2,($s3)
sub $s4,$s3,$s4
sub $s4,$s4,2


 li $v0, 15
    move $a0, $s1
    la $a1, Write_OUT
    move $a2, $s4
    syscall

close:
    li $v0, 16          # syscall code for close
    move $a0, $s0       # input file descriptor
    syscall

    li $v0, 16          # syscall code for close
    move $a0, $s1       # output file descriptor
    syscall

#calcualte the avearge
AVG:
 
  li.d $f0, 3133440.0    # 64*64*255*3
    div.d $f6, $f6, $f0
    div.d $f2, $f2, $f0

    # Print RESULTS
    li $v0, 4
    la $a0, AVG1
    syscall

    li $v0, 3
    mov.d $f12, $f6
    syscall

    li $v0, 4
    la $a0, AVG2
    syscall

    li $v0, 3
    mov.d $f12, $f2
    syscall

    # Exit
    li $v0, 10          # syscall code for exit
    syscall
