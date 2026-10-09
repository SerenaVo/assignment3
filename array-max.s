# Write the assembly code for the array_max function
.text
.globl array_max
.type array_max, @function

array_max:
    # rdi = number of elements
    # rsi = address of the array

    movq (%rsi), %rax       # max = nums[0]
    movq $1, %rcx           # i = 1

loop:
    cmpq %rdi, %rcx
    jae done                # if i >= n, finish

    movq (%rsi,%rcx,8), %rdx  # nums[i]
    cmpq %rax, %rdx
    jbe next                # if nums[i] <= max, skip
    movq %rdx, %rax         # max = nums[i]

next:
    incq %rcx
    jmp loop

done:
    ret

.section .note.GNU-stack,"",@progbits
