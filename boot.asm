BITS 16
ORG 0x7c00

start:
    mov si, message
.print:
    lodsb
    test al, al
    jz .hang
    mov ah, 0x0e
    int 0x10
    jmp .print

.hang:
    cli
    hlt
    jmp .hang

message db 'Hello, world!', 0

; Pad the boot sector with zeros and add boot signature
TIMES 510-($-$$) db 0
DW 0xaa55
