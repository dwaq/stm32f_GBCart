# Location of stsw-stm32068
STM_COMMON = ../STM32F4-Discovery_FW_V1.1.0

# Tools used to compile our code
CC = arm-none-eabi-gcc
OBJCOPY = arm-none-eabi-objcopy

# Binaries will be generated with this name (.elf, .bin, .hex, etc)
PROJ_NAME = gbcart

# Our modified source code
SRCS  = src/main.c src/stm32f4xx_it.c

# System clock configuration
SRCS += $(STM_COMMON)/Libraries/CMSIS/ST/STM32F4xx/Source/Templates/system_stm32f4xx.c

# Library modules
SRCS += stm32f4xx_exti.c
SRCS += stm32f4xx_gpio.c
SRCS += stm32f4xx_rcc.c
SRCS += stm32f4xx_syscfg.c
SRCS += misc.c

# Location of linker
#LINKER = $(STM_COMMON)/Project/Peripheral_Examples/IO_Toggle/TrueSTUDIO/IO_Toggle/stm32_flash.ld
LINKER = ./linker/stm32_flash.ld

# Compiler settings
CFLAGS  = -g -O2 -Wall -T $(LINKER)
CFLAGS += -DUSE_STDPERIPH_DRIVER
CFLAGS += -mlittle-endian -mthumb -mcpu=cortex-m4 -mthumb-interwork
CFLAGS += -mfloat-abi=hard -mfpu=fpv4-sp-d16
CFLAGS += -I./inc

# Include files from STM libraries
CFLAGS += -I$(STM_COMMON)/Utilities/STM32F4-Discovery
CFLAGS += -I$(STM_COMMON)/Libraries/CMSIS/Include 
CFLAGS += -I$(STM_COMMON)/Libraries/CMSIS/ST/STM32F4xx/Include
CFLAGS += -I$(STM_COMMON)/Libraries/STM32F4xx_StdPeriph_Driver/inc
# uses stm32f4xx_conf.h from this location
CFLAGS += -I$(STM_COMMON)/Project/Demonstration/

# add startup file to build
SRCS += $(STM_COMMON)/Libraries/CMSIS/ST/STM32F4xx/Source/Templates/TrueSTUDIO/startup_stm32f4xx.s 

OBJS = $(SRCS:.c=.o)

vpath %.c $(STM_COMMON)/Libraries/STM32F4xx_StdPeriph_Driver/src $(STM_COMMON)/Utilities/STM32F4-Discovery

.PHONY: proj

all: proj

proj: $(PROJ_NAME).elf

$(PROJ_NAME).elf: $(SRCS)
	$(CC) $(CFLAGS) $^ -o $@ 
	$(OBJCOPY) -O ihex $(PROJ_NAME).elf $(PROJ_NAME).hex
	$(OBJCOPY) -O binary $(PROJ_NAME).elf $(PROJ_NAME).bin

# Remove compiled files
clean:
	rm -f *.o
	rm -f $(PROJ_NAME).elf
	rm -f $(PROJ_NAME).hex
	rm -f $(PROJ_NAME).bin

# Flash the STM32F4
burn: proj
	st-flash write $(PROJ_NAME).bin 0x8000000
