Descripcion:
	Sistema que cada 1,5 segundos envíe por radiofrecuencia la temperatura de un sensor
	MCP700 a otro microcontrolador.
	La versión del sensor MCP700 disponible mide temperaturas pertenecientes al intervalo −40ºC ≤ T ≤ +125ºC. 
	Se simula la transmisión conectando con un cable el receptor y emisor, pero se podrían utilizar radiomodems de la
	empresa Radiometrix. 
		Emisor: TXL2-433-9.
		Receptor: RXL2-433-9
	
	Se hará uso del timer del PIC para contar los 1,5seg y del conversor A/D para la lectura de la temperatura.
Componenetes en ISIS:
	PIC18F2550, LM016L, MCP9700. 
