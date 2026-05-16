org 0x8000
cpu 8086
bits 16

start:
    cli

.load_kernel:
    ; Load foamkrnl.sys (example: 4 sectors at sector 4)

    mov ah, 0x02
    mov al, 4
    mov ch, 0
    mov cl, 4
    mov dh, 0
    mov dl, 0x00

    mov bx, 0x1000
    mov es, bx
    xor bx, bx

    int 0x13
    jc disk_error

    jmp 0x1000:0000

disk_error:
    jmp $