#line 1 "C:/Users/ivan/Documents/Informatica/3º Curso/2º Cuatrimestre/HAE/Proyecto/Parte II/Codigo/Emisor.c"

float temperatura;
int valor;
unsigned short int *puntero;
unsigned short int aux1, aux2, aux3, aux4;

void interrupt(){

 if(PIR1.ADIF){
 valor = ADRESL+(ADRESH<<8);
 temperatura =100.0*((valor*(5.0/1024.0))-0.5);
 puntero = &temperatura;

 UART1_Write(*puntero);
 delay_ms(100);
 UART1_Write(*(puntero+1));
 delay_ms(100);
 UART1_Write(*(puntero+2));
 delay_ms(100);
 UART1_Write(*(puntero+3));
 delay_ms(100);

 PIR1.RCIF = 0;
 }

 if(INTCON.TMR0IF){
 TMR0H = (18661>>8);
 TMR0L = 18661;

 ADCON0.GO = 1;
 INTCON.TMR0IF = 0;
 }
}

void main() {
 TRISA.B0 = 1;

 ADCON0 = 0x01;
 ADCON1 = 0;
 ADCON2 = 0x83;


 T0CON = 0x85;
 INTCON.TMR0IF = 0;
 INTCON.TMR0IE = 1;

 PIR1.ADIF = 0;
 PIE1.ADIE = 1;
 INTCON.PEIE = 1;
 INTCON.GIE = 1;

 UART1_Init(9600);
 delay_ms(300);

 TMR0H = (18661>>8);
 TMR0L = 18661;

 while(1);

}
