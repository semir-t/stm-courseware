#include "dac.h"

#include "math.h"
#include "usart.h"

DAC_HandleTypeDef hdac;
DMA_HandleTypeDef hdma_dac1;
TIM_HandleTypeDef htim6;

volatile uint16_t c_dac_buffer[DAC_BUFFER_SIZE];
volatile uint8_t g_dac_idx = 0;

void initDAC(void)
{
	__HAL_RCC_GPIOA_CLK_ENABLE();
	GPIO_InitTypeDef GPIO_InitStruct;
	GPIO_InitStruct.Pin = GPIO_PIN_4;
	GPIO_InitStruct.Mode = GPIO_MODE_ANALOG;
	HAL_GPIO_Init(GPIOC, &GPIO_InitStruct);

	gendataDAC();

	{
		__HAL_RCC_DAC_CLK_ENABLE();
		DAC_ChannelConfTypeDef sConfig;
		hdac.Instance = DAC;
		HAL_DAC_Init(&hdac);

		sConfig.DAC_Trigger = DAC_TRIGGER_T6_TRGO;
		sConfig.DAC_OutputBuffer = DAC_OUTPUTBUFFER_ENABLE;
		HAL_DAC_ConfigChannel(&hdac, &sConfig, DAC_CHANNEL_1);

	}
	{
		__HAL_RCC_TIM6_CLK_ENABLE();
		TIM_ClockConfigTypeDef sClockSourceConfig;
		TIM_MasterConfigTypeDef sMasterConfig;

		htim6.Instance = TIM6;
		htim6.Init.Prescaler = 84;			//  1MHz 
		htim6.Init.CounterMode = TIM_COUNTERMODE_UP;
		htim6.Init.Period = 10;		//10kHz
		htim6.Init.ClockDivision = TIM_CLOCKDIVISION_DIV1;
		HAL_TIM_Base_Init(&htim6);

		sMasterConfig.MasterOutputTrigger = TIM_TRGO_UPDATE;
		sMasterConfig.MasterSlaveMode = TIM_MASTERSLAVEMODE_ENABLE;
		if (HAL_TIMEx_MasterConfigSynchronization(&htim6, &sMasterConfig) != HAL_OK)
		{

		}

	}
	{	// init DMA
		/* DMA controller clock enable */
		__HAL_RCC_DMA1_CLK_ENABLE();

		/* DMA interrupt init */
		/* DMA1_Stream0_IRQn interrupt configuration */


		hdma_dac1.Instance = DMA1_Stream5;

		hdma_dac1.Init.Channel  = DMA_CHANNEL_7;
		hdma_dac1.Init.Direction = DMA_MEMORY_TO_PERIPH;
		hdma_dac1.Init.PeriphInc = DMA_PINC_DISABLE;
		hdma_dac1.Init.MemInc = DMA_MINC_ENABLE;
		hdma_dac1.Init.PeriphDataAlignment = DMA_PDATAALIGN_HALFWORD;
		hdma_dac1.Init.MemDataAlignment = DMA_MDATAALIGN_HALFWORD;
		hdma_dac1.Init.Mode = DMA_CIRCULAR;
		hdma_dac1.Init.Priority = DMA_PRIORITY_HIGH;
		hdma_dac1.Init.FIFOMode = DMA_FIFOMODE_DISABLE;         
		hdma_dac1.Init.FIFOThreshold = DMA_FIFO_THRESHOLD_HALFFULL;
		hdma_dac1.Init.MemBurst = DMA_MBURST_SINGLE;
		hdma_dac1.Init.PeriphBurst = DMA_PBURST_SINGLE; 

		HAL_DMA_Init(&hdma_dac1);

		__HAL_LINKDMA(&hdac, DMA_Handle1, hdma_dac1);

		// HAL_NVIC_SetPriority(DMA1_Stream5_IRQn, 0, 0);
		// HAL_NVIC_EnableIRQ(DMA1_Stream5_IRQn);
	}

	HAL_DAC_Start_DMA(&hdac, DAC_CHANNEL_1,c_dac_buffer,DAC_BUFFER_SIZE,DAC_ALIGN_12B_R);
	HAL_TIM_Base_Start(&htim6);
}

void gendataDAC(void)
{
	uint16_t n;
	float y, t =0;
	uint8_t pb = g_dac_idx;
	for(n=0;n<(DAC_BUFFER_SIZE);n++)
	{
		if(pb == 0x00)
		{// sine wave
			y = 0.3*sinf(2*PI*1000*t)+0.5;
		}
		else if(pb == 0x01)
		{// linear combination of sine waves
			y = 0.2*sinf(2*PI*100*t)+0.5 +0.1*sinf(2*PI*800*t);
		}
		else if(pb == 0x02)
		{// triangle wave
			if(t<(T1))
			{
				y = t/(T1) + 1;

			}
			else if(t<(T2))
			{
				y = -2*(t-(T1))/((T2)-(T1)) + 2;

			}
			else if(t<(T3))
			{
				y = (t-(T2))/((T3) - (T2));

			}
			else
			{
				t = 0;
				y = t/(T1) + 1;

			}
			y = y/3;
		}
		else if(pb == 0x03)
		{// square wave
			if(t<T1)
			{
				y = 1;

			}
			else if(t<T2)
			{
				y = 0;

			}
			else
			{
				t = 0;
				y = 1;

			}	
		}

		c_dac_buffer[n] = (uint16_t)(y*4095);

		t = t + 1e-5;

	}
}

void HAL_TIM_PeriodElapsedCallback(TIM_HandleTypeDef *htim)
{
	if(htim->Instance==TIM3) //Fungsi Interrupt Timer
	{
		// printUSART2("->DAC: Set value to [%d]\n",c_dac_buffer[g_dac_idx]);
		HAL_DAC_SetValue(&hdac,DAC_CHANNEL_1,DAC_ALIGN_12B_R,c_dac_buffer[g_dac_idx++]);
		if(g_dac_idx >= DAC_BUFFER_SIZE)
		{
			g_dac_idx = 0;
		}

	}

}
