; PIC16F877A Configuration Bit Settings
; Assembly source line config statements
#include "p16f877a.inc"
; CONFIG
; __config 0xFF71
 __CONFIG _FOSC_HS & _WDTE_OFF & _PWRTE_ON & _BOREN_ON & _LVP_OFF & _CPD_OFF & _WRT_OFF & _CP_OFF

#define BANK0	BCF STATUS,RP0
#define BANK1	BSF STATUS,RP0
 
;nomeando posi��o da mem�ria RAM 
 CBLOCK	0x20
    FLAGS	;0x20
    CONTADOR2	;0x21
    UNIDADE	;0x22
    DEZENA	;0x23
    CENTENA
    MILHAR
    W_TEMP	;0x24
    STATUS_TEMP	;0x25
    CONTADOR	;0x26
 ENDC
 
;entradas
#define	    B_INICIAR	    PORTB,0
#define	    B_PARAR	    PORTB,1
#define	    B_ZERAR	    PORTB,2
 
;sa�das
#define	    DISPLAYS	    PORTD
#define	    D_UNIDADE	    PORTB,4
#define	    D_DEZENA	    PORTB,5
#define	    D_CENTENA	    PORTB,6
#define	    D_MILHAR	    PORTB,7
 
;vari�veis
#define    JA_LI	    FLAGS,0
#define    INT_ATIVA	    FLAGS,1
#define    FIM_TEMPO	    FLAGS,2
#define    CONTANDO	    FLAGS,3
#define    FIM_LED	    FLAGS,4 

;constantes 
V_TMR0	    equ	    .6
V_FILTRO    equ	    .100
V_CONT	    equ	    .125    
V_CONT2	    equ	    .2
;=== programa ==============
RES_VECT    CODE    0x0000    ;vetor de reset, indica a posi��o inicial do programa na FLASH
    GOTO    INICIO

ISR	    CODE    0x0004	; interrupt vector location
    MOVWF   W_TEMP		;salva o conte�do de W em W_TEMP	    
    MOVF    STATUS,W		;W = STATUS
    MOVWF   STATUS_TEMP		;salva o conte�do de STATUS em STATUS_TEMP
    BTFSS   INTCON,T0IF		;testa se o indicador de interrup��o por TMR0 est� ativo
    GOTO    SAI_INTERRUPCAO	;se n�o estiver, pula para SAI_INTERRUPCAO
    BCF	    INTCON,T0IF		;zera o flag indicador de interrup��o por TMR0
    MOVLW   V_TMR0		;W = V_TMR0
    ADDWF   TMR0,F		;TMR0 = TMR0 + V_TMR0
    BSF	    INT_ATIVA		;INT_ATIVA = 1
    DECFSZ  CONTADOR,F		;decrementa CONTADAOR e testa se � zero
    GOTO    SAI_INTERRUPCAO	;se n�o for zero, pula para SAI_INTERRUPCAO
    MOVLW   V_CONT		;W = V_CONT
    MOVWF   CONTADOR		;CONTADOR = V_CONT
    BSF	    FIM_LED		;FIM_LED
    DECFSZ  CONTADOR2,F		;decrementa CONTADOR2 e testa se � zero
    GOTO    SAI_INTERRUPCAO	;se n�o for zero, pula para SAI_INTERRUPCAO
    BSF	    FIM_TEMPO		;FIM_TEMPO = 1
    MOVLW   V_CONT2		;W = V_CONT2
    MOVWF   CONTADOR2		;CONTADOR2 = V_CONT2    
SAI_INTERRUPCAO
    MOVF    STATUS_TEMP,W	;W = STATUS_TEMP
    MOVWF   STATUS		;restaura o conte�do de STATUS
    MOVF    W_TEMP,W		;restaura o conte�do de W    	
    RETFIE
    
BUSCA_CODIGO
    ADDWF   PCL,F	    
    RETLW   B'00111111'	    ;63   
    RETLW   B'00000110'	    ;6
    RETLW   B'01011011'	    ;91
    RETLW   B'01001111'	    ;79
    RETLW   B'01100110'	    ;102
    RETLW   B'01101101'	    ;109
    RETLW   B'01111101'	    ;125
    RETLW   B'00000111'	    ;7
    RETLW   B'01111111'	    ;127
    RETLW   B'01101111'	    ;111
    
BUSCA_CODIGO2
    ADDWF   PCL,F	    
    RETLW   B'10111111'	    ;63   
    RETLW   B'10000110'	    ;6
    RETLW   B'11011011'	    ;91
    RETLW   B'11001111'	    ;79
    RETLW   B'11100110'	    ;102
    RETLW   B'11101101'	    ;109
    RETLW   B'11111101'	    ;125
    RETLW   B'10000111'	    ;7
    RETLW   B'11111111'	    ;127
    RETLW   B'11101111'	    ;111
    
INICIO  
    BANK1		    ;seleciona o banco 1 da mem�ria RAM
    MOVLW   B'00001111'	    ;W = 00001111
    MOVWF   TRISB	    ;TRISB = 00001111,configura os 4LSB como entrada e os 4MSB como sa�da
    CLRF    TRISD	    ;TRISD = 00000000,configura o PORTD como sa�da
    MOVLW   B'11010011'	    ;palavra de configura��o do TMR0
    MOVWF   OPTION_REG	    ;carrega a palavra de configura��o do TMR0 no OPTION_REG
    BANK0		    ;seleciona o banco 0 da mem�ria RAM
    CLRF    UNIDADE	    ;UNIDADE = 0
    CLRF    DEZENA  	    ;DEZENA = 0
    CLRF    CENTENA
    CLRF    MILHAR
    BCF	    D_UNIDADE	    ;apaga o display da UNIDADE
    BCF	    D_DEZENA	    ;apaga o display da DEZENA
    BCF	    D_CENTENA	    ;apaga o display da CENTENA
    BCF	    D_MILHAR	    ;apaga o display da MILHAR     
    BSF	    INTCON,T0IE	    ;permite atender interrup��o por TMR0    
    BSF	    INTCON,GIE	    ;permite atender interrup��es  
LACO_PRINCIPAL
    BTFSC   INT_ATIVA	    ;testa se o bit indicador de tempo 4ms est� ativo
    CALL    TROCA_DISPLAY   ;se INT_ATIVA = 1, chama sub-rotina TROCA_DISPLAY
    BTFSS   CONTANDO	    ;testa se CONTANDO = 1
    GOTO    PARADO	    ;se n�o, pule para PARADO     
    BTFSS   B_PARAR	    ;testa se o bot�o B_PARAR est� liberado	
    GOTO    B_PARAR_PRESS   ;se pressionado pule para B_PARAR_PRESS
    BTFSC   FIM_LED	    ;testa se o FIM_LED = 0
    CALL    TROCA_LED	    ;se FIM_LED = 1, chama a rotina de troca de estado do LED 
    BTFSS   FIM_TEMPO	    ;testa se o FIM_TEMPO = 1
    GOTO    LACO_PRINCIPAL  ;se FIM_TEMPO = 0, pula para  LACO_PRINCIPAL
    BCF	    FIM_TEMPO	    ;FIM_TEMPO = 0
    INCF    UNIDADE,F	    ;UNIDADE++
    MOVLW   .10		    ;W = 10 (B'00001010' ou 0x0A)
    SUBWF   UNIDADE,W	    ;W = UNIDADE - W
    BTFSS   STATUS,C	    ;testa se o resultado � positivo
    GOTO    LACO_PRINCIPAL  ;se resutado for negativo, pula para LACO_PRINCIPAL
    CLRF    UNIDADE	    ;UNIDADE = 0
    INCF    DEZENA,F	    ;DEZENA++
    MOVLW   .10		    ;W = 10 (B'00001010' ou 0x0A)
    SUBWF   DEZENA,W	    ;W = DEZENA - W
    BTFSS   STATUS,C	    ;testa se o resultado � negativo
    GOTO    LACO_PRINCIPAL	    
    CLRF    DEZENA	    ;DEZENA = 0
    INCF    CENTENA,F	    ;UNIDADE++
    MOVLW   .10		    ;W = 10 (B'00001010' ou 0x0A)
    SUBWF   CENTENA,W	    ;W = UNIDADE - W
    BTFSS   STATUS,C	    ;testa se o resultado � positivo
    GOTO    LACO_PRINCIPAL  ;se resutado for negativo, pula para LACO_PRINCIPAL
    CLRF    CENTENA	    ;UNIDADE = 0
    INCF    MILHAR,F	    ;DEZENA++
    MOVLW   .10		    ;W = 10 (B'00001010' ou 0x0A)
    SUBWF   MILHAR,W	    ;W = DEZENA - W
    BTFSC   STATUS,C	    ;testa se o resultado � negativo
    CLRF    MILHAR	    ;DEZENA = 0
    GOTO    LACO_PRINCIPAL  ;pula para LACO_PRINCIPAL  
  
B_PARAR_PRESS
    BCF	    CONTANDO	    ;CONTANDO = 0 
    GOTO    LACO_PRINCIPAL  ;pula para LACO_PRINCIPAL 
PARADO
    BTFSS   B_INICIAR	    ;testa se o bot�o B_INICIAR est� liberado
    GOTO    B_INICIAR_PRESS ;se pressionado pule para B_INICIAR_PRESS
    BTFSC   B_ZERAR	    ;testa se o bot�o B_ZERAR est� liberado
    GOTO    LACO_PRINCIPAL  ;se n�o pressionado pule para LACO_PRINCIPAL 
    CLRF    UNIDADE	    ;UNIDADE = 0  
    CLRF    DEZENA	    ;DEZENA = 0
    GOTO    LACO_PRINCIPAL  ;pula para LACO_PRINCIPAL
 
B_INICIAR_PRESS
    BSF	    CONTANDO	    ;CONTANDO = 1
    BCF	    FIM_TEMPO	    ;FIM_TEMPO = 0
    BCF	    FIM_LED	    ;FIM_LED = 0    
    MOVLW   V_CONT	    ;W = V_CONT
    MOVWF   CONTADOR	    ;CONTADOR = V_CONT
    MOVLW   V_CONT2	    ;W = V_CONT2
    MOVWF   CONTADOR2	    ;CONTADOR2 = V_CONT2
    GOTO    LACO_PRINCIPAL  ;pula para LACO_PRINCIPAL    
 
TROCA_LED
    BCF	    FIM_LED	    ;FIM_LED = 0
    GOTO    ACENDE_LED	    ;se LED = 0, pula para ACENDE_LED
    RETURN		    ;retorna da chamada de subrotina  
ACENDE_LED
    RETURN		    ;retorna da chamada de subrotina
    
TROCA_DISPLAY
    BCF	    INT_ATIVA	    ;INT_ATIVA = 0
    
    BTFSC   D_UNIDADE	    ;testa se o display da UNIDADE est� acesso
    GOTO    ACENDE_UNIDADE    ;se UNIDADE n�o estiver acesa, pula para TESTA_DEZENA
    BTFSC   D_DEZENA
    GOTO    ACENDE_DEZENA
    BTFSC   D_CENTENA
    GOTO    ACENDE_CENTENA
    GOTO    ACENDE_MILHAR
ACENDE_DEZENA
    BCF	    D_UNIDADE	    ;apaga o display da UNIDADE
    BCF	    D_CENTENA	    ;apaga o display da UNIDADE
    BCF	    D_MILHAR	    ;apaga o display da UNIDADE
    BCF	    D_DEZENA	    ;apaga o display da UNIDADE
    MOVF    CENTENA,W	    ;W = DEZENA
    CALL    BUSCA_CODIGO    ;chama a subrotina para buscar o c�digo de 7 segmentos
    MOVWF   DISPLAYS	    ;DISPLAYS = W (c�digo de 7 segmentos)
    BSF	    D_CENTENA	    ;ativa o display da DEZENA
    RETURN		    ;retorna da chamada de subrotina
ACENDE_UNIDADE
    BCF	    D_UNIDADE	    ;apaga o display da UNIDADE
    BCF	    D_CENTENA	    ;apaga o display da UNIDADE
    BCF	    D_MILHAR	    ;apaga o display da UNIDADE
    BCF	    D_DEZENA	    ;apaga o display da UNIDADE
    MOVF    DEZENA,W	    ;W = DEZENA
    CALL    BUSCA_CODIGO2    ;chama a subrotina para buscar o c�digo de 7 segmentos
    MOVWF   DISPLAYS	    ;DISPLAYS = W (c�digo de 7 segmentos)
    BSF	    D_DEZENA	    ;ativa o display da UNIDADE
    RETURN		    ;retorna da chamada de subrotina    
ACENDE_CENTENA
    BCF	    D_UNIDADE	    ;apaga o display da UNIDADE
    BCF	    D_CENTENA	    ;apaga o display da UNIDADE
    BCF	    D_MILHAR	    ;apaga o display da UNIDADE
    BCF	    D_DEZENA	    ;apaga o display da UNIDADE
    MOVF    MILHAR,W	    ;W = UNIDADE
    CALL    BUSCA_CODIGO    ;chama a subrotina para buscar o c�digo de 7 segmentos
    MOVWF   DISPLAYS	    ;DISPLAYS = W (c�digo de 7 segmentos)
    BSF	    D_MILHAR	    ;ativa o display da UNIDADE
    RETURN		    ;retorna da chamada de subrotina  
ACENDE_MILHAR
    BCF	    D_UNIDADE	    ;apaga o display da UNIDADE
    BCF	    D_CENTENA	    ;apaga o display da UNIDADE
    BCF	    D_MILHAR	    ;apaga o display da UNIDADE
    BCF	    D_DEZENA	    ;apaga o display da UNIDADE
    MOVF    UNIDADE,W	    ;W = UNIDADE
    CALL    BUSCA_CODIGO    ;chama a subrotina para buscar o c�digo de 7 segmentos
    MOVWF   DISPLAYS	    ;DISPLAYS = W (c�digo de 7 segmentos)
    BSF	    D_UNIDADE	    ;ativa o display da UNIDADE
    RETURN		    ;retorna da chamada de subrotina  
    

    
    END