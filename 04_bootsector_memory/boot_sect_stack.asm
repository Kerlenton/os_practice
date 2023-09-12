mov ah, 0x0e ; TTY mode.

mov bp, 0x8000 ; This is an address far away from 0x7c00 so that we don't get overwritten.
mov sp, bp ; If the stack is empty then sp points to bp.

push 'A'
push 'B'
push 'C'

; To show how the stack grows downwards.
mov al, [0x7ffe] ; 0x8000 - 2
int 0x10

; However, don't try to access [0x8000] now, because it won't work.
; You can only access the stack top so, at this point, only 0x7ffe (look above).
mov al, [0x8000]
int 0x10

; Recover our characters using the standard procedure: 'pop'.
; We can only pop full words so we need an auxiliary register manipulate.
pop bx
mov al, bl
int 0x10 ; prints C

pop bx
mov al, bl
int 0x10 ; prints B

pop bx
mov al, bl
int 0x10 ; prints A

; Data that has been pop'd from the stack is garbage now.
mov al, [0x8000]
int 0x10

jmp $
times 510-($-$$) db 0
dw 0xaa55
