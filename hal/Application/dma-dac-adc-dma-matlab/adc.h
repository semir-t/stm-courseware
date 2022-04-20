#ifndef __ADC_H
#define __ADC_H 
#include "stm32f4xx.h"
#include "stm32f4xx_hal.h"
#include "config.h"

extern volatile uint16_t g_adc_buff[2*ADC_BUFFER_SIZE];
extern volatile uint16_t * g_adc_buff0;
extern volatile uint16_t * g_adc_buff1;
extern volatile uint8_t cBuffer;
extern ADC_HandleTypeDef hadc1;
extern DMA_HandleTypeDef hdma_adc1;

void initADC(void);
uint16_t getADC(void);

#endif 
