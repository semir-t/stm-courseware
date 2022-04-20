Timers
******

A Timer Module in its most basic form is a digital logic circuit that counts up every clock cycle. More functionalities are implemented in hardware to support the timer module so it can count up or down. It can have a Prescaler to divide the input clock frequency by a selectable value. It can also have circuitry for input capture, PWM signal generation, and much more



The timers in a STM32 micro can be classified as follows:

    * Advanced Timers
    * General Purpose Timers
    * Basic Timers
    * Low power
    
Block diagram
=============

Following image represents the block diagram of the Advance Timer Peripheral of the STM32F4xx MCU. Internal block structure for different types of Timers and on different MCUs may vary, but the logic behind the timers is always the same.

.. image:: images/hal-timer-block-diagram.png

By looking at the previous image, we can divide Timer internal structure to 4 parts:
    * Clock selection and configuration block
    * Prescaler and Counter block
    * Output capture block
    * Input capture block


Clock selection and configuration block
---------------------------------------

.. image:: images/hal-timer-block-diagram-1.png

This subblock is shown on the previous image. We can see that clock source for the timer can be:
    * Internal clock source
    * External trigger (from the external pin)
    * Internal trigger
    * Encoder interface
    
Selected clock source for the timer can also be forwarded to other peripherals like DAC,ADC and other timer through TRG0 line.

Prescale and Counter block
--------------------------

Following image represents the prescaler and counter block.

.. image:: images/hal-timer-block-diagram-2.png

This block consists of:
    * Prescaler - Used to reduce the frequency of the clock source
    * Counter - Measures number of positiv edges of the clock source
    
Depending on the timer type, Prescaler value can be arbitraty number or there is a small range of numbers that can be used to divide the clock source. Also, depeding on the timer type, Counter can be 8,16, or 32 bit wide. For STM32F4xx we have 16b and 32b timers.

Output capture block
--------------------

STM32F4xx timer can have up to 6 capture channels. This channels are used to compare the current value of the counter and values stored to the capture channels. When the value of the timer is equal or greater to the value stored inside the capture channel, different actions can be executed. Some of this actions are:
    * Flip the state of the dedicated pin
    * Run the IRQ Handler
    * Start the DMA transaction
    
.. image:: images/hal-timer-block-diagram-3.png

This block is often used to generate different square wave signals. Most of the time, we will use this feature to generate the PWM signal.

Input capture block
-------------------

.. image:: images/hal-timer-block-diagram-4.png


Input capture block can be used to measure the signal width and frequency. When the transition of the singal on the dedicated pin is detected, current counter value will be stored to the dedicated compare channel. We can then use this information in combination with the frequency of the timers clock to calculate the widht of the signal of frequency.

Mode of operation
=================

An STM32 timer module can operate in any of the following modes, however, you should not assume that a given timer does support all of these modes. Instead, you’ll have to check the datasheet to figure out which modes are supported by which timers. As we’ve seen earlier, there are many groups of timers which include: General-Purpose, Low-Power, Basic, Advanced-Control timers. Each of which does support a multiple of the following modes, however, some timers do support most of the operating modes.

In this section, we’ll get just a brief description of each mode of operation. How it works and what sort of applications it fits for. Each mode will be discussed in-depth with practical LAB experiments in future tutorials. But for today, we’ll get into Timer Mode in section4 and do its LAB in the next tutorial. Other modes will be coming later on in this series of tutorials.

Timer Mode
----------

In timer mode, the timer module gets clocked from an internal clock source with a known frequency. Hence the clocking frequency is known, the overflow time can also be calculated and controlled by the preload register to get any arbitrarily chosen time interval. Each timer overflow, the timer signals the CPU with an interrupt that indicates the end of the specified time interval.

This mode of operation is usually used to get a specific operation done each specific time interval. And to achieve timing & sync between various tasks and events in the system. It can also replace delays in various situations for better system response.

STM32 Timers Explained Tutorial With Modes PWM Encoder

.. image:: images/hal-timer-mode.png

Counter Mode
------------

In counter mode, the timer module gets clocked from an external source (timer input pin). So the timer counts up or down on each rising or falling edge of the external input. This mode is really helpful in numerous situations when you need to implement a digital counter without polling input pins or periodically reading a GPIO or continuously interrupt the CPU if you’ve chosen to hook it up to an EXTI pin.

You can actually monitor the counter value difference each time interval to tell how many pulses did occur or what was the frequency of it. Such a mode can be advantageous in many situations like this. And more examples are to come in upcoming tutorials.

.. image:: images/hal-timer-counter-mode.png

PWM Mode
--------

In PWM mode, the timer module is clocked from an internal clock source and produces a digital waveform on the output channel pin called the PWM signal. By using output compare registers (OCR), the incrementing timer’s register value is constantly compared against this OCR register. When a match occurs the output pin state is flipped until the end of the period and the whole process is repeated.

The timer in PWM mode will produce a PWM signal at the specified frequency the user chose. The duty cycle is also programmatically controlled by its register. The PWM resolution is affected by the desired FPWM and other factors as we’ll see in the dedicated tutorials for PWM generation.

.. image:: images/hal-timer-pwm-fade.gif

Advanced PWM Mode
-----------------

The advanced PWM signal generation refers to the hardware ability to control more parameters and add some hardware circuitry to support extra features for the PWM signal generation. Which includes:

    The ability to produce a complementary PWM signal that is typically the same as the PWM on the main channel but logically inverted (high portion becomes low and vice versa).
    The ability to inject dead-time band in the PWM signal for motor driving applications to prevent shoot-through currents that result from PWM signals overlapping.
    The ability to perform auto-shutdown for the PWM signal, it’s also called “auto brake” which an important feature for safety-critical applications.
    And the ability to phase-adjust the PWM signal, and much more! All of this is referred to as advanced-PWM control.

Here is an example for PWM channels with complementary waveform output, with dead-band inserted, and phase-delay adjustment. A typical control signal in half-bridge mode.

.. image:: images/hal-timer-advance-pwm.png

Output Compare Mode
-------------------

In output compare mode, a timer module controls an output waveform or indicates when a period of time has elapsed. When a match is detected between the output compare register (OCR) and the counter, the output compare function assigns the corresponding output pin to a programmable value defined by the output
compare mode defined by the programmer.

The output compare pin can be driven high, low, toggles its sate, or stay unchanged. This is determined by the programmer as per the application requirements. This mode of operation can be extremely advantageous for generating timing signals and output driving in many applications as we’ll see in future tutorials.

Here is an example for a counting timer in output compare mode. Note when the output state is changed (toggled) and the value in the OCR (compare register TIM1_CCR1).

.. image:: images/hal-timer-output-compare.png

One-Pulse Mode
--------------

One-pulse mode (OPM) is a particular case of the previous modes. It allows the counter to be started in response to a stimulus and to generate a pulse with a programmable length after a programmable delay. Starting the counter can be controlled through the slave mode controller. Generating the waveform can be done in output compare mode or PWM mode.

A pulse can be correctly generated only if the compare value is different from the counter initial value. Before starting (when the timer is waiting for the trigger), the configuration must be CNT<CCRx ≤ ARR (in particular, 0<CCRx). For example, you may want to generate a positive pulse on OC1 with a length of tPULSE and after a delay of tDELAY as soon as a positive edge is detected on the TI2 input pin.

.. image:: images/hal-timer-one-pulse.png

Input Capture Mode
------------------

In Input capture mode, the Capture/Compare Registers (TIMx_CCRx) are used to latch the value of the counter after a transition detected by the corresponding ICx signal. When a capture occurs, the corresponding CCXIF flag (TIMx_SR register) is set and an interrupt or a DMA request can be sent if they are enabled.

This mode is extremely important for external signal measurement or external event timing detection. The current value of the timer counts is captured when an external event occurs and an interrupt is fired. So, we can use this feature for a wide range of measurement applications.

An application example is an ultrasonic sensor that measures the distance and sends the information as a pulse to your microcontroller. By measuring the pulse width time, you can find out the distance reading. This can be achieved by using the input capture unit (ICU) within the timer module.

Encoder Mode
------------

In the encoder interface mode, the timer module operates as a digital counter with two inputs. The counter is clocked by each valid transition on both input pins. The sequence of transitions of the two inputs is evaluated and generates count pulses as well as the direction signal. Depending on the sequence the counter counts up or down. So you don’t have to detect these pulses individually and see which came first to detect rotation direction and this kind of work. Now, all of this is done by hardware thanks to the encoder mode hardware support.

The timer, when configured in Encoder Interface mode provides information on the sensor’s current position. The user can obtain dynamic information (speed, acceleration, deceleration) by measuring the period between two encoder events using a second timer configured in capture mode. The output of the encoder which indicates the mechanical zero can be used for this purpose. Depending on the time between two events, the counter can also be read at regular times.

.. image:: images/hal-timer-encoder.png

Timer Gate Mode
---------------

In timer gated mode, a timer module is also said to be working in “slave mode”. Where it only counts as long as an external input pin is held high or low. This input pin is said to be the timer gate that allows the timer to count or not at all.

This mode can be used in a wide range of applications and signal measurements. It can help you measure extremely short pulses with a very high resolution. And also trigger the timer to count on external events from sensors or other MCUs.

The counter starts counting on the internal clock as long as TI1 is low and stops as soon as TI1 becomes high. The TIF flag in the TIMx_SR register is set both when the counter starts or stops. The delay between the rising edge on TI1 and the actual stop of the counter is due to the resynchronization circuit on TI1 input.
STM32 Timer Module Gated Mode Hardware - STM32 Timers Explained Tutorial

.. image:: images/hal-timer-gate-mode.png

Timer DMA Burst Mode
--------------------

The STM32 timers, not all of them, have the capability to generate multiple DMA requests upon a single event. The main purpose is to be able to re-program part of the timer multiple times without software overhead, but it can also be used to read several registers in a row, at regular intervals.


IRTIM Infrared Mode
-------------------

An infrared interface (IRTIM) for remote control can be used with an infrared LED to perform remote control functions. It uses internal connections with TIM15 and TIM16 as shown in the diagram down below. To generate the infrared remote control signals, the IR interface must be enabled and TIM15 channel 1 (TIM15_OC1) and TIM16 channel 1 (TIM16_OC1) must be properly configured to generate correct waveforms. The infrared receiver can be implemented easily through a basic input capture mode.

.. image:: images/hal-timer-irtim.png 

All standard IR pulse modulation modes can be obtained by programming the two-timer output compare channels. TIM15 is used to generate the high-frequency carrier signal, while TIM16 generates the modulation envelope. The infrared function is output on the IR_OUT pin. The activation of this function is done through the GPIOx_AFRx register by enabling the related alternate function bit.


