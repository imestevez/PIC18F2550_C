/*
	PARTE II
	
	EMISOR
*/
float temperatura;
int  valor;
unsigned short int *puntero; //puntero es una variable especial que guarda la dirección de una variable (normal) en memoria
unsigned short int aux1, aux2, aux3, aux4;

void interrupt(){
   //Interrupcion A/D
   if(PIR1.ADIF){
		valor = ADRESL+(ADRESH<<8); //Se recoge el valor del convertidor A/D
		temperatura =100.0*((valor*(5.0/1024.0))-0.5);
		puntero = &temperatura; //puntero guarda la dirección en memoria de la variable temperatura

		UART1_Write(*puntero); // envía por Uart 1a posicion memoria
		delay_ms(100);
		UART1_Write(*(puntero+1)); // envía por Uart 2a posicion memoria
		delay_ms(100);
		UART1_Write(*(puntero+2)); // envía por Uart 3a posicion memoria
		delay_ms(100);
		UART1_Write(*(puntero+3)); // envía por Uart 4a posicion memoria
		delay_ms(100);

		PIR1.RCIF = 0;
   }
	//Desbordamiento del Timer0
	if(INTCON.TMR0IF){
		TMR0H = (18661>>8); //1,5seg
		TMR0L = 18661;

		ADCON0.GO = 1; // inicia conversion A/D
		INTCON.TMR0IF = 0;
	}
}

void main() {
    TRISA.B0 = 1;

	ADCON0 = 0x01; //AN0
	ADCON1 = 0;
	ADCON2 = 0x83;

	//Interrupciones TIMER
	T0CON = 0x85; //1100X0101 -> Modo 16Bits; PRE = 64
	INTCON.TMR0IF = 0; //Se pone flag a 0
	INTCON.TMR0IE = 1; //Se habilita interrrupcion Timer0

	PIR1.ADIF = 0; //flag a 0
	PIE1.ADIE = 1; //interrupcion de convertidor A/D
	INTCON.PEIE = 1; //interrupciones perifericas
	INTCON.GIE = 1; // Se habilitan las interrupciones en general

	UART1_Init(9600);
	delay_ms(300);

	TMR0H = (18661>>8); //1,5seg
	TMR0L = 18661;

    while(1);
}