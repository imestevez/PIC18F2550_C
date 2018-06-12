#line 1 "C:/Users/ivan/Documents/Informatica/3º Curso/2º Cuatrimestre/HAE/Proyecto/Parte II/Codigo/Receptor.c"

sbit LCD_RS at RB2_bit;
sbit LCD_EN at RB3_bit;
sbit LCD_D7 at RB7_bit;
sbit LCD_D6 at RB6_bit;
sbit LCD_D5 at RB5_bit;
sbit LCD_D4 at RB4_bit;

sbit LCD_RS_Direction at TRISB2_bit;
sbit LCD_EN_Direction at TRISB3_bit;
sbit LCD_D7_Direction at TRISB7_bit;
sbit LCD_D6_Direction at TRISB6_bit;
sbit LCD_D5_Direction at TRISB5_bit;
sbit LCD_D4_Direction at TRISB4_bit;

char txt[14];
char cont = 0;
float temperatura;
unsigned short int *puntero;

void interrupt(){

 if(PIR1.RCIF){
 *(puntero+cont) = UART1_Read();
 cont++;

 if(cont > 3 ){
 Lcd_Cmd(_LCD_CLEAR);
 FloatToStr(temperatura,txt);
 Lcd_out(1,1,txt);
 Lcd_out_CP(" *C");
 cont = 0;
 }
 PIR1.RCIF = 0;
 }
 }
void main() {

 ADCON1 = 0x0F;
 CMCON = 0x07;

 Lcd_Init();
 UART1_Init(9600);
 delay_ms(300);
 puntero = &temperatura;

 PIR1.RCIF = 0;
 PIE1.RCIE = 1;
 INTCON.PEIE = 1;
 INTCON.GIE = 1;

 while(1);
}
