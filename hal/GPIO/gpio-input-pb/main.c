#include "stm32f4xx.h"
#include "stm32f4xx_hal.h"

void delay_ms_soft(uint32_t ms);

int main(void)
{

	///wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww
	/// initialize 4 LED's on the board 
	GPIO_InitTypeDef GPIO_InitStruct;
	__HAL_RCC_GPIOD_CLK_ENABLE();
	GPIO_InitStruct.Pin = GPIO_PIN_12|GPIO_PIN_13 | GPIO_PIN_14 | GPIO_PIN_15;
	GPIO_InitStruct.Mode = GPIO_MODE_OUTPUT_PP;
	GPIO_InitStruct.Pull = GPIO_NOPULL;
	GPIO_InitStruct.Speed = GPIO_SPEED_HIGH;
	HAL_GPIO_Init(GPIOD, &GPIO_InitStruct);
	
	///wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww 	
	// initalize push button on PA0
	__HAL_RCC_GPIOA_CLK_ENABLE();
	GPIO_InitStruct.Pin = GPIO_PIN_0;
	GPIO_InitStruct.Mode = GPIO_MODE_INPUT;
	GPIO_InitStruct.Pull = GPIO_NOPULL;
	HAL_GPIO_Init(GPIOA, &GPIO_InitStruct);

	uint8_t state = 0;
    uint8_t prev_state = 0;
    uint8_t tmp = 0;
	while(1)
	{
        state = HAL_GPIO_ReadPin(GPIOA,GPIO_PIN_0);
		if(prev_state != state)
		{
            if((prev_state == 0) && (state == 1))
            {
                tmp ^= 0x01;
                HAL_GPIO_WritePin(GPIOD,GPIO_PIN_12,tmp);
                HAL_GPIO_WritePin(GPIOD,GPIO_PIN_13,tmp);
                HAL_GPIO_WritePin(GPIOD,GPIO_PIN_14,tmp);
                HAL_GPIO_WritePin(GPIOD,GPIO_PIN_15,tmp);
            }
            prev_state = state;
            delay_ms_soft(50);
        }

	}
}


void delay_ms_soft(uint32_t ms)
{
	volatile uint32_t k = 10500 * ms;
	while(k--);
}
