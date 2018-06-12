
_interrupt:

;Receptor.c,21 :: 		void interrupt(){
;Receptor.c,23 :: 		if(PIR1.RCIF){
	BTFSS       PIR1+0, 5 
	GOTO        L_interrupt0
;Receptor.c,24 :: 		*(puntero+cont) = UART1_Read();
	MOVF        _cont+0, 0 
	ADDWF       _puntero+0, 0 
	MOVWF       FLOC__interrupt+0 
	MOVLW       0
	ADDWFC      _puntero+1, 0 
	MOVWF       FLOC__interrupt+1 
	CALL        _UART1_Read+0, 0
	MOVFF       FLOC__interrupt+0, FSR1
	MOVFF       FLOC__interrupt+1, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;Receptor.c,25 :: 		cont++;
	INCF        _cont+0, 1 
;Receptor.c,27 :: 		if(cont > 3 ){
	MOVF        _cont+0, 0 
	SUBLW       3
	BTFSC       STATUS+0, 0 
	GOTO        L_interrupt1
;Receptor.c,28 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;Receptor.c,29 :: 		FloatToStr(temperatura,txt);
	MOVF        _temperatura+0, 0 
	MOVWF       FARG_FloatToStr_fnum+0 
	MOVF        _temperatura+1, 0 
	MOVWF       FARG_FloatToStr_fnum+1 
	MOVF        _temperatura+2, 0 
	MOVWF       FARG_FloatToStr_fnum+2 
	MOVF        _temperatura+3, 0 
	MOVWF       FARG_FloatToStr_fnum+3 
	MOVLW       _txt+0
	MOVWF       FARG_FloatToStr_str+0 
	MOVLW       hi_addr(_txt+0)
	MOVWF       FARG_FloatToStr_str+1 
	CALL        _FloatToStr+0, 0
;Receptor.c,30 :: 		Lcd_out(1,1,txt);
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       _txt+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(_txt+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;Receptor.c,31 :: 		Lcd_out_CP(" *C");
	MOVLW       ?lstr1_Receptor+0
	MOVWF       FARG_Lcd_Out_CP_text+0 
	MOVLW       hi_addr(?lstr1_Receptor+0)
	MOVWF       FARG_Lcd_Out_CP_text+1 
	CALL        _Lcd_Out_CP+0, 0
;Receptor.c,32 :: 		cont = 0;
	CLRF        _cont+0 
;Receptor.c,33 :: 		}
L_interrupt1:
;Receptor.c,34 :: 		PIR1.RCIF = 0;
	BCF         PIR1+0, 5 
;Receptor.c,35 :: 		}
L_interrupt0:
;Receptor.c,36 :: 		}
L_end_interrupt:
L__interrupt6:
	RETFIE      1
; end of _interrupt

_main:

;Receptor.c,37 :: 		void main() {
;Receptor.c,39 :: 		ADCON1 = 0x0F; //se configuran los terminales AN como E/S digitales
	MOVLW       15
	MOVWF       ADCON1+0 
;Receptor.c,40 :: 		CMCON = 0x07; //se apagan los comparadores analógicos
	MOVLW       7
	MOVWF       CMCON+0 
;Receptor.c,42 :: 		Lcd_Init();
	CALL        _Lcd_Init+0, 0
;Receptor.c,43 :: 		UART1_Init(9600);
	BSF         BAUDCON+0, 3, 0
	CLRF        SPBRGH+0 
	MOVLW       207
	MOVWF       SPBRG+0 
	BSF         TXSTA+0, 2, 0
	CALL        _UART1_Init+0, 0
;Receptor.c,44 :: 		delay_ms(300);
	MOVLW       4
	MOVWF       R11, 0
	MOVLW       12
	MOVWF       R12, 0
	MOVLW       51
	MOVWF       R13, 0
L_main2:
	DECFSZ      R13, 1, 1
	BRA         L_main2
	DECFSZ      R12, 1, 1
	BRA         L_main2
	DECFSZ      R11, 1, 1
	BRA         L_main2
	NOP
	NOP
;Receptor.c,45 :: 		puntero = &temperatura; //puntero guarda la dirección en memoria de la variable temperatura
	MOVLW       _temperatura+0
	MOVWF       _puntero+0 
	MOVLW       hi_addr(_temperatura+0)
	MOVWF       _puntero+1 
;Receptor.c,47 :: 		PIR1.RCIF = 0; //se pone a cero el flag de la interrupción RCIE
	BCF         PIR1+0, 5 
;Receptor.c,48 :: 		PIE1.RCIE = 1; // se habilita la interrupción RCIE
	BSF         PIE1+0, 5 
;Receptor.c,49 :: 		INTCON.PEIE = 1; //interrupciones perifericas
	BSF         INTCON+0, 6 
;Receptor.c,50 :: 		INTCON.GIE = 1; // Se habilitan las interrupciones en general
	BSF         INTCON+0, 7 
;Receptor.c,52 :: 		while(1);
L_main3:
	GOTO        L_main3
;Receptor.c,53 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
