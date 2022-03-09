
void initADC(void)
{
	//wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww
	// ADC PA1 -> ADC123_IN1 
	//------------------------------------------------------------------ 
	
	GPIO_InitTypeDef GPIO_InitStruct;
	__HAL_RCC_GPIOC_CLK_ENABLE();
	GPIO_InitStruct.Pin = GPIO_PIN_5;
	GPIO_InitStruct.Mode = GPIO_MODE_ANALOG;
	HAL_GPIO_Init(GPIOC, &GPIO_InitStruct);

	{	// initialize TIM3 for ADC sample request
		__HAL_RCC_TIM3_CLK_ENABLE();
		TIM_MasterConfigTypeDef sMasterConfig = {0};

		htim3.Instance = TIM3;
		htim3.Init.Prescaler = 0;
		htim3.Init.CounterMode = TIM_COUNTERMODE_UP;
		htim3.Init.Period = 999;
		htim3.Init.ClockDivision = TIM_CLOCKDIVISION_DIV1;
		htim3.Init.RepetitionCounter = 0;
		htim3.Init.AutoReloadPreload = TIM_AUTORELOAD_PRELOAD_DISABLE;
		if (HAL_TIM_Base_Init(&htim3) != HAL_OK)
		{

		}

		sMasterConfig.MasterOutputTrigger = TIM_TRGO_UPDATE;
		sMasterConfig.MasterSlaveMode = TIM_MASTERSLAVEMODE_DISABLE;
		if (HAL_TIMEx_MasterConfigSynchronization(&htim3, &sMasterConfig) != HAL_OK)
		{

		}

	}

	__HAL_RCC_ADC1_CLK_ENABLE();
	hadc1.Instance = ADC1;
	hadc1.Init.ClockPrescaler = ADC_CLOCK_ASYNC_DIV1;
	hadc1.Init.Resolution = ADC_RESOLUTION_12B;
	hadc1.Init.DataAlign = ADC_DATAALIGN_RIGHT;
	hadc1.Init.ScanConvMode = ADC_SCAN_DIRECTION_FORWARD;
	hadc1.Init.EOCSelection = ADC_EOC_SINGLE_CONV;
	hadc1.Init.ContinuousConvMode = DISABLE;
	hadc1.Init.DiscontinuousConvMode = DISABLE;
	hadc1.Init.ExternalTrigConv = ADC_EXTERNALTRIGCONV_T3_TRGO;
	hadc1.Init.ExternalTrigConvEdge = ADC_EXTERNALTRIGCONVEDGE_RISING;
	hadc1.Init.DMAContinuousRequests = ENABLE;
	hadc1.Init.Overrun = ADC_OVR_DATA_PRESERVED;
	if (HAL_ADC_Init(&hadc) != HAL_OK)
	{

	}
	/** Configure for the selected ADC regular channel to be converted. 
	 *   */
	sConfig.Channel = ADC_CHANNEL_15;
	sConfig.Rank = ADC_RANK_CHANNEL_NUMBER;
	sConfig.SamplingTime = ADC_SAMPLETIME_3CYCLES;
	if (HAL_ADC_ConfigChannel(&hadc1, &sConfig) != HAL_OK)
	{
		Error_Handler();
	}

	// HAL_ADC_Start (&hadc1);
	// NVIC_InitTypeDef       NVIC_InitStructure;
// #ifdef ADC_DEBUG 
	// NVIC_InitStructure.NVIC_IRQChannel                   = ADC_IRQn;
	// NVIC_InitStructure.NVIC_IRQChannelPreemptionPriority = 1;
	// NVIC_InitStructure.NVIC_IRQChannelCmd                = ENABLE;
	// NVIC_Init (&NVIC_InitStructure);
// #endif

	// NVIC_InitStructure.NVIC_IRQChannel                   = DMA2_Stream0_IRQn;
	// NVIC_InitStructure.NVIC_IRQChannelPreemptionPriority = 1;
	// NVIC_InitStructure.NVIC_IRQChannelCmd                = ENABLE;
	// NVIC_Init (&NVIC_InitStructure);

	// DMA_InitTypeDef hdma_adc;
	// hdma_adc.Channel = DMA_Channel0;
	// hdma_adc.Direction = DMA_PERIPH_TO_MEMORY;
	// hdma_adc.PeriphInc = DMA_PINC_DISABLE;
	// hdma_adc.MemInc = DMA_MINC_ENABLE;
	// hdma_adc.PeriphDataAlignment = DMA_PDATAALIGN_HALFWORD;
	// hdma_adc.MemDataAlignment = DMA_MDATAALIGN_HALFWORD;
	// hdma_adc.Mode = DMA_CIRCULAR;
	// hdma_adc.Priority = DMA_PRIORITY_HIGH;
	// if (HAL_DMA_Init(&hdma_adc) != HAL_OK)
	// {

	// }
	// __HAL_LINKDMA(hadc1,DMA_Handle,hdma_adc);

	HAL_TIM_Base_Start(&htim3);
	HAL_ADC_Start_IT(&hadc1);
	// HAL_ADC_Start_DMA(&hadc, (uint32_t*)g_adc_buff0, 2 * ADC_BUFFER_SIZE);
}
