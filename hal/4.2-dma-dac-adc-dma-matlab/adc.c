#include "adc.h"
#include "usart.h"

ADC_HandleTypeDef hadc1;
DMA_HandleTypeDef hdma_adc1;
TIM_HandleTypeDef htim3;

volatile uint16_t g_adc_buff[2*ADC_BUFFER_SIZE];
volatile uint16_t * g_adc_buff0 = g_adc_buff;
volatile uint16_t * g_adc_buff1 = &g_adc_buff[ADC_BUFFER_SIZE];
volatile uint8_t cBuffer = 0;
volatile uint8_t g_adc_idx = 0;

// #define ADC_DEBUG

void initADC(void)
{
	{	// init DMA
		/* DMA controller clock enable */
		__HAL_RCC_DMA2_CLK_ENABLE();

		/* DMA interrupt init */
		/* DMA2_Stream0_IRQn interrupt configuration */
		HAL_NVIC_SetPriority(DMA2_Stream0_IRQn, 0, 0);
		HAL_NVIC_EnableIRQ(DMA2_Stream0_IRQn);

	}
	{	// initialzie GPIO
		GPIO_InitTypeDef GPIO_InitStruct;
		__HAL_RCC_GPIOC_CLK_ENABLE();
		GPIO_InitStruct.Pin = GPIO_PIN_5;
		GPIO_InitStruct.Mode = GPIO_MODE_ANALOG;
		HAL_GPIO_Init(GPIOC, &GPIO_InitStruct);

	
	}
	{	// initialize TIM3 for ADC sample request
		__HAL_RCC_TIM3_CLK_ENABLE();
		TIM_MasterConfigTypeDef sMasterConfig = {0};

		htim3.Instance = TIM3;
		htim3.Init.Prescaler = 100;
		htim3.Init.CounterMode = TIM_COUNTERMODE_UP;
		htim3.Init.Period = 84;
		htim3.Init.ClockDivision = TIM_CLOCKDIVISION_DIV1;
		htim3.Init.RepetitionCounter = 0;
		htim3.Init.AutoReloadPreload = TIM_AUTORELOAD_PRELOAD_ENABLE;
		if (HAL_TIM_Base_Init(&htim3) != HAL_OK)
		{

		}

		sMasterConfig.MasterOutputTrigger = TIM_TRGO_UPDATE;
		sMasterConfig.MasterSlaveMode = TIM_MASTERSLAVEMODE_DISABLE;
		if (HAL_TIMEx_MasterConfigSynchronization(&htim3, &sMasterConfig) != HAL_OK)
		{

		}

	}
	{

		__HAL_RCC_ADC1_CLK_ENABLE();
		hadc1.Instance = ADC1;
		// hadc1.Init.ClockPrescaler = ADC_CLOCK_ASYNC_DIV1;
		hadc1.Init.Resolution = ADC_RESOLUTION_12B;
		hadc1.Init.DataAlign = ADC_DATAALIGN_RIGHT;
		hadc1.Init.EOCSelection = ADC_EOC_SINGLE_CONV;
		hadc1.Init.ContinuousConvMode = DISABLE;
		hadc1.Init.DiscontinuousConvMode = DISABLE;
		hadc1.Init.ExternalTrigConv = ADC_EXTERNALTRIGCONV_T3_TRGO;
		hadc1.Init.ExternalTrigConvEdge = ADC_EXTERNALTRIGCONVEDGE_RISING;
		hadc1.Init.DMAContinuousRequests = ENABLE;
		// hadc1.Init.Overrun = ADC_OVR_DATA_PRESERVED;
		if (HAL_ADC_Init(&hadc1) != HAL_OK)
		{

		}
		/** Configure for the selected ADC regular channel to be converted. 
		 *   */

		ADC_ChannelConfTypeDef sConfig = {0};
		sConfig.Channel = ADC_CHANNEL_15;
		sConfig.Rank = 1;
		sConfig.SamplingTime = ADC_SAMPLETIME_3CYCLES;
		if (HAL_ADC_ConfigChannel(&hadc1, &sConfig) != HAL_OK)
		{
		}

#ifdef ADC_DEBUG
		HAL_NVIC_SetPriority(ADC_IRQn, 0, 0);
		HAL_NVIC_EnableIRQ(ADC_IRQn);
#endif
	}
	{	// init DMA

		__DMA2_CLK_ENABLE(); 
		hdma_adc1.Instance = DMA2_Stream0;

		hdma_adc1.Init.Channel  = DMA_CHANNEL_0;
		hdma_adc1.Init.Direction = DMA_PERIPH_TO_MEMORY;
		hdma_adc1.Init.PeriphInc = DMA_PINC_DISABLE;
		hdma_adc1.Init.MemInc = DMA_MINC_ENABLE;
		hdma_adc1.Init.PeriphDataAlignment = DMA_PDATAALIGN_HALFWORD;
		hdma_adc1.Init.MemDataAlignment = DMA_MDATAALIGN_HALFWORD;
		hdma_adc1.Init.Mode = DMA_CIRCULAR;
		hdma_adc1.Init.Priority = DMA_PRIORITY_HIGH;
		hdma_adc1.Init.FIFOMode = DMA_FIFOMODE_DISABLE;         
		hdma_adc1.Init.FIFOThreshold = DMA_FIFO_THRESHOLD_HALFFULL;
		hdma_adc1.Init.MemBurst = DMA_MBURST_SINGLE;
		hdma_adc1.Init.PeriphBurst = DMA_PBURST_SINGLE; 

		HAL_DMA_Init(&hdma_adc1);

		__HAL_LINKDMA(&hadc1, DMA_Handle, hdma_adc1);

		HAL_NVIC_SetPriority(DMA2_Stream0_IRQn, 0, 0);   
		HAL_NVIC_EnableIRQ(DMA2_Stream0_IRQn);

	}
	HAL_TIM_Base_Start(&htim3);
#ifdef ADC_DEBUG
	HAL_ADC_Start_IT(&hadc1);
#else
	HAL_ADC_Start_DMA(&hadc1,g_adc_buff,2*ADC_BUFFER_SIZE);
#endif
}

void HAL_ADC_ConvCpltCallback(ADC_HandleTypeDef* AdcHandle)
{
	cBuffer ^= 0x01;
}

void HAL_ADC_ConvHalfCpltCallback(ADC_HandleTypeDef* AdcHandle)
{
	cBuffer ^= 0x01;
}

uint16_t getADC(void)
{
	// HAL_ADC_Start (&hadc1);
	while(HAL_ADC_PollForConversion(&hadc1,10000) != HAL_OK);
	// HAL_ADC_PollForConversion(&hadc1,10000);

	return HAL_ADC_GetValue(&hadc1);
}
