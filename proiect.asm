.model small
.stack 200h
.data
	msg1 db "Introduceti valoarea in grade Celsius: $"
	msg2 db "Valoarea convertita in grade Fahrenheit: $"
	numar db 0
	tasta db 0
	fah dw 0
.code
	main:
	mov ax, @data
	mov ds, ax
	
	print macro text
		mov ah, 09h
		mov dx, offset text
		int 21h
	endm print
	
	print msg1
	
	mov cl, 10
	
	citireTasta:
		mov ah, 01h
		int 21h
	
		cmp al, 13
		je amTerminat
	
		sub al, 48
		mov tasta, al
		mov al, numar
		mul cl
		add al, tasta
		mov numar, al
	jmp citireTasta
	
	amTerminat:
		call conversie
	
	conversie proc
		mov al, numar
		mov bl, 9
		mul bl ;rezultat in ax
		mov dl, 5
		div dl ;rezultat in al
		add al, 32
		mov ah, 0
		mov fah, ax
	endp conversie
	
	print msg2
	
	mov ax, fah
	
	mov cx, 0
	mov dx, 0
	
	descompunere:
		cmp ax, 0
		je afisare
	
		mov bx, 10
		div bx
		push dx
		inc cx
		mov dx, 0
	jmp descompunere
	
	afisare:
		cmp cx, 0
		je exit
	
		pop dx
		add dx, 48
		mov ah, 02h
		int 21h
	
		dec cx
	jmp afisare
	exit:
		mov ah, 4ch
		int 21h
	end main