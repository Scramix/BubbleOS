org 0x7C00
cpu 8086
bits 16

start:
    cli
    xor ax, ax
    mov ds, ax
    mov es, ax
    mov ss, ax
    mov sp, 0x7C00
    sti

    mov si, msg

.print:
    lodsb
    cmp al, 0
    je .load_fileldr

    mov ah, 0x0E
    int 0x10
    jmp .print

.load_fileldr:
    ; Load FILELDR (2 sectors) into 0x0000:8000

    mov ah, 0x02
    mov al, 2           ; number of sectors
    mov ch, 0
    mov cl, 2           ; sector 2
    mov dh, 0
    mov dl, 0x00

    mov bx, 0x8000
    mov es, bx
    xor bx, bx

    int 0x13
    jc disk_error

    jmp 0x0000:0x8000   ; jump to FILELDR

disk_error:
    jmp $

msg db "Loading BubbleOS...", 0x0D, 0x0A, 0

times 510-($-$$) db 0
dw 0xAA55