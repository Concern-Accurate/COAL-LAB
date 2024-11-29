.model small
.stack 100h
.data
pr1 db "Please select the number from the following :",10,13,"1.Addition",10,13,"2.Subtraction",10,13,"3.Division",10,13,"$"
pr2 db "Enter 2 numbers ",10,13,'$'
ans db ? 
num1 db ?
num2 db ?
cho db ?
divv db 10
.code
main proc
    mov ax, @data          ; Load data segment
    mov ds, ax
    lea dx, pr1            ; Load prompt for operation selection
    mov ah, 9              ; DOS function to display string
    int 21h
    mov ah, 1              ; DOS function to read character
    int 21h
 
    mov cho, al            ; Store choice
    call newline            ; Print newline
    lea dx, pr2            ; Load prompt for number input
    mov ah, 9              ; Display string
    int 21h
    mov ah, 1              ; Read first number
    int 21h
    sub al, 48             ; Convert ASCII to number
    mov num1, al           ; Store first number
    call newline            ; Print newline
    mov ah, 1              ; Read second number
    int 21h
    sub al, 48             ; Convert ASCII to number
    mov num2, al           ; Store second number
    call newline

    cmp cho, '1'           ; Check for addition
    je pl
    cmp cho, '2'           ; Check for subtraction
    je mi
    cmp cho, '3'           ; Check for division
    je vi
    jne exit               ; Exit if invalid choice

pl:
    call plus              ; Call addition
    jmp exit
mi:
    call min               ; Call subtraction
    jmp exit
vi:
    call divvv             ; Call division
    jmp exit 

exit:
    mov ah, 4ch            ; Terminate program
    int 21h
main endp          

plus proc
    mov ah, 0              ; Clear AH for addition
    mov al, num1           ; Load first number
    add al, num2           ; Add second number
    mov ans, al            ; Store result
    cmp ans, 9             ; Check if result needs division
    jng ple
    mov al, ans            ; Prepare to divide
    div divv               ; Divide by 10
    
    mov dl, al             ; Load quotient
    add dl, 48             ; Convert to ASCII
    mov num2, ah           ; Load remainder
    mov ah, 2              ; Print character
    int 21h
    mov dl, num2           ; Load remainder
    add dl, 48             ; Convert to ASCII
    int 21h
    jmp pe

ple:
    call newline            ; Print newline
    mov dl, ans            ; Load answer
    add dl, 48             ; Convert to ASCII
    mov ah, 2              ; Print character
    int 21h

pe:
    ret
plus endp

min proc
    mov dl, num1           ; Load first number
    sub dl, num2           ; Subtract second number
    add dl, 48             ; Convert to ASCII
    mov ah, 2              ; Print character
    int 21h
    ret
min endp

divvv proc
    mov ah, 0              ; Clear AH for division
    mov al, num1           ; Load numerator
    div num2               ; Divide by second number
    mov dl, al             ; Load quotient
    add dl, 48             ; Convert to ASCII
    mov ah, 2              ; Print character
    int 21h
    ret
divvv endp 

newline proc
    mov dl, 10             ; Line feed
    mov ah, 2              ; Print character
    int 21h
    mov dl, 13             ; Carriage return
    int 21h
    ret
newline endp