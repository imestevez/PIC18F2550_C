#line 1 "C:/Users/ivan/Documents/Informatica/3º Curso/2º Cuatrimestre/HAE/Proyecto/Parte I/Codigo/proyecto.c"

sbit LCD_RS at RC0_bit;
sbit LCD_EN at RC1_bit;
sbit LCD_D7 at RA0_bit;
sbit LCD_D6 at RC7_bit;
sbit LCD_D5 at RC6_bit;
sbit LCD_D4 at RC2_bit;

sbit LCD_RS_Direction at TRISC0_bit;
sbit LCD_EN_Direction at TRISC1_bit;
sbit LCD_D7_Direction at TRISA0_bit;
sbit LCD_D6_Direction at TRISC7_bit;
sbit LCD_D5_Direction at TRISC6_bit;
sbit LCD_D4_Direction at TRISC2_bit;

unsigned int alfa, alfaAnt;
float overflow, time, frecuencia, maxTime = 2.097152;
float fosc = (4.0/8000000.0)*64.0;
char txt[14];
char cont = 0;

void interrupt(){

 if(INTCON.INT0IF){
 alfa = TMR0L;
 alfa = alfa + (TMR0H<<8);
 TMR0H = 0;
 TMR0L = 0;
 if(alfa!=alfaAnt){
 overflow = cont*maxTime;
 time = (fosc*alfa)+overflow;
 frecuencia = 1.0/time*60.0;
 WordToStr(frecuencia,txt);
 Lcd_Cmd(_LCD_CLEAR);
 Lcd_out(1,1,txt);
 Lcd_out_CP(" lat/min");
 alfaAnt = alfa;
 }
 cont = 0;
 INTCON.INT0IF = 0 ;
 }

 if(INTCON.TMR0IF){
 cont++;
 INTCON.TMR0IF = 0;
 }
}

void main() {
 TRISB.B0 = 1;
 Lcd_Init();
 ADCON1 = 0x0F;
 CMCON = 0x07;


 INTCON.INT0IF = 0 ;
 INTCON.INT0IE = 1 ;
 INTCON2.RBPU = 0;
 INTCON2.INTEDG0 = 1;
 INTCON.GIE = 1;


 T0CON = 0x85;
 INTCON.TMR0IF = 0;
 INTCON.TMR0IE = 1;
 TMR0H = 0;
 TMR0L = 0;

 while(1);

}
