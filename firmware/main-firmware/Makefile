include Makefile.variable
# Binaries will be generated with this name (.elf, .bin, .hex, etc)
PROJ_NAME=main

# Put your stlink folder here so make burn will work.
SDK = ./sdk

# Put your source files here (or *.c, etc)
SRCS = main.c 

# Normally you shouldn't need to change anything below this line!
#######################################################################################
CFLAGS  = -g -O2 -Wall -T$(SDK)/stm32_flash.ld 
CFLAGS += -mlittle-endian -mthumb -mcpu=cortex-m4 -mthumb-interwork
# important flag is -fsingle-precision-constant which prevents the double precision emulation
CFLAGS += -mfloat-abi=hard -mfpu=fpv4-sp-d16 -fsingle-precision-constant
CFLAGS += -I.

# Include files from STM libraries
CFLAGS += -I $(SDK)

# add startup file to build
SRCS += $(SDK)/startup_stm32f4xx.s 
SRCS += $(SDK)/system_stm32f4xx.c 
OBJS = $(SRCS:.c=.o)


.PHONY: proj

all: $(PROJ_NAME).elf

$(PROJ_NAME).elf: $(SRCS)
	$(CC) $(CFLAGS) $^ -lm -lc -lnosys -o $@ 
	$(CC) $(CFLAGS) -S $< $^
	$(OBJCOPY) -O ihex $(PROJ_NAME).elf $(PROJ_NAME).hex
	$(OBJCOPY) -O binary $(PROJ_NAME).elf $(PROJ_NAME).bin
	$(SIZE) -B  $(PROJ_NAME).elf
	ls -l $(PROJ_NAME).bin


clean:
	rm -rf *.o $(PROJ_NAME).elf $(PROJ_NAME).hex $(PROJ_NAME).bin *.s
	ls

# Flash the STM32F4

upload: proj
	@$(STM32CUBEPROG) -w $(PROJ_NAME).bin  0x08000000 
	@sleep 1
	@$(STM32CUBEPROG) -hardRst 

