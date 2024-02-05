STACKSG SEGMENT PARA STACK 'yigin'
        DW 24 DUP(?)
STACKSG ENDS

DATASG  SEGMENT PARA 'veri'
VAL DW 500
ASNWER DW ?
DIZI DW 0,1,1, 547 DUP(-1)
DATASG ENDS

CODESG  SEGMENT PARA 'kod'
        ASSUME CS:CODESG, DS:DATASG, SS:STACKSG

DNUM 	PROC FAR
		PUSH BP
		PUSH BX
		MOV BP, SP
		PUSH CX
		PUSH AX
		PUSH DI

		MOV BX, [BP+8]
		XOR DI,DI
		MOV DI, BX
		ADD DI, DI
		MOV AX, DIZI[DI]
		CMP AX, -1  
		JNE L3

		MOV CX, BX
		DEC BX
		PUSH BX
		CALL FAR PTR DNUM 
		CALL FAR PTR DNUM

		POP AX

		SUB CX, 2

		PUSH CX
		CALL FAR PTR DNUM
		POP CX
		SUB BX, CX
		PUSH BX
		CALL FAR PTR DNUM
		POP BX
		ADD AX, BX
		MOV WORD PTR DIZI[DI], AX
L3:
		MOV [BP+8], AX
		POP DI
        POP AX
        POP CX
		POP BX
		POP BP	
	RETF 
DNUM ENDP

PRINTF 	PROC FAR
		PUSH BX
		PUSH CX
		PUSH DX
	
		XOR CX,CX
		XOR DX,DX
		MOV BP,SP
		MOV BX,10
		MOV AX,[BP+10]

J1:		CMP AX,0
		JZ J2
		DIV BX
		PUSH DX
		INC CX
		XOR DX,DX
		JMP J1
		
J2:		POP DX
		ADD DX,48
		
		MOV AH,02H
		INT 21H
		LOOP J2
		
		POP DX
		POP CX
		POP BX
		RETF
PRINTF 	ENDP

ANA  	PROC FAR
		PUSH DS
		XOR AX,AX
		PUSH AX
		MOV AX, DATASG
		MOV DS, AX

		MOV AX ,VAL
		PUSH AX
		CALL FAR PTR DNUM
		POP AX
		PUSH AX
		CALL FAR PTR PRINTF
		POP AX


		RETF 
ANA		ENDP

CODESG  ENDS
        END ANA