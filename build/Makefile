PROJ = snake

$(PROJ).gba: $(PROJ).bin
	./data_copy.exe snake
$(PROJ).bin: $(PROJ).elf
	arm-agb-elf-objcopy.exe -O binary $(PROJ).elf $(PROJ).bin
	rm $(PROJ).elf   
$(PROJ).elf: $(PROJ).s
	arm-none-eabi-as.exe $(PROJ).s -o $(PROJ).elf
$(PROJ).s: ../source/*.s
	arm-none-eabi-cpp.exe ../source/main.s | grep "^[^#;]" > $(PROJ).s
    