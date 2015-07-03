# add "_exit = .;" to linker file and copy to local directory
awk -v n=78 -v s="    _exit = .;" 'NR == n {print s} {print}' ../../STM32F4-Discovery_FW_V1.1.0/Project/Peripheral_Examples/IO_Toggle/TrueSTUDIO/IO_Toggle/stm32_flash.ld  > stm32_flash.ld

