	.syntax unified
	.cpu cortex-m4
	.fpu softvfp
	.syntax unified
	.thumb

.global main

.equ DELAY_INTERVAL,	 0x186004

@******* Register definitions *******
@
@As per STM32F407 datasheet and reference manual

.equ RCC_AHB1ENR,		0x40023830	@Clock control for AHB1 peripherals (includes GPIO)

@GPIO-D control registers
.equ GPIOD_MODER,	0x40020C00	@set GPIO pin mode as Input/Output/Analog
.equ GPIOD_OTYPER,	0x40020C04	@Set GPIO pin type as push-pull or open drain
.equ GPIOD_OSPEEDR, 	0x40020C08	@Set GPIO pin switching speed
.equ GPIOD_PUPDR,		0x40020C0C	@Set GPIO pin pull-up/pull-down
.equ GPIOD_ODR,			0x40020C14	@GPIO pin output data

.text

main:
	@Enable GPIO clock
	ldr		r1, =RCC_AHB1ENR	@Pseudo-load address in R1
	ldr		r0, [r1]			@Copy contents at address in R1 to R0
	orr 	r0, #0x08			@Bitwise OR entire word in R0, result in R0
	str		r0, [r1]			@Store R0 contents to address in R1

	@Set mode as output
	ldr		r1, =GPIOD_MODER	@Two bits per pin so bits 24 to 31 control pins 12 to 15
	ldr		r0, [r1]
	orr 	r0, #0x55000000		@Mode bits set to '01' makes the pin mode as output
	and		r0, #0x55FFFFFF		@OR and AND both operations reqd for 2 bits
	str		r0, [r1]

	@Set type as push-pull	(Default)
	ldr		r1, =GPIOD_OTYPER	@Type bit '0' configures pin for push-pull
	ldr		r0, [r1]
	and 	r0, #0xFFFF0FFF
	str		r0, [r1]

	@Set Speed slow
	ldr		r1, =GPIOD_OSPEEDR	@Two bits per pin so bits 24 to 31 control pins 12 to 15
	ldr		r0, [r1]
	and 	r0, #0x00FFFFFF		@Speed bits set to '00' configures pin for slow speed
	str		r0, [r1]

	@Set pull-up
	ldr		r1, =GPIOD_PUPDR	@Two bits per pin so bits 24 to 31 control pins 12 to 15
	ldr		r0, [r1]
	and		r0, #0x00FFFFFF		@Clear bits to disable pullup/pulldown
	str		r0, [r1]

	B loop


loop:
	ldr		r1, =GPIOD_ODR
	ldr		r0, [r1]
	eor 	r0, #0xF000
	str		r0, [r1]

	bl delay
	b loop

delay:
	ldr		r5,=DELAY_INTERVAL
while:
	cmp 	r5,#0
	ITT		NE
	subne 	r5,#1
	bne		while
	bx r14







