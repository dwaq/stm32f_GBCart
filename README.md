stm32f_GBCart
=============

##How to build project:
1. mkdir Gameboy
2. cd Gameboy
3. git clone https://github.com/dwaq/stm32f_GBCart.git
4. cd stm32f_GBCart
5. Download STSW-STM32068 from http://www.st.com/web/en/catalog/tools/PF257904# and then cd to its directory
6. unzip stsw-stm32068.zip -d ~/Gameboy/
7. cd ~/Gameboy/stm32f_GBCart/linker
8. ./get_and_modify_linker.sh
9. move your Gameboy rom into ~/Gameboy/stm32f_GBCart/roms
10. cd ~/Gameboy/stm32f_GBCart/roms
11. ./create_rom.sh filename.gb
12. cd ..
13. make

Game Boy Cartridge emulation from a stm32f4 Development Board

I wrote about this project in my blog:

- https://dhole.github.io/post/gameboy_cartridge_emu_1/
- https://dhole.github.io/post/gameboy_cartridge_emu_2/
- https://dhole.github.io/post/gameboy_custom_logo/

## Description

This project implements the emulation of a gameboy cartridge using a stm32f4
Development Board. A real gameboy can be connected to a stm32f4 running this
software and load real roms as well as homebrew roms.

- ROM Only and MBC1 Cartridges are implemented. See a full list at:
	- http://www.devrs.com/gb/files/gbmbcsiz.txt
- RAM emulation implemented. The contents will be erased upon powering off the stm32f4
- Custom boot logo implemented. It will be shown only during the first boot.

## ROMs

In order to use a rom in the code, the file must be converted into a C array:
```
cp Tetris.gb rom.gb
xxd -i rom.gb | sed 's/unsigned/unsigned const/g' > tetris_rom.h
rm rom.gb
```

## Files

main.c: Main Program body.
> Initialization of the GPIOs.

stm32f4xx_it.c: Interrupt handlers.
> The interrupt handler for the rising flag trigger is defined here. It handles 
> the read and write operations of the gameboy to the cartridge.

### Custom logo

draw_logo.py: Draws a logo on a window
> Requieres pygame

make_logo.py: Converts a png logo image into a binary file to be used as a boot
logo
> Requieres pygame
```
./make_logo.py dhole_logo2.png dhole_logo2.bin
cp dhole_logo2.bin logo.bin
xxd -i logo.bin > dhole2_logo.h
rm logo.bin
```
