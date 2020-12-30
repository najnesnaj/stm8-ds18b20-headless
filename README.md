temperature measurement using stm8 and ds18b20 and No display (headless)
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


- measure temperature
- use LED to send the temperature to a smartwatch HR sensor


The nrf52832 (which is used in the zephyr smartwatch project) cannot deal with the single wire protocol.
Hence, guess there will be no drivers for the ds18b20-temp sensor....

So, the idea is to have the stm8 transmit light-pulses to the heartrate sensor of a smartwatch, thus function as an external sensor.

The heartrate sensor can notice the difference between a long and an short light-pulse.
The protocol is based on 8-bit.
It sends out 2 times 8-bit as the start of the message.
Next is the the sensor-ID (ID) and the value.




As far as software packages, you'll need at the very least, the SDCC compiler and a way to upload the resulting IHX file to the device:

(on linux)
apt-get install sdcc

(optional if you want serial comms back to the host) apt-get install minicom

git clone http://github.com/vdudouyt/stm8flash
cd stm8flash
make
make install

The hardware programmer is sold on Ebay for around $4 each. Look for "st-link v2". Note that a hardware programmer is required to program the stm8 family. There is not a serial uploader installed like the stm32 has.


I used serial port of Orange Pi for debugging : #minicom -b 115200 -D /dev/ttyS1 (pin 38 - 40 on the GPIO)

Optional but extremely useful:
Saleae Logic Analyzer (About $7 each) -- to see up to 8 channels of digital waveform. EXTREMELY useful for debugging I2C. Seriously...

