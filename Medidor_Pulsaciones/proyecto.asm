
_interrupt:

;proyecto.c,22 :: 		void interrupt(){
;proyecto.c,24 :: 		if(INTCON.INT0IF){
	BTFSS       INTCON+0, 1 
	GOTO        L_interrupt0
;proyecto.c,25 :: 		alfa = TMR0L;
	MOVF        TMR0L+0, 0 
	MOVWF       _alfa+0 
	MOVLW       0
	MOVWF       _alfa+1 
;proyecto.c,26 :: 		alfa =  alfa + (TMR0H<<8);
	MOVF        TMR0H+0, 0 
	MOVWF       R1 
	CLRF        R0 
	MOVF        R0, 0 
	ADDWF       _alfa+0, 0 
	MOVWF       R2 
	MOVF        R1, 0 
	ADDWFC      _alfa+1, 0 
	MOVWF       R3 
	MOVF        R2, 0 
	MOVWF       _alfa+0 
	MOVF        R3, 0 
	MOVWF       _alfa+1 
;proyecto.c,27 :: 		TMR0H = 0;
	CLRF        TMR0H+0 
;proyecto.c,28 :: 		TMR0L = 0;
	CLRF        TMR0L+0 
;proyecto.c,29 :: 		if(alfa!=alfaAnt){
	MOVF        R3, 0 
	XORWF       _alfaAnt+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__interrupt7
	MOVF        _alfaAnt+0, 0 
	XORWF       R2, 0 
L__interrupt7:
	BTFSC       STATUS+0, 2 
	GOTO        L_interrupt1
;proyecto.c,30 :: 		overflow = cont*maxTime;
	MOVF        _cont+0, 0 
	MOVWF       R0 
	CALL        _byte2double+0, 0
	MOVF        _maxTime+0, 0 
	MOVWF       R4 
	MOVF        _maxTime+1, 0 
	MOVWF       R5 
	MOVF        _maxTime+2, 0 
	MOVWF       R6 
	MOVF        _maxTime+3, 0 
	MOVWF       R7 
	CALL        _Mul_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       FLOC__interrupt+0 
	MOVF        R1, 0 
	MOVWF       FLOC__interrupt+1 
	MOVF        R2, 0 
	MOVWF       FLOC__interrupt+2 
	MOVF        R3, 0 
	MOVWF       FLOC__interrupt+3 
	MOVF        FLOC__interrupt+0, 0 
	MOVWF       _overflow+0 
	MOVF        FLOC__interrupt+1, 0 
	MOVWF       _overflow+1 
	MOVF        FLOC__interrupt+2, 0 
	MOVWF       _overflow+2 
	MOVF        FLOC__interrupt+3, 0 
	MOVWF       _overflow+3 
;proyecto.c,31 :: 		time = (fosc*alfa)+overflow;
	MOVF        _alfa+0, 0 
	MOVWF       R0 
	MOVF        _alfa+1, 0 
	MOVWF       R1 
	CALL        _word2double+0, 0
	MOVF        _fosc+0, 0 
	MOVWF       R4 
	MOVF        _fosc+1, 0 
	MOVWF       R5 
	MOVF        _fosc+2, 0 
	MOVWF       R6 
	MOVF        _fosc+3, 0 
	MOVWF       R7 
	CALL        _Mul_32x32_FP+0, 0
	MOVF        FLOC__interrupt+0, 0 
	MOVWF       R4 
	MOVF        FLOC__interrupt+1, 0 
	MOVWF       R5 
	MOVF        FLOC__interrupt+2, 0 
	MOVWF       R6 
	MOVF        FLOC__interrupt+3, 0 
	MOVWF       R7 
	CALL        _Add_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       _time+0 
	MOVF        R1, 0 
	MOVWF       _time+1 
	MOVF        R2, 0 
	MOVWF       _time+2 
	MOVF        R3, 0 
	MOVWF       _time+3 
;proyecto.c,32 :: 		frecuencia = 1.0/time*60.0; //se multiplica por 60seg
	MOVF        R0, 0 
	MOVWF       R4 
	MOVF        R1, 0 
	MOVWF       R5 
	MOVF        R2, 0 
	MOVWF       R6 
	MOVF        R3, 0 
	MOVWF       R7 
	MOVLW       0
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVLW       0
	MOVWF       R2 
	MOVLW       127
	MOVWF       R3 
	CALL        _Div_32x32_FP+0, 0
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       112
	MOVWF       R6 
	MOVLW       132
	MOVWF       R7 
	CALL        _Mul_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       _frecuencia+0 
	MOVF        R1, 0 
	MOVWF       _frecuencia+1 
	MOVF        R2, 0 
	MOVWF       _frecuencia+2 
	MOVF        R3, 0 
	MOVWF       _frecuencia+3 
;proyecto.c,33 :: 		WordToStr(frecuencia,txt);
	CALL        _double2word+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_WordToStr_input+0 
	MOVF        R1, 0 
	MOVWF       FARG_WordToStr_input+1 
	MOVLW       _txt+0
	MOVWF       FARG_WordToStr_output+0 
	MOVLW       hi_addr(_txt+0)
	MOVWF       FARG_WordToStr_output+1 
	CALL        _WordToStr+0, 0
;proyecto.c,34 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;proyecto.c,35 :: 		Lcd_out(1,1,txt);
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       _txt+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(_txt+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;proyecto.c,36 :: 		Lcd_out_CP(" lat/min");
	MOVLW       ?lstr1_proyecto+0
	MOVWF       FARG_Lcd_Out_CP_text+0 
	MOVLW       hi_addr(?lstr1_proyecto+0)
	MOVWF       FARG_Lcd_Out_CP_text+1 
	CALL        _Lcd_Out_CP+0, 0
;proyecto.c,37 :: 		alfaAnt = alfa;
	MOVF        _alfa+0, 0 
	MOVWF       _alfaAnt+0 
	MOVF        _alfa+1, 0 
	MOVWF       _alfaAnt+1 
;proyecto.c,38 :: 		}
L_interrupt1:
;proyecto.c,39 :: 		cont = 0;
	CLRF        _cont+0 
;proyecto.c,40 :: 		INTCON.INT0IF = 0 ;
	BCF         INTCON+0, 1 
;proyecto.c,41 :: 		}
L_interrupt0:
;proyecto.c,43 :: 		if(INTCON.TMR0IF){
	BTFSS       INTCON+0, 2 
	GOTO        L_interrupt2
;proyecto.c,44 :: 		cont++;
	INCF        _cont+0, 1 
;proyecto.c,45 :: 		INTCON.TMR0IF = 0;
	BCF         INTCON+0, 2 
;proyecto.c,46 :: 		}
L_interrupt2:
;proyecto.c,47 :: 		}
L_end_interrupt:
L__interrupt6:
	RETFIE      1
; end of _interrupt

_main:

;proyecto.c,49 :: 		void main() {
;proyecto.c,50 :: 		TRISB.B0 = 1; //Se configura como entrada
	BSF         TRISB+0, 0 
;proyecto.c,51 :: 		Lcd_Init();
	CALL        _Lcd_Init+0, 0
;proyecto.c,52 :: 		ADCON1 = 0x0F; //se configuran los terminales AN como E/S digitales
	MOVLW       15
	MOVWF       ADCON1+0 
;proyecto.c,53 :: 		CMCON = 0x07; //se apagan los comparadores analógicos
	MOVLW       7
	MOVWF       CMCON+0 
;proyecto.c,56 :: 		INTCON.INT0IF = 0 ; //Se pone flag a 0
	BCF         INTCON+0, 1 
;proyecto.c,57 :: 		INTCON.INT0IE = 1 ;  //Se habilita la interrupcion INT0
	BSF         INTCON+0, 4 
;proyecto.c,58 :: 		INTCON2.RBPU = 0; //Se habilita la resistencia de pullup
	BCF         INTCON2+0, 7 
;proyecto.c,59 :: 		INTCON2.INTEDG0 = 1; // Se habilita por flanco de subida
	BSF         INTCON2+0, 6 
;proyecto.c,60 :: 		INTCON.GIE = 1; // Se habilitan las interrupciones en general
	BSF         INTCON+0, 7 
;proyecto.c,63 :: 		T0CON = 0x85; //1100X0101 -> Modo 16Bits; PRE = 64
	MOVLW       133
	MOVWF       T0CON+0 
;proyecto.c,64 :: 		INTCON.TMR0IF = 0; //Se pone flag a 0
	BCF         INTCON+0, 2 
;proyecto.c,65 :: 		INTCON.TMR0IE = 1;   //Se habilitan interrupciones Timer0
	BSF         INTCON+0, 5 
;proyecto.c,66 :: 		TMR0H = 0;
	CLRF        TMR0H+0 
;proyecto.c,67 :: 		TMR0L = 0;
	CLRF        TMR0L+0 
;proyecto.c,69 :: 		while(1);
L_main3:
	GOTO        L_main3
;proyecto.c,71 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
