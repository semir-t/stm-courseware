#include "stm32f4xx.h"
#include "stm32f4xx_hal.h"
#include "usart.h"
#include "delay.h"
#include "config.h"
#include "adc.h"
#include "dac.h"


int main(void)
{
	HAL_Init();

	initUSART2(921600);
	initSYSTIM();
	initADC();
	initDAC();

	///wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww 	
	// initalize push button on PA0
	GPIO_InitTypeDef GPIO_InitStruct;
	__HAL_RCC_GPIOA_CLK_ENABLE();
	GPIO_InitStruct.Pin = GPIO_PIN_0;
	GPIO_InitStruct.Mode = GPIO_MODE_INPUT;
	GPIO_InitStruct.Pull = GPIO_NOPULL;
	HAL_GPIO_Init(GPIOA, &GPIO_InitStruct);


	
	printUSART2("-> System running... \n");
	char c;
	uint32_t k;
	uint16_t utmp16;
	// while(1)
	// {
	// 	// printUSART2("-> NDTR[%d]\n",DMA2_Stream0->NDTR);
	// 	// delay_ms(100);
	// 	// printUSART2("-> NDTR[%d]\n",DMA1_Stream5->NDTR);
	// }
	while(1)
	{
		if(HAL_GPIO_ReadPin(GPIOA,GPIO_PIN_0) == 1)
		{
			g_dac_idx++;
			if(g_dac_idx > 3)
			{
				g_dac_idx = 0;
			}

			gendataDAC();
		}
		c = getcharUSART2();
		if(cBuffer)
		{// we can read buffer 0
			// printUSART2("\n[1]\n");
			for(k=0;k<((ADC_BUFFER_SIZE)/4);k++)
			{
				utmp16 = g_adc_buff0[k];
				// printUSART2("%d\n",g_adc_buff0[k]);
				putcharUSART2((utmp16&0xFF00)>>8);
				putcharUSART2(utmp16&0x00FF);

			}
		}
		else
		{// we can read buffer 1
			// printUSART2("\n[2]\n");
			for(k=0;k<((ADC_BUFFER_SIZE)/4);k++)
			{
				// printUSART2("%d\n",g_adc_buff1[k]);
				utmp16 = g_adc_buff1[k];
				putcharUSART2((utmp16&0xFF00)>>8);
				putcharUSART2(utmp16&0x00FF);

			}
		}


	}
}


