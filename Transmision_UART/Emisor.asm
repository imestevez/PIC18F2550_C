
_interrupt:

;Emisor.c,7 :: 		void interrupt(){
;Emisor.c,9 :: 		if(PIR1.ADIF){
	BTFSS       PIR1+0, 6 
	GOTO        L_interrupt0
;Emisor.c,10 :: 		valor = ADRESL+(ADRESH<<8); //Se recoge el valor del convertidor A/D
	MOVF        ADRESH+0, 0 
	MOVWF       R1 
	CLRF        R0 
	MOVF        ADRESL+0, 0 
	ADDWF       R0, 1 
	MOVLW       0
	ADDWFC      R1, 1 
	MOVF        R0, 0 
	MOVWF       _valor+0 
	MOVF        R1, 0 
	MOVWF       _valor+1 
;Emisor.c,11 :: 		temperatura =100.0*((valor*(5.0/1024.0))-0.5);//((valor*(5.0/1024.0))-0.5)/0.01;
	CALL        _int2double+0, 0
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       32
	MOVWF       R6 
	MOVLW       119
	MOVWF       R7 
	CALL        _Mul_32x32_FP+0, 0
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       0
	MOVWF       R6 
	MOVLW       126
	MOVWF       R7 
	CALL        _Sub_32x32_FP+0, 0
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       72
	MOVWF       R6 
	MOVLW       133
	MOVWF       R7 
	CALL        _Mul_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       _temperatura+0 
	MOVF        R1, 0 
	MOVWF       _temperatura+1 
	MOVF        R2, 0 
	MOVWF       _temperatura+2 
	MOVF        R3, 0 
	MOVWF       _temperatura+3 
;Emisor.c,12 :: 		puntero = &temperatura; //puntero guarda la dirección en memoria de la variable temperatura
	MOVLW       _temperatura+0
	MOVWF       _puntero+0 
	MOVLW       hi_addr(_temperatura+0)
	MOVWF       _puntero+1 
;Emisor.c,14 :: 		UART1_Write(*puntero); // envía por Uart 1a posicion memoria
	MOVFF       _puntero+0, FSR0
	MOVFF       _puntero+1, FSR0H
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;Emisor.c,15 :: 		delay_ms(100);
	MOVLW       2
	MOVWF       R11, 0
	MOVLW       4
	MOVWF       R12, 0
	MOVLW       186
	MOVWF       R13, 0
L_interrupt1:
	DECFSZ      R13, 1, 1
	BRA         L_interrupt1
	DECFSZ      R12, 1, 1
	BRA         L_interrupt1
	DECFSZ      R11, 1, 1
	BRA         L_interrupt1
	NOP
;Emisor.c,16 :: 		UART1_Write(*(puntero+1)); // envía por Uart 2a posicion memoria
	MOVLW       1
	ADDWF       _puntero+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      _puntero+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;Emisor.c,17 :: 		delay_ms(100);
	MOVLW       2
	MOVWF       R11, 0
	MOVLW       4
	MOVWF       R12, 0
	MOVLW       186
	MOVWF       R13, 0
L_interrupt2:
	DECFSZ      R13, 1, 1
	BRA         L_interrupt2
	DECFSZ      R12, 1, 1
	BRA         L_interrupt2
	DECFSZ      R11, 1, 1
	BRA         L_interrupt2
	NOP
;Emisor.c,18 :: 		UART1_Write(*(puntero+2)); // envía por Uart 3a posicion memoria
	MOVLW       2
	ADDWF       _puntero+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      _puntero+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;Emisor.c,19 :: 		delay_ms(100);
	MOVLW       2
	MOVWF       R11, 0
	MOVLW       4
	MOVWF       R12, 0
	MOVLW       186
	MOVWF       R13, 0
L_interrupt3:
	DECFSZ      R13, 1, 1
	BRA         L_interrupt3
	DECFSZ      R12, 1, 1
	BRA         L_interrupt3
	DECFSZ      R11, 1, 1
	BRA         L_interrupt3
	NOP
;Emisor.c,20 :: 		UART1_Write(*(puntero+3)); // envía por Uart 4a posicion memoria
	MOVLW       3
	ADDWF       _puntero+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      _puntero+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;Emisor.c,21 :: 		delay_ms(100);
	MOVLW       2
	MOVWF       R11, 0
	MOVLW       4
	MOVWF       R12, 0
	MOVLW       186
	MOVWF       R13, 0
L_interrupt4:
	DECFSZ      R13, 1, 1
	BRA         L_interrupt4
	DECFSZ      R12, 1, 1
	BRA         L_interrupt4
	DECFSZ      R11, 1, 1
	BRA         L_interrupt4
	NOP
;Emisor.c,23 :: 		PIR1.RCIF = 0;
	BCF         PIR1+0, 5 
;Emisor.c,24 :: 		}
L_interrupt0:
;Emisor.c,26 :: 		if(INTCON.TMR0IF){
	BTFSS       INTCON+0, 2 
	GOTO        L_interrupt5
;Emisor.c,27 :: 		TMR0H = (18661>>8); //1,5seg
	MOVLW       72
	MOVWF       TMR0H+0 
;Emisor.c,28 :: 		TMR0L = 18661;
	MOVLW       229
	MOVWF       TMR0L+0 
;Emisor.c,30 :: 		ADCON0.GO = 1; // inicia conversion A/D
	BSF         ADCON0+0, 1 
;Emisor.c,31 :: 		INTCON.TMR0IF = 0;
	BCF         INTCON+0, 2 
;Emisor.c,32 :: 		}
L_interrupt5:
;Emisor.c,33 :: 		}
L_end_interrupt:
L__interrupt10:
	RETFIE      1
; end of _interrupt

_main:

;Emisor.c,35 :: 		void main() {
;Emisor.c,36 :: 		TRISA.B0 = 1;
	BSF         TRISA+0, 0 
;Emisor.c,38 :: 		ADCON0 = 0x01; //AN0
	MOVLW       1
	MOVWF       ADCON0+0 
;Emisor.c,39 :: 		ADCON1 = 0;
	CLRF        ADCON1+0 
;Emisor.c,40 :: 		ADCON2 = 0x83;
	MOVLW       131
	MOVWF       ADCON2+0 
;Emisor.c,43 :: 		T0CON = 0x85; //1100X0101 -> Modo 16Bits; PRE = 64
	MOVLW       133
	MOVWF       T0CON+0 
;Emisor.c,44 :: 		INTCON.TMR0IF = 0; //Se pone flag a 0
	BCF         INTCON+0, 2 
;Emisor.c,45 :: 		INTCON.TMR0IE = 1; //Se habilita interrrupcion Timer0
	BSF         INTCON+0, 5 
;Emisor.c,47 :: 		PIR1.ADIF = 0; //flag a 0
	BCF         PIR1+0, 6 
;Emisor.c,48 :: 		PIE1.ADIE = 1; //interrupcion de convertidor A/D
	BSF         PIE1+0, 6 
;Emisor.c,49 :: 		INTCON.PEIE = 1; //interrupciones perifericas
	BSF         INTCON+0, 6 
;Emisor.c,50 :: 		INTCON.GIE = 1; // Se habilitan las interrupciones en general
	BSF         INTCON+0, 7 
;Emisor.c,52 :: 		UART1_Init(9600);
	BSF         BAUDCON+0, 3, 0
	CLRF        SPBRGH+0 
	MOVLW       207
	MOVWF       SPBRG+0 
	BSF         TXSTA+0, 2, 0
	CALL        _UART1_Init+0, 0
;Emisor.c,53 :: 		delay_ms(300);
	MOVLW       4
	MOVWF       R11, 0
	MOVLW       12
	MOVWF       R12, 0
	MOVLW       51
	MOVWF       R13, 0
L_main6:
	DECFSZ      R13, 1, 1
	BRA         L_main6
	DECFSZ      R12, 1, 1
	BRA         L_main6
	DECFSZ      R11, 1, 1
	BRA         L_main6
	NOP
	NOP
;Emisor.c,55 :: 		TMR0H = (18661>>8); //1,5seg
	MOVLW       72
	MOVWF       TMR0H+0 
;Emisor.c,56 :: 		TMR0L = 18661;
	MOVLW       229
	MOVWF       TMR0L+0 
;Emisor.c,58 :: 		while(1);
L_main7:
	GOTO        L_main7
;Emisor.c,60 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
