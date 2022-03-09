	.syntax unified
	.cpu cortex-m4
	.fpu softvfp
	.thumb

.global  g_pfnVectors

/* start address for the initialization values of the .data section.
defined in linker script */
.word  _sidata
/* start address for the .data section. defined in linker script */
.word  _sdata
/* end address for the .data section. defined in linker script */
.word  _edata
/* start address for the .bss section. defined in linker script */
.word  _sbss
/* end address for the .bss section. defined in linker script */
.word  _ebss
/* stack used for SystemInit_ExtMemCtl; always internal RAM used */

#Initializing the Bare minimum vector table
  	.section  .isr_vector,"a",%progbits
  	.type  g_pfnVectors, %object
  	.size  g_pfnVectors, .-g_pfnVectors

g_pfnVectors:
  	.word  _estack
  	.word  Reset_Handler

 	.section .text.Reset_Handler
	.weak Reset_Handler
 	.type Reset_Handler, %function

Reset_Handler:
	b  LoopCopyDataInit

CopyDataInit:
  	ldr  r3, =_sidata
  	ldr  r3, [r3, r1]
  	str  r3, [r0, r1]
  	adds  r1, r1, #4

LoopCopyDataInit:
  	ldr  r0, =_sdata
  	ldr  r3, =_edata
  	adds  r2, r0, r1
  	cmp  r2, r3
  	bcc  CopyDataInit
  	ldr  r2, =_sbss
 	b  LoopFillZerobss
	/* Zero fill the bss segment. */
FillZerobss:
 	 movs  r3, #0
  	str  r3, [r2], #4

LoopFillZerobss:
  	ldr  r3, = _ebss
  	cmp  r2, r3
  	bcc  FillZerobss

 	bl main

