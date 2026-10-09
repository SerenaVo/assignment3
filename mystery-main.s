
# Write the assembly code for the main function of the mystery program

.text
.globl main
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $16, %rsp
    movq %rsi, -8(%rbp)
    # Check that exactly two arguments were provided
    cmpl $3, %edi
    jne invalid_args

    # Convert argv[1] to long
    movq -8(%rbp), %rax
    movq 8(%rax), %rdi
    call atol
    movq %rax, -16(%rbp)

   # Convert argv[2] to long
   movq -8(%rbp), %rax
   movq 16(%rax), %rdi
   call atol
   movq %rax, %rsi

   # Call crunch(a, b)
   movq -16(%rbp), %rdi
   call crunch

    # Check the result
    cmpq $0, %rax
    jl print_hat
    je print_tea
    jg print_beer

print_hat:
    leaq hat_msg(%rip), %rdi
    call puts
    jmp success

print_tea:
    leaq tea_msg(%rip), %rdi
    call puts
    jmp success

print_beer:
    leaq beer_msg(%rip), %rdi
    call puts
    jmp success

invalid_args:
    leaq error_msg(%rip), %rdi
    call puts
    movl $1, %eax
    leave
    ret

success:
    movl $0, %eax
    leave
    ret

.data
error_msg:
    .asciz "Two arguments required."
hat_msg:
    .asciz "hat"
tea_msg:
    .asciz "tea"
beer_msg:
    .asciz "beer"
