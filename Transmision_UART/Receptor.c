/*
	PARTE II
	
	RECEPTOR
*/

// Lcd pinout settings
sbit LCD_RS at RB2_bit;
sbit LCD_EN at RB3_bit;
sbit LCD_D7 at RB7_bit;
sbit LCD_D6 at RB6_bit;
sbit LCD_D5 at RB5_bit;
sbit LCD_D4 at RB4_bit;
// Pin direction
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
	//interrupcion  recepcion UART
	if(PIR1.RCIF){
		*(puntero+cont) = UART1_Read();
		cont++;
		//Si se completo la transferencia de 4 Bytes
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

     ADCON1 = 0x0F; //se configuran los terminales AN como E/S digitales
     CMCON = 0x07; //se apagan los comparadores analógicos

     Lcd_Init();
     UART1_Init(9600);
     delay_ms(300);
     puntero = &temperatura; //puntero guarda la dirección en memoria de la variable temperatura

     PIR1.RCIF = 0; //se pone a cero el flag de la interrupción RCIE
     PIE1.RCIE = 1; // se habilita la interrupción RCIE
     INTCON.PEIE = 1; //interrupciones perifericas
     INTCON.GIE = 1; // Se habilitan las interrupciones en general

     while(1);
}