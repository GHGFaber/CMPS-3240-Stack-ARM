.data
.global string1
string1:
	.ascii	"The %d th fibonacci number is %d!\n\0"
.text
.extern printf
.global main
main:
### SET UP FRAME RECORD ###
# Save FP and LR with pre-indexing, allocated another 16 bytes for temp.
stp	x29, x30, [sp, -16]!
# Set FP
add	x29, sp, 0

### MAIN() LOGIC ###
# Call fib(6)
mov 	x0, 8
bl	fib
# Respond with prompt
mov	x1, 8
add	x2, x0, 0
ldr	x0, =string1
bl	printf

### TAKE DOWN FRAME RECORD ###
ldp	x29, x30, [sp], 16
mov	w0, 0
ret

.global fib
fib:
### SET UP FRAME RECORD ###
# Save FP and LR with pre-indexing, allocated another 16 bytes for temp.
stp	x29, x30, [sp, -32]!
# Set FP
add	x29, sp, 0
# Shadow input argument
str	x0, [sp, 16]

ldr 	x0, [sp, 16]
cmp 	x0, 0
beq 	base0
cmp 	x0, 1
beq 	base1
sub 	x0, x0, 2
bl 	fib
str 	x0, [sp, 24]
ldr 	x0, [sp, 16]
sub 	x0, x0, 1
bl 	fib
ldr 	x9, [sp, 24]
add 	x0, x0, x9

return:
ldp	x29, x30, [sp], 32
ret

base0:
mov    x0, 0
b 	return
base1:
mov	x0, 1
b	return
# return1 block falls through to the return code

