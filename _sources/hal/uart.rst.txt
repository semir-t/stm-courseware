U(S)ART 
*******

USART(Universal Synchronous Asynchronous Transmitter Receiver) is the peripheral wich implements the USART/UART protocol. USART is full-duplex communication protocol, which means that it can transfer data in both directions at the same time. 

Physical characteristics
========================
USART protocol defines 3 lines:
    * Tx - Transmit line
    * Rx - Receive line
    * Sck - Synchronization line

Unlike the USART, UART has only two lines:
    * Tx - Transmit line
    * Rx - Receive line

USART/UART can have software or hardware flow-control. For this purpose we have two additional lines:
    * CTS - Clear to send
    * RTS - Requst to send


Connection diagram
==================
USART/UART network is point-to-point network, which means that only two devicees can be connected to each other. Connection diagram is shown bellow.

.. image:: images/hal-uart-connection.png

As we can see, *Tx* line of first device is connected to the *Rx* line of the second device. Also, *Tx* line of second device is connected to *Rx* line of first device. Additionally, in the case of the USART, *Sck* line of the first device is connected to the *Sck* line of the second device.

Same as the Rx and Tx lines are croswise connected, CTS and RTS lines are also croswise connected as shown on the image bellow:

.. image:: images/hal-uart-cts-rts.png


Timing diagram
==============
UART doesn't have synchronization mechanisam, so data on the transmission line is sampled in the middle of the bit interval. Timing diagram is shown on the image bellow:

.. image:: images/hal-uart-timing-diagram.png

Because UART doesn't have synchronization mechanisam, it is essential that the two devices that communicate using the UART protocl have set the same transfer speed. Also, both device must have stable clock source for this protocol to work. Transfer speeds are standardised and some of them are:
    * 300
    * 600
    * 1200
    * 2400
    * 4800
    * 9600
    * 19200
    * 38400
    * 57600
    * 115200
    * 230400
    * 460800
    * 921600

Package Format
==============
USART/UART consists of:
    * Start bit - 1b
    * Data frame - 7b,8b or 9b depending on the aplication
    * Parity bit - 1b
    * Stop bit(s) - 1b or 2b
    
Start bit
---------
The UART data transmission line is normally held at a high voltage level when it’s not transmitting data. To start the transfer of data, the transmitting UART pulls the transmission line from high to low for one clock cycle. When the receiving UART detects the high to low voltage transition, it begins reading the bits in the data frame at the frequency of the baud rate.

Data Frame
----------
The data frame contains the actual data being transferred. It can be 7 or 8 bits long if a parity bit is used. If no parity bit is used, the data frame can be 9 bits long. In most cases, the data is sent with the least significant bit first.

Parity bit
----------
Parity describes the evenness or oddness of a number. The parity bit is a way for the receiving UART to tell if any data has changed during transmission. Bits can be changed by electromagnetic radiation, mismatched baud rates, or long distance data transfers. After the receiving UART reads the data frame, it counts the number of bits with a value of 1 and checks if the total is an even or odd number. If the parity bit is a 0 (even parity), the 1 bits in the data frame should total to an even number. If the parity bit is a 1 (odd parity), the 1 bits in the data frame should total to an odd number. When the parity bit matches the data, the UART knows that the transmission was free of errors. But if the parity bit is a 0, and the total is odd; or the parity bit is a 1, and the total is even, the UART knows that bits in the data frame have changed.

Stop bit
--------
To signal the end of the data packet, the sending UART drives the data transmission line from a low voltage to a high voltage for at least two bit durations.

Example
=======

Initializing UART
-----------------
To initialize UART we need to follow bellow steps:
    * Enable clock for dedicated GPIO 
    * Configure GPIO pin(s) as an Alternative function
    * Enable clock for UART
    * Using the UART Init Struct configure the UART
    * Enable the UART with desired configuration

Following code will initialize pin PA2 and PA3 as an alternative function pin. After we have set the mode of the pin to alternative function, we need to then configure desired alternative function. Each pin can have up to 15 alternative functions, and information about alternative funcions for each pin can be found in the datasheet.

In our case, we want this pin to perform UART funciontionality. From the bellow image we can see that for the pin PA2 we need to select alternative function 7 for this pin to perfome UART functionality.

.. image:: images/hal-uart-af.png

.. code-block:: c

	GPIO_InitTypeDef GPIO_InitStruct;
	__HAL_RCC_GPIOA_CLK_ENABLE();
	GPIO_InitStruct.Pin = GPIO_PIN_2;
	GPIO_InitStruct.Mode = GPIO_MODE_AF_PP;
	GPIO_InitStruct.Pull = GPIO_NOPULL;
	GPIO_InitStruct.Speed = GPIO_SPEED_FREQ_HIGH;
	GPIO_InitStruct.Alternate = GPIO_AF7_USART2;
	HAL_GPIO_Init(GPIOA, &GPIO_InitStruct);
    
    GPIO_InitStruct.Pin = GPIO_PIN_3;
	GPIO_InitStruct.Mode = GPIO_MODE_AF_PP;
	GPIO_InitStruct.Pull = GPIO_NOPULL;
	GPIO_InitStruct.Speed = GPIO_SPEED_FREQ_HIGH;
	GPIO_InitStruct.Alternate = GPIO_AF7_USART2;
	HAL_GPIO_Init(GPIOA, &GPIO_InitStruct);
    
Next step is to configure UART peripheral. Following configuration is implemented in the bellow code
    * Desired baudrate passed as an argument to a function call
    * 8-bit data frame
    * 1 stop bit
    * No parity bits.

.. code-block:: c

	UART_InitTypeDef UART_InitStruct;
	__HAL_RCC_USART2_CLK_ENABLE();
	UART_InitStruct.BaudRate = baudrate;
	UART_InitStruct.WordLength = UART_WORDLENGTH_8B;
	UART_InitStruct.StopBits = UART_STOPBITS_1;
	UART_InitStruct.Parity = UART_PARITY_NONE;
	UART_InitStruct.Mode = UART_MODE_TX;
	UART_InitStruct.HwFlowCtl = UART_HWCONTROL_NONE;
	UART_InitStruct.OverSampling = UART_OVERSAMPLING_8;
    
After we have configure Init structure, we need to initialize the desired UART peripheral. We are going to initialize USART2 with the following code. Desired configuration and UART will be linked with the Handler variable which will be used to send/receive data through UART.

.. code-block:: c

    UART_HandleStruct.Instance = USART2;
	UART_HandleStruct.Init = UART_InitStruct;
	HAL_UART_Init(&UART_HandleStruct);

Send byte through UART (Blocking)
---------------------------------

Following code represents the functions that will send 1 byte through UART interface.

.. code-block:: c

    void putcharUSART2(uint8_t data)
    {
        HAL_UART_Transmit(&UART_HandleStruct, & data,1,10000);
    }
    
To transmit data, we use the **HAL_UART_Transmit(arg1,arg2,arg3,arg4)** function, where:
    * arg1 - Address of the USART Handler variable
    * arg2 - Address of the data array that we want to send
    * arg3 - Number of bytes that we want to sedn through USART interface
    * arg4 - Timeout. If data is not sent in specified amount of time, transmision of data will be aborted.
    
Receive byte through UART (Blocking)
------------------------------------
Following code represents the funcions which that will receive 1 byte through UART interface.

.. code-block:: c

    uint8_t getcharUSART2(void)
    {
        uint8_t data;
        while(HAL_UART_Receive(&UART_HandleStruct, & data,1,10000));
        return data;
    }

To receive data, we use the **HAL_UART_Receive(arg1,arg2,arg3,arg4)** function, where:
    * arg1 - Address of the USART Handler variable
    * arg2 - Address of the data array where we will store incoming data
    * arg3 - Number of bytes that we want to receive through UART interface
    * arg4 - Timeout. If data is not received in specified amount of time, transmision of data will be aborted.
