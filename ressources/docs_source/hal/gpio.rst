General Purpose Input/Output (GPIO)
===================================

GPIO peripheral represents the interface to interact with external world. This peripheral is used to configure the GPIO pins so that they have desired functionality. Internal block diagram of the GPIO peripheral is shown on the next image.

.. image:: images/hal-gpio-internal-block-diagram.png

For the desired pin,through the GPIO peripheral we can configure following:
    * Mode option
    * Output type 
    * Enable/Disable Pull-Up or Pull-Down
    * Output speed
    * Alternative function of the pin
    * Control/Read state of the pin

GPIO mode of operation
**********************

Pin can be configured to work in the following modes:
    * Digital Input
    * Digital Output
    * Alternative function
    * Analog

Output type of the GPIO
***********************

Output type of the GPIO can be configured to:
    * Push-Pull configuration
    * Open-Drain configuration
    
.. image:: images/hal-gpio-output-type.png

With the Push-Pull configuration, we can set the state of the output pin to **High** or **Low**. With the Open-Drain confiugration, output pin can be either in state **Low** or **Hi-Zi** (High impedance - Can be interpreted as an open circuit). Open-Drain configuration enables us to drain higher current than the Push-Pull configuration. 

Pull-Up and Pull-Down configuration
***********************************

GPIO peripheral integrates internal Pull-Up and Pull-Down resistor. We can have one of the following configuration regarding the pull resistors:
    * Pull-Up and Pull-Down resistor disabled
    * Pull-Up resistor enabled
    * Pull-Down resistor enabled

.. image:: images/hal-gpio-pupdr.png


With the Pull-Up configuration, in the **IDLE** state line will be pulled to state **High**. With the Pull-Down configuration, in the **IDLE** state line wiill be pulled to state **Low**. 

Output speed configuration
**************************

We can configure output speed for the pin to the one of the following values:
    * Low speed
    * Medium speed
    * Full speed
    * High speed
    
Speed configuration is related to the speed of the transition of the output signal from the **Low** state to the **High** state and vice-versa. 

Alternative function configuration
**********************************

Every pin has addiotinal alternative functions that it can performe. This information can be found in the datasheed of the used MCU. Example of the datasheed for the STM32F407 can be found in the following image.

.. image:: images/hal-gpio-af.png


For example, to configure pin **PA2**  as an USART2-TX we will select alternative function 7. For the same pin, if we want to use it as an TIM2-CH3 we need to select alternative function 1. 
