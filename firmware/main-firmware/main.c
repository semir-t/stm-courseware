#include "stm32f4xx.h"

void delay_soft_ms(uint32_t cnt);

int main(void)
{
	///wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww
	/// initialize 4 LED's on the board 
	RCC->AHB1ENR |= RCC_AHB1ENR_GPIODEN;  								// enable the clock for GPIOD
    GPIOD->MODER |= 0x55000000;             							// set PORTD pin 12,13,14,15 as output
    GPIOD->OTYPER = 0x00000000;											// Output push-pull 
    GPIOD->OSPEEDR |= 0xFFF00000; 										// set max speed

	GPIOD->ODR &= ~(0x000F << 12);										// Clear all LEDs
	///wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww 	
	while(1)
	{
		delay_soft_ms(1000);
		GPIOD->ODR ^= 0xf000;
	}
}


void delay_soft_ms(uint32_t cnt)
{
	/// primitivna rutina za kasnjenje
	volatile uint32_t time = cnt*10500;
	while(time)
	{
		time--;
	}
	return;
}
