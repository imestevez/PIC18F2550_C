/*
	PARTE I
*/
// Lcd pinout settings
sbit LCD_RS at RC0_bit;
sbit LCD_EN at RC1_bit;
sbit LCD_D7 at RA0_bit;
sbit LCD_D6 at RC7_bit;
sbit LCD_D5 at RC6_bit;
sbit LCD_D4 at RC2_bit;
// Pin direction
sbit LCD_RS_Direction at TRISC0_bit;
sbit LCD_EN_Direction at TRISC1_bit;
sbit LCD_D7_Direction at TRISA0_bit;
sbit LCD_D6_Direction at TRISC7_bit;
sbit LCD_D5_Direction at TRISC6_bit;
sbit LCD_D4_Direction at TRISC2_bit;

unsigned int alfa, alfaAnt;
float overflow, time, frecuencia, maxTime = 2.097152;  //MaxTime para prescaler 64 -> 30lat/min
float fosc = (4.0/8000000.0)*64.0;//PRESCALER
char txt[14];
char cont = 0;

void interrupt(){
	//Flanco de subida en INT0
	if(INTCON.INT0IF){
		alfa = TMR0L;
		alfa =  alfa + (TMR0H<<8);
		TMR0H = 0;
		TMR0L = 0;
		if(alfa!=alfaAnt){
			overflow = cont*maxTime;
			time = (fosc*alfa)+overflow;
			frecuencia = 1.0/time*60.0; //se multiplica por 60seg
			WordToStr(frecuencia,txt);
			Lcd_Cmd(_LCD_CLEAR);
			Lcd_out(1,1,txt);
			Lcd_out_CP(" lat/min");
			alfaAnt = alfa;
		}
		cont = 0;
		INTCON.INT0IF = 0 ;
	}
	//Desbordamiento del Timer0
	if(INTCON.TMR0IF){
		cont++;
		INTCON.TMR0IF = 0;
	}
}
void main() {
	TRISB.B0 = 1; //Se configura como entrada
	Lcd_Init();
	ADCON1 = 0x0F; //se configuran los terminales AN como E/S digitales
	CMCON = 0x07; //se apagan los comparadores analógicos

	//Interrupciones INT0
	INTCON.INT0IF = 0 ; //Se pone flag a 0
	INTCON.INT0IE = 1 ;  //Se habilita la interrupcion INT0
	INTCON2.RBPU = 0; //Se habilita la resistencia de pullup
	INTCON2.INTEDG0 = 1; // Se habilita por flanco de subida
	INTCON.GIE = 1; // Se habilitan las interrupciones en general

	//Interrupciones TIMER
	T0CON = 0x85; //1100X0101 -> Modo 16Bits; PRE = 64
	INTCON.TMR0IF = 0; //Se pone flag a 0
	INTCON.TMR0IE = 1;   //Se habilitan interrupciones Timer0
	TMR0H = 0;
	TMR0L = 0;

	while(1);
}