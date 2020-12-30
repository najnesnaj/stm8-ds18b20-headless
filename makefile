SDCC=sdcc
SDLD=sdcc
OBJECTS=blink.ihx 

.PHONY: all clean flash

all: $(OBJECTS)

clean:
	rm -f $(OBJECTS)

flash: blink.ihx
	stm8flash -c stlinkv2 -pstm8s103f3 -w blink.ihx
%.ihx: %.c stm8.h
	$(SDCC) -lstm8 -mstm8 --out-fmt-ihx $(CFLAGS) $(LDFLAGS) $<
	# stm8flash -c stlinkv2 -p stm8s103?3 -w ds18b20.ihx
	# minicom -b 115200 -D /dev/ttyUSB4
