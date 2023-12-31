print:
    pusha

; Keep this in mind:
; while (string[i] != 0) { print string[i]; i++ }

; The comparison for string end (null byte).
start:
    mov al, [bx] ; 'bx' is the base address for the string
    cmp al, 0
    je done

    ; The part where we print with the BIOS help.
    mov ah, 0x0e
    int 0x10 ; 'al' already contains the char

    ; Increment pointer and do next loop.
    add bx, 1
    jmp start

done:
    popa
    ret

print_nl:
    pusha

    mov ah, 0x0e
    mov al, 0x0a ; newline char
    int 0x10
    mov al, 0x0d ; carriage return
    int 0x10

    popa
    ret
