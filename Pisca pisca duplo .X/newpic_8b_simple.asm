; PIC16F628A Configuration Bit Settings
; Assembly source line config statements
#include "p16f628a.inc"
; CONFIG
; __config 0xFF70
 __CONFIG _FOSC_INTOSCIO & _WDTE_OFF & _PWRTE_ON & _MCLRE_ON & _BOREN_ON & _LVP_OFF & _CPD_OFF & _CP_OFF

 #define BANK0	BCF STATUS,RP0
 #define BANK1	BSF STATUS,RP0
 
 ;nomeando posi��o da mem�ria RAM
 CBLOCK	0x20
    DELAY_1	;0x20
    DELAY_2	;0x21
    DELAY_3
    DELAY_4
 ENDC
 
;sa�das
#define	    LED	     PORTA,0
#define	    BOTAO2   PORTA,2
#define	    BOTAO3   PORTA,3
#define	    BOTAO1   PORTA,1
 
;constantes 
V_DELAY_1   equ	    .132
V_DELAY_2   equ	    .250
V_DELAY_3   equ	    .195
V_DELAY_4   equ	    .255
;=== programa ==============
RES_VECT  CODE    0x0000    ;vetor de reset, indica a posi��o inicial do programa na FLASH
    BANK1	    	    ;seleciona o banco 1 da mem�ria RAM
    BCF	    TRISA,0	    ;configura o bir 0 do PORTA como sa�da
    BANK0		    ;seleciona o banco 0 da mem�ria RAM
    
FOI3
    BTFSC   BOTAO3	    ;l� e testa o bit 1 do PORTA
    GOTO    FOI1
    BCF	    LED		    ;apaga a l�mpada conectada no pino 0 do PORTA
FOI1
    BTFSC   BOTAO1	    ;l� e testa o bit 1 do PORTA
    GOTO    FOI2
    GOTO    LOOP1
    GOTO    FOI2  ;pula para repetir
FOI2
    BTFSC   BOTAO2	    ;l� e testa o bit 1 do PORTA
    GOTO    FOI3
    GOTO    LOOP2
    GOTO    FOI3  ;pula para repetir

LOOP1
    BTFSS   BOTAO3	    ;l� e testa o bit 1 do PORTA
    GOTO    FOI3
    BSF	    LED		    ;liga a l�mpada conectada no pino 0 do PORTA
    CALL    DELAY_500MS	    ;chama a subrotina de delay
    BCF	    LED		    ;apaga a l�mpada conectada no pino 0 do PORTA
    CALL    DELAY_500MS	    ;chama a subrotina de delay
    GOTO    LOOP1
    
LOOP2
    BTFSS   BOTAO3	    ;l� e testa o bit 1 do PORTA
    GOTO    FOI3
    BSF	    LED		    ;liga a l�mpada conectada no pino 0 do PORTA
    CALL    DELAY_200MS	    ;chama a subrotina de delay
    BCF	    LED		    ;apaga a l�mpada conectada no pino 0 do PORTA
    CALL    DELAY_200MS	    ;chama a subrotina de delay
    GOTO    LOOP2
DELAY_200MS
    MOVLW   V_DELAY_1		;W = V_DELAY_1				(1)
    MOVWF   DELAY_1		;DELAY_1 = V_DELAY_1			(1)
CARREGA_DELAY_2
    MOVLW   V_DELAY_2		;W = V_DELAY_2				(1)
    MOVWF   DELAY_2		;DELAY_2 = V_DELAY_2			(1)
DECREMENTA_DELAY_2 
    NOP
    NOP
    NOP
    DECFSZ  DELAY_2,F		;decrementa e testa se DELAY_2 zerou	(1/2)
    GOTO    DECREMENTA_DELAY_2	;se n�o zerou, decrementa de novo	(2)
    DECFSZ  DELAY_1,F		;decrementa e testa se DELAY_1 zerou	(1/2)
    GOTO    CARREGA_DELAY_2	;se n�o zerou, repete tudo		(2)
    RETURN			;					(2)
    
DELAY_500MS
    MOVLW   V_DELAY_3		;W = V_DELAY_1				(1)
    MOVWF   DELAY_3		;DELAY_1 = V_DELAY_1			(1)
CARREGA_DELAY_4
    MOVLW   V_DELAY_4		;W = V_DELAY_2				(1)
    MOVWF   DELAY_4		;DELAY_2 = V_DELAY_2			(1)
DECREMENTA_DELAY_4 
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    DECFSZ  DELAY_4,F		;decrementa e testa se DELAY_2 zerou	(1/2)
    GOTO    DECREMENTA_DELAY_4	;se n�o zerou, decrementa de novo	(2)
    DECFSZ  DELAY_3,F		;decrementa e testa se DELAY_1 zerou	(1/2)
    GOTO    CARREGA_DELAY_4	;se n�o zerou, repete tudo		(2)
    RETURN			;					(2)
    
    END
