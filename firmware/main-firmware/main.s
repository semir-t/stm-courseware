	.cpu cortex-m4
	.eabi_attribute 27, 1
	.eabi_attribute 28, 1
	.eabi_attribute 20, 1
	.eabi_attribute 21, 1
	.eabi_attribute 23, 3
	.eabi_attribute 24, 1
	.eabi_attribute 25, 1
	.eabi_attribute 26, 1
	.eabi_attribute 30, 2
	.eabi_attribute 34, 1
	.eabi_attribute 18, 4
	.file	"main.c"
	.text
.Ltext0:
	.cfi_sections	.debug_frame
	.section	.text.startup,"ax",%progbits
	.align	1
	.p2align 2,,3
	.global	main
	.syntax unified
	.thumb
	.thumb_func
	.fpu fpv4-sp-d16
	.type	main, %function
main:
.LFB110:
	.file 1 "main.c"
	.loc 1 6 0
	.cfi_startproc
	@ Volatile: function does not return.
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	.loc 1 9 0
	ldr	r0, .L11
	.loc 1 10 0
	ldr	r2, .L11+4
	.loc 1 9 0
	ldr	r3, [r0, #48]
.LBB4:
.LBB5:
	.loc 1 27 0
	ldr	r1, .L11+8
.LBE5:
.LBE4:
	.loc 1 9 0
	orr	r3, r3, #8
	str	r3, [r0, #48]
	.loc 1 10 0
	ldr	r3, [r2]
	.loc 1 11 0
	movs	r0, #0
	.loc 1 10 0
	orr	r3, r3, #1426063360
	str	r3, [r2]
	.loc 1 11 0
	str	r0, [r2, #4]
	.loc 1 12 0
	ldr	r3, [r2, #8]
	mvn	r3, r3, lsl #12
	mvn	r3, r3, lsr #12
	str	r3, [r2, #8]
	.loc 1 14 0
	ldr	r3, [r2, #20]
	bic	r3, r3, #61440
	.loc 1 6 0
	sub	sp, sp, #8
	.cfi_def_cfa_offset 8
	.loc 1 14 0
	str	r3, [r2, #20]
.L4:
.LVL0:
.LBB7:
.LBB6:
	.loc 1 27 0 discriminator 1
	str	r1, [sp, #4]
	.loc 1 28 0 discriminator 1
	ldr	r3, [sp, #4]
	cbz	r3, .L2
.L3:
	.loc 1 30 0
	ldr	r3, [sp, #4]
	subs	r3, r3, #1
	str	r3, [sp, #4]
	.loc 1 28 0
	ldr	r3, [sp, #4]
	cmp	r3, #0
	bne	.L3
.L2:
.LVL1:
.LBE6:
.LBE7:
	.loc 1 19 0
	ldr	r3, [r2, #20]
	eor	r3, r3, #61440
	str	r3, [r2, #20]
	.loc 1 18 0
	b	.L4
.L12:
	.align	2
.L11:
	.word	1073887232
	.word	1073875968
	.word	10500000
	.cfi_endproc
.LFE110:
	.size	main, .-main
	.text
	.align	1
	.p2align 2,,3
	.global	delay_soft_ms
	.syntax unified
	.thumb
	.thumb_func
	.fpu fpv4-sp-d16
	.type	delay_soft_ms, %function
delay_soft_ms:
.LFB111:
	.loc 1 25 0
	.cfi_startproc
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
.LVL2:
	sub	sp, sp, #8
	.cfi_def_cfa_offset 8
	.loc 1 27 0
	movw	r3, #10500
	mul	r0, r3, r0
.LVL3:
	str	r0, [sp, #4]
	.loc 1 28 0
	ldr	r3, [sp, #4]
	cbz	r3, .L13
.L15:
	.loc 1 30 0
	ldr	r3, [sp, #4]
	subs	r3, r3, #1
	str	r3, [sp, #4]
	.loc 1 28 0
	ldr	r3, [sp, #4]
	cmp	r3, #0
	bne	.L15
.L13:
	.loc 1 33 0
	add	sp, sp, #8
	.cfi_def_cfa_offset 0
	@ sp needed
	bx	lr
	.cfi_endproc
.LFE111:
	.size	delay_soft_ms, .-delay_soft_ms
.Letext0:
	.file 2 "/home/semir/Dropbox/MCU/gcc/gcc-arm-none-eabi-7-2018-q2-update/arm-none-eabi/include/machine/_default_types.h"
	.file 3 "/home/semir/Dropbox/MCU/gcc/gcc-arm-none-eabi-7-2018-q2-update/arm-none-eabi/include/sys/_stdint.h"
	.file 4 "./sdk/core_cm4.h"
	.file 5 "./sdk/system_stm32f4xx.h"
	.file 6 "./sdk/stm32f4xx.h"
	.section	.debug_info,"",%progbits
.Ldebug_info0:
	.4byte	0x3ad
	.2byte	0x4
	.4byte	.Ldebug_abbrev0
	.byte	0x4
	.uleb128 0x1
	.4byte	.LASF53
	.byte	0xc
	.4byte	.LASF54
	.4byte	.LASF55
	.4byte	.Ldebug_ranges0+0x18
	.4byte	0
	.4byte	.Ldebug_line0
	.uleb128 0x2
	.byte	0x1
	.byte	0x6
	.4byte	.LASF0
	.uleb128 0x2
	.byte	0x1
	.byte	0x8
	.4byte	.LASF1
	.uleb128 0x2
	.byte	0x2
	.byte	0x5
	.4byte	.LASF2
	.uleb128 0x3
	.4byte	.LASF4
	.byte	0x2
	.byte	0x39
	.4byte	0x45
	.uleb128 0x2
	.byte	0x2
	.byte	0x7
	.4byte	.LASF3
	.uleb128 0x3
	.4byte	.LASF5
	.byte	0x2
	.byte	0x4d
	.4byte	0x57
	.uleb128 0x2
	.byte	0x4
	.byte	0x5
	.4byte	.LASF6
	.uleb128 0x3
	.4byte	.LASF7
	.byte	0x2
	.byte	0x4f
	.4byte	0x69
	.uleb128 0x2
	.byte	0x4
	.byte	0x7
	.4byte	.LASF8
	.uleb128 0x2
	.byte	0x8
	.byte	0x5
	.4byte	.LASF9
	.uleb128 0x2
	.byte	0x8
	.byte	0x7
	.4byte	.LASF10
	.uleb128 0x4
	.byte	0x4
	.byte	0x5
	.ascii	"int\000"
	.uleb128 0x2
	.byte	0x4
	.byte	0x7
	.4byte	.LASF11
	.uleb128 0x3
	.4byte	.LASF12
	.byte	0x3
	.byte	0x24
	.4byte	0x3a
	.uleb128 0x5
	.4byte	0x8c
	.uleb128 0x3
	.4byte	.LASF13
	.byte	0x3
	.byte	0x2c
	.4byte	0x4c
	.uleb128 0x5
	.4byte	0x9c
	.uleb128 0x3
	.4byte	.LASF14
	.byte	0x3
	.byte	0x30
	.4byte	0x5e
	.uleb128 0x5
	.4byte	0xac
	.uleb128 0x6
	.4byte	.LASF15
	.byte	0x4
	.2byte	0x51b
	.4byte	0xa7
	.uleb128 0x7
	.4byte	.LASF16
	.byte	0x5
	.byte	0x35
	.4byte	0xac
	.uleb128 0x8
	.4byte	0xac
	.4byte	0xe3
	.uleb128 0x9
	.4byte	0x85
	.byte	0x1
	.byte	0
	.uleb128 0xa
	.byte	0x28
	.byte	0x6
	.2byte	0x28e
	.4byte	0x16f
	.uleb128 0xb
	.4byte	.LASF17
	.byte	0x6
	.2byte	0x290
	.4byte	0xb7
	.byte	0
	.uleb128 0xb
	.4byte	.LASF18
	.byte	0x6
	.2byte	0x291
	.4byte	0xb7
	.byte	0x4
	.uleb128 0xb
	.4byte	.LASF19
	.byte	0x6
	.2byte	0x292
	.4byte	0xb7
	.byte	0x8
	.uleb128 0xb
	.4byte	.LASF20
	.byte	0x6
	.2byte	0x293
	.4byte	0xb7
	.byte	0xc
	.uleb128 0xc
	.ascii	"IDR\000"
	.byte	0x6
	.2byte	0x294
	.4byte	0xb7
	.byte	0x10
	.uleb128 0xc
	.ascii	"ODR\000"
	.byte	0x6
	.2byte	0x295
	.4byte	0xb7
	.byte	0x14
	.uleb128 0xb
	.4byte	.LASF21
	.byte	0x6
	.2byte	0x296
	.4byte	0x97
	.byte	0x18
	.uleb128 0xb
	.4byte	.LASF22
	.byte	0x6
	.2byte	0x297
	.4byte	0x97
	.byte	0x1a
	.uleb128 0xb
	.4byte	.LASF23
	.byte	0x6
	.2byte	0x298
	.4byte	0xb7
	.byte	0x1c
	.uleb128 0xc
	.ascii	"AFR\000"
	.byte	0x6
	.2byte	0x299
	.4byte	0x17f
	.byte	0x20
	.byte	0
	.uleb128 0x8
	.4byte	0xb7
	.4byte	0x17f
	.uleb128 0x9
	.4byte	0x85
	.byte	0x1
	.byte	0
	.uleb128 0x5
	.4byte	0x16f
	.uleb128 0xd
	.4byte	.LASF24
	.byte	0x6
	.2byte	0x29a
	.4byte	0xe3
	.uleb128 0xa
	.byte	0x88
	.byte	0x6
	.2byte	0x2dd
	.4byte	0x31f
	.uleb128 0xc
	.ascii	"CR\000"
	.byte	0x6
	.2byte	0x2df
	.4byte	0xb7
	.byte	0
	.uleb128 0xb
	.4byte	.LASF25
	.byte	0x6
	.2byte	0x2e0
	.4byte	0xb7
	.byte	0x4
	.uleb128 0xb
	.4byte	.LASF26
	.byte	0x6
	.2byte	0x2e1
	.4byte	0xb7
	.byte	0x8
	.uleb128 0xc
	.ascii	"CIR\000"
	.byte	0x6
	.2byte	0x2e2
	.4byte	0xb7
	.byte	0xc
	.uleb128 0xb
	.4byte	.LASF27
	.byte	0x6
	.2byte	0x2e3
	.4byte	0xb7
	.byte	0x10
	.uleb128 0xb
	.4byte	.LASF28
	.byte	0x6
	.2byte	0x2e4
	.4byte	0xb7
	.byte	0x14
	.uleb128 0xb
	.4byte	.LASF29
	.byte	0x6
	.2byte	0x2e5
	.4byte	0xb7
	.byte	0x18
	.uleb128 0xb
	.4byte	.LASF30
	.byte	0x6
	.2byte	0x2e6
	.4byte	0xac
	.byte	0x1c
	.uleb128 0xb
	.4byte	.LASF31
	.byte	0x6
	.2byte	0x2e7
	.4byte	0xb7
	.byte	0x20
	.uleb128 0xb
	.4byte	.LASF32
	.byte	0x6
	.2byte	0x2e8
	.4byte	0xb7
	.byte	0x24
	.uleb128 0xb
	.4byte	.LASF33
	.byte	0x6
	.2byte	0x2e9
	.4byte	0xd3
	.byte	0x28
	.uleb128 0xb
	.4byte	.LASF34
	.byte	0x6
	.2byte	0x2ea
	.4byte	0xb7
	.byte	0x30
	.uleb128 0xb
	.4byte	.LASF35
	.byte	0x6
	.2byte	0x2eb
	.4byte	0xb7
	.byte	0x34
	.uleb128 0xb
	.4byte	.LASF36
	.byte	0x6
	.2byte	0x2ec
	.4byte	0xb7
	.byte	0x38
	.uleb128 0xb
	.4byte	.LASF37
	.byte	0x6
	.2byte	0x2ed
	.4byte	0xac
	.byte	0x3c
	.uleb128 0xb
	.4byte	.LASF38
	.byte	0x6
	.2byte	0x2ee
	.4byte	0xb7
	.byte	0x40
	.uleb128 0xb
	.4byte	.LASF39
	.byte	0x6
	.2byte	0x2ef
	.4byte	0xb7
	.byte	0x44
	.uleb128 0xb
	.4byte	.LASF40
	.byte	0x6
	.2byte	0x2f0
	.4byte	0xd3
	.byte	0x48
	.uleb128 0xb
	.4byte	.LASF41
	.byte	0x6
	.2byte	0x2f1
	.4byte	0xb7
	.byte	0x50
	.uleb128 0xb
	.4byte	.LASF42
	.byte	0x6
	.2byte	0x2f2
	.4byte	0xb7
	.byte	0x54
	.uleb128 0xb
	.4byte	.LASF43
	.byte	0x6
	.2byte	0x2f3
	.4byte	0xb7
	.byte	0x58
	.uleb128 0xb
	.4byte	.LASF44
	.byte	0x6
	.2byte	0x2f4
	.4byte	0xac
	.byte	0x5c
	.uleb128 0xb
	.4byte	.LASF45
	.byte	0x6
	.2byte	0x2f5
	.4byte	0xb7
	.byte	0x60
	.uleb128 0xb
	.4byte	.LASF46
	.byte	0x6
	.2byte	0x2f6
	.4byte	0xb7
	.byte	0x64
	.uleb128 0xb
	.4byte	.LASF47
	.byte	0x6
	.2byte	0x2f7
	.4byte	0xd3
	.byte	0x68
	.uleb128 0xb
	.4byte	.LASF48
	.byte	0x6
	.2byte	0x2f8
	.4byte	0xb7
	.byte	0x70
	.uleb128 0xc
	.ascii	"CSR\000"
	.byte	0x6
	.2byte	0x2f9
	.4byte	0xb7
	.byte	0x74
	.uleb128 0xb
	.4byte	.LASF49
	.byte	0x6
	.2byte	0x2fa
	.4byte	0xd3
	.byte	0x78
	.uleb128 0xb
	.4byte	.LASF50
	.byte	0x6
	.2byte	0x2fb
	.4byte	0xb7
	.byte	0x80
	.uleb128 0xb
	.4byte	.LASF51
	.byte	0x6
	.2byte	0x2fc
	.4byte	0xb7
	.byte	0x84
	.byte	0
	.uleb128 0xd
	.4byte	.LASF52
	.byte	0x6
	.2byte	0x2fd
	.4byte	0x190
	.uleb128 0xe
	.4byte	.LASF56
	.byte	0x1
	.byte	0x18
	.byte	0x1
	.4byte	0x34e
	.uleb128 0xf
	.ascii	"cnt\000"
	.byte	0x1
	.byte	0x18
	.4byte	0xac
	.uleb128 0x10
	.4byte	.LASF57
	.byte	0x1
	.byte	0x1b
	.4byte	0xb7
	.byte	0
	.uleb128 0x11
	.4byte	.LASF58
	.byte	0x1
	.byte	0x5
	.4byte	0x7e
	.4byte	.LFB110
	.4byte	.LFE110-.LFB110
	.uleb128 0x1
	.byte	0x9c
	.4byte	0x38f
	.uleb128 0x12
	.4byte	0x32b
	.4byte	.LBB4
	.4byte	.Ldebug_ranges0+0
	.byte	0x1
	.byte	0x12
	.uleb128 0x13
	.4byte	0x337
	.4byte	.LLST0
	.uleb128 0x14
	.4byte	.Ldebug_ranges0+0
	.uleb128 0x15
	.4byte	0x342
	.uleb128 0x2
	.byte	0x91
	.sleb128 -4
	.byte	0
	.byte	0
	.byte	0
	.uleb128 0x16
	.4byte	0x32b
	.4byte	.LFB111
	.4byte	.LFE111-.LFB111
	.uleb128 0x1
	.byte	0x9c
	.uleb128 0x13
	.4byte	0x337
	.4byte	.LLST1
	.uleb128 0x15
	.4byte	0x342
	.uleb128 0x2
	.byte	0x91
	.sleb128 -4
	.byte	0
	.byte	0
	.section	.debug_abbrev,"",%progbits
.Ldebug_abbrev0:
	.uleb128 0x1
	.uleb128 0x11
	.byte	0x1
	.uleb128 0x25
	.uleb128 0xe
	.uleb128 0x13
	.uleb128 0xb
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x1b
	.uleb128 0xe
	.uleb128 0x55
	.uleb128 0x17
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x10
	.uleb128 0x17
	.byte	0
	.byte	0
	.uleb128 0x2
	.uleb128 0x24
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3e
	.uleb128 0xb
	.uleb128 0x3
	.uleb128 0xe
	.byte	0
	.byte	0
	.uleb128 0x3
	.uleb128 0x16
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x4
	.uleb128 0x24
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3e
	.uleb128 0xb
	.uleb128 0x3
	.uleb128 0x8
	.byte	0
	.byte	0
	.uleb128 0x5
	.uleb128 0x35
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x6
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3c
	.uleb128 0x19
	.byte	0
	.byte	0
	.uleb128 0x7
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3c
	.uleb128 0x19
	.byte	0
	.byte	0
	.uleb128 0x8
	.uleb128 0x1
	.byte	0x1
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x9
	.uleb128 0x21
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2f
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0xa
	.uleb128 0x13
	.byte	0x1
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0xb
	.uleb128 0xd
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x38
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0xc
	.uleb128 0xd
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x38
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0xd
	.uleb128 0x16
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0xe
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x27
	.uleb128 0x19
	.uleb128 0x20
	.uleb128 0xb
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0xf
	.uleb128 0x5
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x10
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x11
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x27
	.uleb128 0x19
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x6
	.uleb128 0x40
	.uleb128 0x18
	.uleb128 0x2117
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x12
	.uleb128 0x1d
	.byte	0x1
	.uleb128 0x31
	.uleb128 0x13
	.uleb128 0x52
	.uleb128 0x1
	.uleb128 0x55
	.uleb128 0x17
	.uleb128 0x58
	.uleb128 0xb
	.uleb128 0x59
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0x13
	.uleb128 0x5
	.byte	0
	.uleb128 0x31
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x17
	.byte	0
	.byte	0
	.uleb128 0x14
	.uleb128 0xb
	.byte	0x1
	.uleb128 0x55
	.uleb128 0x17
	.byte	0
	.byte	0
	.uleb128 0x15
	.uleb128 0x34
	.byte	0
	.uleb128 0x31
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x18
	.byte	0
	.byte	0
	.uleb128 0x16
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x31
	.uleb128 0x13
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x6
	.uleb128 0x40
	.uleb128 0x18
	.uleb128 0x2117
	.uleb128 0x19
	.byte	0
	.byte	0
	.byte	0
	.section	.debug_loc,"",%progbits
.Ldebug_loc0:
.LLST0:
	.4byte	.LVL0
	.4byte	.LVL1
	.2byte	0x4
	.byte	0xa
	.2byte	0x3e8
	.byte	0x9f
	.4byte	0
	.4byte	0
.LLST1:
	.4byte	.LVL2
	.4byte	.LVL3
	.2byte	0x1
	.byte	0x50
	.4byte	.LVL3
	.4byte	.LFE111
	.2byte	0x4
	.byte	0xf3
	.uleb128 0x1
	.byte	0x50
	.byte	0x9f
	.4byte	0
	.4byte	0
	.section	.debug_aranges,"",%progbits
	.4byte	0x24
	.2byte	0x2
	.4byte	.Ldebug_info0
	.byte	0x4
	.byte	0
	.2byte	0
	.2byte	0
	.4byte	.Ltext0
	.4byte	.Letext0-.Ltext0
	.4byte	.LFB110
	.4byte	.LFE110-.LFB110
	.4byte	0
	.4byte	0
	.section	.debug_ranges,"",%progbits
.Ldebug_ranges0:
	.4byte	.LBB4
	.4byte	.LBE4
	.4byte	.LBB7
	.4byte	.LBE7
	.4byte	0
	.4byte	0
	.4byte	.Ltext0
	.4byte	.Letext0
	.4byte	.LFB110
	.4byte	.LFE110
	.4byte	0
	.4byte	0
	.section	.debug_line,"",%progbits
.Ldebug_line0:
	.section	.debug_str,"MS",%progbits,1
.LASF41:
	.ascii	"AHB1LPENR\000"
.LASF31:
	.ascii	"APB1RSTR\000"
.LASF35:
	.ascii	"AHB2ENR\000"
.LASF55:
	.ascii	"/home/semir/Dropbox/github/gh-action-test/firmware/"
	.ascii	"main-firmware\000"
.LASF2:
	.ascii	"short int\000"
.LASF56:
	.ascii	"delay_soft_ms\000"
.LASF48:
	.ascii	"BDCR\000"
.LASF51:
	.ascii	"PLLI2SCFGR\000"
.LASF58:
	.ascii	"main\000"
.LASF7:
	.ascii	"__uint32_t\000"
.LASF4:
	.ascii	"__uint16_t\000"
.LASF50:
	.ascii	"SSCGR\000"
.LASF43:
	.ascii	"AHB3LPENR\000"
.LASF26:
	.ascii	"CFGR\000"
.LASF40:
	.ascii	"RESERVED3\000"
.LASF44:
	.ascii	"RESERVED4\000"
.LASF38:
	.ascii	"APB1ENR\000"
.LASF18:
	.ascii	"OTYPER\000"
.LASF36:
	.ascii	"AHB3ENR\000"
.LASF9:
	.ascii	"long long int\000"
.LASF20:
	.ascii	"PUPDR\000"
.LASF6:
	.ascii	"long int\000"
.LASF52:
	.ascii	"RCC_TypeDef\000"
.LASF22:
	.ascii	"BSRRH\000"
.LASF17:
	.ascii	"MODER\000"
.LASF32:
	.ascii	"APB2RSTR\000"
.LASF21:
	.ascii	"BSRRL\000"
.LASF1:
	.ascii	"unsigned char\000"
.LASF39:
	.ascii	"APB2ENR\000"
.LASF0:
	.ascii	"signed char\000"
.LASF10:
	.ascii	"long long unsigned int\000"
.LASF14:
	.ascii	"uint32_t\000"
.LASF11:
	.ascii	"unsigned int\000"
.LASF28:
	.ascii	"AHB2RSTR\000"
.LASF12:
	.ascii	"uint16_t\000"
.LASF8:
	.ascii	"long unsigned int\000"
.LASF57:
	.ascii	"time\000"
.LASF25:
	.ascii	"PLLCFGR\000"
.LASF3:
	.ascii	"short unsigned int\000"
.LASF45:
	.ascii	"APB1LPENR\000"
.LASF53:
	.ascii	"GNU C11 7.3.1 20180622 (release) [ARM/embedded-7-br"
	.ascii	"anch revision 261907] -mlittle-endian -mthumb -mcpu"
	.ascii	"=cortex-m4 -mthumb-interwork -mfloat-abi=hard -mfpu"
	.ascii	"=fpv4-sp-d16 -g -O2 -fsingle-precision-constant\000"
.LASF13:
	.ascii	"int32_t\000"
.LASF16:
	.ascii	"SystemCoreClock\000"
.LASF42:
	.ascii	"AHB2LPENR\000"
.LASF30:
	.ascii	"RESERVED0\000"
.LASF33:
	.ascii	"RESERVED1\000"
.LASF37:
	.ascii	"RESERVED2\000"
.LASF19:
	.ascii	"OSPEEDR\000"
.LASF54:
	.ascii	"main.c\000"
.LASF47:
	.ascii	"RESERVED5\000"
.LASF49:
	.ascii	"RESERVED6\000"
.LASF34:
	.ascii	"AHB1ENR\000"
.LASF5:
	.ascii	"__int32_t\000"
.LASF27:
	.ascii	"AHB1RSTR\000"
.LASF24:
	.ascii	"GPIO_TypeDef\000"
.LASF29:
	.ascii	"AHB3RSTR\000"
.LASF15:
	.ascii	"ITM_RxBuffer\000"
.LASF23:
	.ascii	"LCKR\000"
.LASF46:
	.ascii	"APB2LPENR\000"
	.ident	"GCC: (GNU Tools for Arm Embedded Processors 7-2018-q2-update) 7.3.1 20180622 (release) [ARM/embedded-7-branch revision 261907]"
