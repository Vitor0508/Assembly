; PIC16F628A Configuration Bit Settings
; Assembly source line config statements
#include "p16f628a.inc"
; CONFIG
; __config 0xFF70
 __CONFIG _FOSC_INTOSCIO & _WDTE_OFF & _PWRTE_ON & _MCLRE_ON & _BOREN_ON & _LVP_OFF & _CPD_OFF & _CP_OFF
;nomeando posição da memória RAM
 CBLOCK	0x20
    FLAGS	;0x20
    FILTRO	;0x21
    UNIDADE	;0x22
 ENDC
 
;entradas
#define	    BOTAO2   PORTA,2
#define	    BOTAO3   PORTA,3
#define	    BOTAO1   PORTA,1

;saídas
#define	    NUMERO  PORTB

;variáveis
#define    JA_LI   FLAGS,0
 
;constantes 
V_FILTRO   equ	    .100

;=== programa ==============
RES_VECT  CODE    0x0000    ;vetor de reset, indica a posição inicial do programa na FLASH
    BSF	    STATUS,RP0	    ;seleciona o banco 1 da memória RAM
    MOVLW   B'00000000'	    ;W =  B'11110000' (240)
    MOVWF   TRISB	    ;TRISB = B'11110000' (240)  
    BCF	TRISA,0 ; CONFIGURA O PINO A0 COMO SAIDA
    BCF	    STATUS,RP0	    ;seleciona o banco 0 da memória RAM
    CLRF    UNIDADE	    ;UNIDADE = 0
    MOVF    UNIDADE,W	    ;W = UNIDADE
    CALL    ESCREVE_DISPLAY ;chama a subrotina para escrever no display
ZERA_JA_LI    
    BCF	    JA_LI	    ;zera a variável JA_LI
    MOVLW   V_FILTRO	    ;W = V_FILTRO
    MOVWF   FILTRO	    ;FILTRO = V_FILTRO
    
FOI1
    BTFSC   BOTAO1	    ;lê e testa o bit 1 do PORTA
    GOTO    FOI2
    CALL    LE_BOTAO1
    
FOI2
    BTFSC   BOTAO2	    ;lê e testa o bit 1 do PORTA
    GOTO    FOI3
    CALL    LE_BOTAO2
    

FOI3
    BTFSC   BOTAO3	    ;lê e testa o bit 1 do PORTA
    GOTO    FOI1
    CALL    LE_BOTAO3
    
LE_BOTAO1
    CLRF    UNIDADE	    ;UNIDADE = 0
    CALL    ESCREVE_DISPLAY ;chama a subrotina para escrever no display
    RETURN
    
LE_BOTAO2
    BTFSC   BOTAO2	    ;lê e testa o bit 1 do PORTA
    GOTO    ZERA_JA_LI	    ;se "1" pula para ZERA_JA_LI
    BTFSC   JA_LI	    ;testa o JA_LI
    GOTO    LE_BOTAO2	    ;se "1", pula para LE_BOTAO   
    DECFSZ  FILTRO,F	    ;decrementa FILTRO e testa se é igual a 0
    GOTO    LE_BOTAO2	    ;se não for zero, pula para LE_BOTAO
    BSF	    JA_LI	    ;JA_LI = 1       
    INCF    UNIDADE,F	    ; UNIDADE++
    MOVLW   .10		    ;W = 10 (B'00001010' ou 0x0A)
    SUBWF   UNIDADE,W	    ;W = UNIDADE - W
    BTFSC   STATUS,C	    ;testa se o resultado é negativo
    CLRF    UNIDADE	    ;UNIDADE = 0
    MOVF    UNIDADE,W	    ;W = UNIDADE
    CALL    ESCREVE_DISPLAY ;chama a subrotina para escrever no display
    GOTO    LE_BOTAO2	    ;pula para LE_BOTAO
    RETURN
    
LE_BOTAO3
    BTFSC   BOTAO3	    ;lê e testa o bit 1 do PORTA
    GOTO    ZERA_JA_LI	    ;se "1" pula para ZERA_JA_LI
    BTFSC   JA_LI	    ;testa o JA_LI
    GOTO    LE_BOTAO3	    ;se "1", pula para LE_BOTAO   
    DECFSZ  FILTRO,F	    ;decrementa FILTRO e testa se é igual a 0
    GOTO    LE_BOTAO3	    ;se não for zero, pula para LE_BOTAO
    BSF	    JA_LI	    ;JA_LI = 1       
    DECF    UNIDADE,F	    ; UNIDADE--
    MOVLW   .10		    ;W = 10 (B'00001010' ou 0x0A)
    SUBWF   UNIDADE,W	    ;W = UNIDADE - W
    BTFSC   STATUS,C	    ;testa se o resultado é negativo
    CALL    _9
    MOVF    UNIDADE,W	    ;W = UNIDADE
    CALL    ESCREVE_DISPLAY ;chama a subrotina para escrever no display
    GOTO    LE_BOTAO3	    ;pula para LE_BOTAO
_9
    MOVLW   .9
    MOVWF    UNIDADE
    RETURN
ESCREVE_DISPLAY
    CALL    BUSCA_CODIGO    ;chama a subrotina para buscar o código de 7 segmentos
    MOVWF   NUMERO	    ;NUMERO = w (código de 7 segmentos)
    RETURN		    ;retorna da chamada de subrotina
BUSCA_CODIGO
    ADDWF   PCL,F	    
    RETLW   .254    
    RETLW   .56
    RETLW   .221
    RETLW   .125
    RETLW   .59
    RETLW   .119
    RETLW   .247
    RETLW   .60
    RETLW   .255
    RETLW   .127
    
    END